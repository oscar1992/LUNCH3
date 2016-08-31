//
//  ContenedorProductos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 20/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ContenedorProductos: UIView {
    
    var pestanasA = [PestanasProductos]();
    let barraInformacion = UIView();
    var barraBusqueda : UIView?;
    var scrol : ScrollResultados?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        var c = CGFloat(0);
        IniciaBarraInformacion();
        
        for _ in 0..<4{
            
            let ancho=CGFloat(self.frame.width/4);
            
            let pestanas=PestanasProductos(frame: CGRectMake((0+(c*(ancho))), (barraInformacion.frame.origin.y+barraInformacion.frame.height), ancho, (DatosC.contenedor.altoP*0.156)));
            if(c<4){
                //print("Tipo: ",c);
                pestanas.tipo=(1+Int(c));
            }
            pestanas.padre=self;
            pestanas.Fondo();
            self.addSubview(pestanas.iniSlide().view);
            pestanasA.append(pestanas);
            /*
            let deslizador=VistaPestana();
            pestanas.subVista=deslizador;
            deslizador.view.frame=CGRectMake(0, (self.frame.height*0.2), self.frame.width, self.frame.height*0.8);
            //pestanas.addSubview(deslizador.view);
             */
            c+=1;
            //self.bringSubviewToFront(pestanas);
            self.addSubview(pestanas);
        }
        
            if(DatosC.contenedor.tipo>4){
                pestanasA[0].FondoActivo();
                pestanasA[0].activo=true;
                pestanasA[0].subVista?.view.hidden=false;
            }else{
                for pest in pestanasA{
                    if(DatosC.contenedor.tipo==pest.tipo){
                        pest.FondoActivo();
                        pest.backgroundColor=UIColor.redColor();
                        //print("rojo");
                        pest.activo=true;
                        pest.subVista?.view.hidden=false;
                    }else{
                        pest.activo=false;
                    }
                }
            }
        DatosC.contenedor.Pestanas=pestanasA;
    }
    
    //Método que inicia la bara de la información
    func IniciaBarraInformacion(){
        let frameInformacion = CGRectMake(0, 0, DatosC.contenedor.anchoP, (DatosC.contenedor.altoP*0.04));
        barraInformacion.frame=frameInformacion;
        //barraInformacion.backgroundColor=UIColor.yellowColor();
        var nomb = "";
        for nn in DatosC.contenedor.ninos{
            if(nn.activo == true){
                nomb=nn.nombreNino;
            }
            //print("nn: ", nn.nombreNino, " accc: ", nn.activo);
        }
        let framePestaña = CGRectMake(DatosC.contenedor.anchoP*0.587, (0), DatosC.contenedor.anchoP*0.28, barraInformacion.frame.height);
        let frameLupa = CGRectMake(DatosC.contenedor.anchoP*0.88, 0, DatosC.contenedor.anchoP*0.11, barraInformacion.frame.height);
        
        
        
        let pestaña = UIView(frame: framePestaña);
        let lupa = UIButton(frame: frameLupa);
        let nombre = UILabel(frame: CGRectMake(0,0,framePestaña.width, framePestaña.height));
        fondoPestaña(pestaña);
        fondoLupa(lupa);
        nombre.text=nomb;
        nombre.font=UIFont(name: "SansBeam Head", size: 20);
        nombre.textColor=UIColor.whiteColor();
        nombre.textAlignment=NSTextAlignment.Center;
        lupa.addTarget(self, action: #selector(ContenedorProductos.productosTag(_:)), forControlEvents: .TouchDown);
        
        pestaña.addSubview(nombre);
        barraInformacion.addSubview(lupa);
        //pestaña.backgroundColor=UIColor.orangeColor();
        barraInformacion.addSubview(pestaña);
        
        //self.addSubview(barraInformacion);
    }
    //Método que establece el fondo de la pestaña
    func fondoPestaña(pest: UIView){
        let image = UIImage(named: "TabNombre");
        let backImg = UIImageView(frame: CGRectMake(0,0,pest.frame.width, pest.frame.height));
        backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image=image;
        pest.addSubview(backImg);
    }
    
    //Método que establece el fondo de la lupa
    func fondoLupa(lupa: UIView){
        let image = UIImage(named: "TabBuscar");
        let backImg = UIImageView(frame: CGRectMake(0,0,lupa.frame.width, lupa.frame.height));
        backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image=image;
        lupa.addSubview(backImg);

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que se llama al tocar el botón de buscar
    func productosTag(sender : AnyObject){
        //print("Busca");
        iniciaBarraBúsqueda();
        
    }
    
    //Método que inicializa la barra de búsqueda y sus componentes
    func iniciaBarraBúsqueda(){
        let frameBarra = CGRectMake(0, DatosC.contenedor.altoP*0.05, DatosC.contenedor.anchoP, DatosC.contenedor.altoP*0.05);
        barraBusqueda = UIView(frame: frameBarra);
        //barraBusqueda?.backgroundColor=UIColor.blueColor();
        let frameFondo = CGRectMake(0, 0, barraBusqueda!.frame.width, barraBusqueda!.frame.height);
        let corimmiento = DatosC.contenedor.anchoP*0.1;
        let frameTexto = CGRectMake(corimmiento, 0, frameBarra.width-(corimmiento), frameBarra.height);
        let inputT=UITextField(frame: frameTexto);
        //inputT.backgroundColor=UIColor.yellowColor();
        inputT.placeholder = "Buscar...";
        inputT.addTarget(self, action: #selector(ContenedorProductos.busqueda), forControlEvents: .EditingChanged);
        let imagen = UIImage(named: "CasillaBusqueda");
        let bacImg = UIImageView(frame: frameFondo);
        bacImg.image=imagen;
        let frameCerrar = CGRectMake(DatosC.contenedor.anchoP*0.9, 0, DatosC.contenedor.anchoP*0.1, frameBarra.height);
        let cierra = UIButton(frame: frameCerrar);
        cierra.addTarget(self, action: #selector(ContenedorProductos.cierraBusqueda(_:)), forControlEvents: .TouchDown);
        cierra.backgroundColor=UIColor.redColor();
        barraBusqueda!.addSubview(bacImg);
        barraBusqueda!.addSubview(inputT);
        barraBusqueda!.addSubview(cierra);
        self.bringSubviewToFront(cierra);
        barraBusqueda!.sendSubviewToBack(bacImg);
        
        //barraBusqueda.backgroundColor=UIColor.orangeColor();
        self.addSubview(barraBusqueda!);
    }
    
    //Método que retorna una lista de productos que contienen una etiqueta
    func busqueda(sender: UITextField){
        //print("tt: ", sender.text);
        var lista = [Producto]();
        var busca = sender.text;
        busca = busca?.lowercaseString;
        //print("busca: ", busca);
        //print("tama: ", DatosD.contenedor.tags.count);
        var anterior : Int?;
        for tag in DatosD.contenedor.tags{
            let nombre = tag.nombreTag?.lowercaseString;
            
            
            /*
            print("nom: ", nombre);
            print("nom: ", tag.idProducto);
            print("nom: ", tag.idTag);
            */
            if((nombre!.rangeOfString(busca!)) != nil){
                //print("Contiene: ", busca!);
                for prod in DatosC.contenedor.productos{
                    
                    if(prod.id==tag.idProducto && anterior != prod.id){
                        //print("prod.is -> ",prod.id , " anterior -> ",anterior);
                        lista.append(prod);
                        anterior=prod.id;
                    }
                }
            }
        }
        let OY = barraBusqueda!.frame.origin.y+barraBusqueda!.frame.height;
        let alto = DatosC.contenedor.altoP*0.3;
        let frameScroll = CGRectMake(0, OY, DatosC.contenedor.anchoP, alto);
        if(scrol != nil){
            scrol!.removeFromSuperview();
        }
        
        scrol = ScrollResultados(frame: frameScroll);
        scrol!.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.2, alpha: 0.5);
        //scrol.backgroundColor!.colorWithAlphaComponent(0.5);
        self.addSubview(scrol!);
        var p = CGFloat(0);
        let espaciado = DatosC.contenedor.altoP*0.01;
        let altoB = DatosC.contenedor.altoP*0.05;
        for prod in lista{
            let OY2 = espaciado + (p*(altoB+espaciado));
            let frameBoton = CGRectMake(0, OY2, DatosC.contenedor.anchoP, altoB);
            //print("frame Bot: ", frameBoton);
            var pestañaBoton = PestanasProductos();
            for pest in pestanasA{
                if(pest.tipo==prod.tipo){
                    pestañaBoton=pest;
                }
            }
            let bot=BotonResultado(frame: frameBoton, producto:  prod, pestañas: pestañaBoton);
            
            bot.backgroundColor=UIColor.yellowColor();
            //print("Prod: ",prod.nombre);
            scrol!.addSubview(bot);
            p += 1;
        }
        scrol!.contentSize=CGSizeMake(DatosC.contenedor.anchoP, (altoB*p+(2*(espaciado))));
    }
    
    //Método que quita la barra de busqueda y el scroll de los resultados
    func cierraBusqueda(sender: AnyObject){
        print("cierra");
        if(barraBusqueda != nil){
            scrol?.removeFromSuperview();
            barraBusqueda?.removeFromSuperview();
            barraBusqueda?.userInteractionEnabled=false;
            barraBusqueda?.frame=CGRectZero;
        }
        
        if(scrol != nil){
            
            
        }
    }

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
