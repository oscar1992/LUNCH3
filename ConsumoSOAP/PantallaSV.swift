//
//  PantallaSV.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 18/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class PantallaSV: UIViewController {
    
    @IBOutlet weak var PanelElementos: UIView!
    //@IBOutlet weak var Lonchera: UIView!
    @IBOutlet weak var LaBarra: UIView!
    
    
    
    var CasillaF:CGRect?;
    var FrameOriginal:CGRect?;
    var CasiillaOriginal:CGRect?;
    var lonch:LoncheraO!;
    var padreLonch:UIView?;
    var panelInfo:UIView?;
    let reductor = CGFloat(0.5);
    var casillaBaja:Casilla!;
    var espacioIntercambio:UIView!;
    var contenedor:ContenedorProductos!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaEspacioIntercambio();
        DatosC.contenedor.pantallaSV=self;
        PanelElementos!.frame=CGRectMake(0, (LaBarra.frame.height+LaBarra.frame.origin.y), DatosC.contenedor.anchoP, (DatosC.contenedor.altoP));
        lonch=DatosC.contenedor.lonchera;
        print("LONC ATT: ", lonch.fechaVisible?.text);
         if(lonch != nil){
            print("Lleno")
         }else{
            print("vacio");
         }
         //lonch.ordena();
         //Lonchera.addSubview(lonch.view);
         padreLonch=lonch!.view.superview;
        let framePanelElementos = CGRectMake(0, 0, PanelElementos.frame.width, PanelElementos.frame.height);
        contenedor=ContenedorProductos(frame: framePanelElementos);
        //Lonchera?.frame=CGRectMake(0, framePanelElementos.height, (DatosC.contenedor.anchoP-20), (DatosC.contenedor.altoP*0.4));
        
         
        FrameOriginal=lonch!.subVista?.frame;
         //lonch.subVista?.escala();
         //CasiillaOriginal=lonch.subVista?.casillas[0].frame;
         
        
        //print("Frame: ", FrameOriginal);
        let frameSubvista = CGRectMake(0, DatosC.contenedor.altoP*0.7, DatosC.contenedor.anchoP, contenedor.frame.height);
        lonch!.subVista!.frame = frameSubvista;
        lonch!.subVista?.tamañoFondo(frameSubvista);
         
         
        //let sum=(DatosC.contenedor.anchoP/2)-(((lonch!.subVista?.frameLonchera?.width)!*0.5)/2);//Desplazamiento horizontal de las casillas en la alacena
        let anchoCasilla = lonch!.subVista?.casillas[0].frame.width;
        let sum=(DatosC.contenedor.anchoP*(1-reductor))-((anchoCasilla!*reductor));
        //print("sum", sum);
         for cass in lonch.subVista!.casillas{
            print("pos: ",cass.frame);
            let bot = UIButton(frame: CGRectMake(10, 10, 30, 30));
            bot.addTarget(self, action: #selector(PantallaSV.boto(_:)), forControlEvents: .TouchDown);
            bot.backgroundColor=UIColor.redColor();
            let nf=CGRectMake((cass.frame.origin.x*reductor)+sum, cass.frame.origin.y*reductor, (cass.frame.width*reductor), (cass.frame.height*reductor))
            
            cass.frame=nf;
            cass.setFondo(true);
            print("nf", cass.frame);
            //print("nima: ",cass.elemeto?.producto?.nombre);
            
            if(cass.elemeto?.producto != nil){
                cass.elemeto!.frame=CGRectMake(0, 0, nf.width, nf.height);
         
                //print("nn: ",cass.elemeto!.producto?.nombre);
         
                let pv=ProductoView(frame: CGRectMake(0, 0, nf.width, nf.height), imagen: cass.elemeto!.producto!.imagen);
                let prod=cass.elemeto!.producto;
                let tipo=cass.tipo;
                let ima=cass.elemeto!.producto!.imagen;
                cass.elemeto?.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.6);
                cass.elemeto!.removeFromSuperview();
                //cass.elemeto!.elimina();
                pv.espacio=lonch.subVista;
                pv.Natural=false;
                cass.seteaElemento(pv, tipo: tipo!, ima: ima, prod: prod!);
                if(lonch.saludable == true){
                    cass.setFondo(cass.elemeto!.producto!.salud!)
                }else{
                    cass.setFondo(false);
                }
                
                //cass.elemeto=pv;
                //cass.addSubview(pv);
                /*
                cass.tipo=tipo;
                cass.elemeto!.producto=prod;
                cass.elemeto!.producto!.imagen=ima;
                */
                //cass.backgroundColor = UIColor.grayColor();
                self.view.bringSubviewToFront(cass.elemeto!);
            }else{
                //print("cass: ", lonch.saludable);
                if(lonch.saludable != nil){
                    cass.setFondo(lonch.saludable!);
                }
                
                //print("no posee: ", cass.elemeto?.producto?.nombre);
            }
            cass.activo = false;
            
            //cass.addSubview(bot);
            //self.view.bringSubviewToFront(bot);
            cass.addTarget(cass, action: #selector(Casilla.toca(_:)), forControlEvents: .TouchDown);
         //print("pos2: ",nf);
         
         }
        
        lonch.view.bringSubviewToFront(lonch.subVista!);
        
        DatosC.contenedor.casillasF=lonch.subVista!.casillas;
        let volver = UIButton(frame: CGRectMake(0, (DatosC.contenedor.altoP*0.5), (DatosC.contenedor.anchoP*0.3), (DatosC.contenedor.altoP*0.07)));
        volver.addTarget(self, action: #selector(PantallaSV.devuelve(_:)), forControlEvents: .TouchDown)
        volver.setTitle("Volver", forState: .Normal);
        volver.backgroundColor=UIColor.blueColor();
        //self.view.bringSubviewToFront(PanelElementos);
        //self.view.addSubview(volver);
        PanelElementos.addSubview(contenedor)
        //PanelElementos.addSubview(lonch!.subVista!);
         //cargaElementos();
        self.view.bringSubviewToFront(LaBarra);
        iniciaBotonVolver();
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cargaElementos(){
        //print("carga?");
        let borde=CGFloat(20);
        let espaciado=CGFloat(DatosC.contenedor.anchoP*0.05);
        let ancho = CGFloat(DatosC.contenedor.anchoP*0.25);
        var p=CGFloat(0);
        var f=CGFloat(0);
        
        
        for prdo in DatosC.contenedor.productos{
            let fila=(espaciado+ancho)*p+2*(borde);
            if(fila>DatosC.contenedor.anchoP){
                f+=1;
            }
            
            if(prdo.tipo==DatosC.contenedor.tipo){
                //print("prdo: ",prdo.nombre);
                let casilla=Casilla(frame: CGRectMake(borde+((ancho+espaciado)*p), borde+(ancho*f), ancho, ancho));
                let posProducto=CGRectMake(0, 0, casilla.frame.height, casilla.frame.width);
                let producto=ProductoView(frame: posProducto, imagen: prdo.imagen);
                //producto.Panel2=lonch.subVista;
                producto.padre=casilla;
                producto.PanelOrigen=PanelElementos;
                producto.espacio=self.view;
                casilla.elemeto=producto;
                //casilla.backgroundColor=UIColor.greenColor();
                casilla.addSubview(producto);
                PanelElementos.addSubview(casilla);
                producto.casillaF=CasillaF;
                //print("Prod: ",producto.frame);
                p+=1;
            }
            
        }
    }
    
    func boto(sender: UIButton){
        //print("Boto")
    }
    
    func devuelve(sender: UIButton){
        
        actuaLonch(true);
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func actuaLonch(pasa: Bool){
        padreLonch?.addSubview(lonch.view);
        let anchoCasilla = lonch!.subVista?.casillas[0].frame.width;
        let sum=((DatosC.contenedor.anchoP*(1-reductor))-((anchoCasilla!)));
        //print("Espaceado ", (DatosC.contenedor.anchoP*(1-reductor)));
        //print("casilla: ", anchoCasilla!);
        //print("sum 2: ", sum);
        lonch=DatosC.contenedor.lonchera;
        print("LONC ATT: ", lonch.fechaVisible?.text);
        for cas in (lonch.subVista?.casillas)!{
            print("cas: ", cas.elemeto?.producto?.nombre);
        }
        //lonch=DatosC.contenedor.loncheras[DatosC.contenedor.iActual]; //Lonchera que se va a actualizar
        //print("Lonch ID: ", lonch.id);
        
        for cass in lonch.subVista!.casillas{
            //
            if(pasa){
                cass.frame=CGRectMake(((cass.frame.origin.x))/reductor-(sum*2), cass.frame.origin.y/reductor, cass.frame.width/reductor, cass.frame.height/reductor);
            }
            //print("nima: ",cass.frame);
            if(cass.elemeto?.producto != nil){
                cass.elemeto!.frame=CGRectMake(0, 0, cass.frame.width, cass.frame.height)
                
                //print("nn: ",cass.elemeto!.frame);
                
                let pv=ProductoView(frame: CGRectMake(0, 0, cass.frame.width, cass.frame.height), imagen: cass.elemeto!.producto!.imagen);
                let prod=cass.elemeto!.producto;
                
                var tipo=cass.tipo;
                if(tipo == nil){
                    tipo = -1;
                }
                pv.tipo=tipo;
                pv.producto=prod;
                
                print("Nuevo: ",pv.producto?.nombre);
                let ima=cass.elemeto!.producto!.imagen;
                //pv.imagen?.contentMode=UIViewContentMode.ScaleAspectFit;
                //cass.elemeto!.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.6);
                cass.elemeto!.removeFromSuperview();
                //cass.elemeto!.elimina();
                
                
                /*
                 let Cas = cass;
                 Cas.elemeto=nil;
                 cass.elemeto=nil;
                 */
                pv.espacio=lonch.subVista;
                
                cass.seteaElemento(pv, tipo: tipo!, ima: ima, prod: prod!);
                /*
                cass.elemeto=pv;
                cass.tipo=tipo;
                */
                cass.elemeto?.Natural=pasa;
                cass.elemeto?.padre=cass;
                /*
                 for ele in cass.elemeto!.subviews{
                 print("subvv: ", ele);
                 }
                 */
                cass.addSubview(pv);
                cass.elemeto!.producto=prod;
                //print("PV: ",cass.elemeto?.producto!.nombre);
                cass.elemeto!.producto!.imagen=ima;
                cass.bringSubviewToFront(pv);
                
            }else{
                //print("no posee: ", cass.elemeto?.producto?.nombre);
            }
            cass.activo=pasa;
            //print("salud: ", lonch.saludable);
            if(lonch.saludable == nil){
                cass.setFondo(true);
            }else{
                cass.setFondo(lonch.saludable!);
            }
            
         //cs.elemeto?.Natural=true;
        }
        if(pasa){
            lonch!.subVista?.frame=FrameOriginal!;
            lonch!.subVista?.setFondo2();
            
        }
        DatosC.contenedor.lonchera=lonch;
        //padreLonch?.addSubview(lonch!.subVista!);
        
        //print("iActual:", DatosC.contenedor.iActual);
        //scrol?.paginas[DatosC.contenedor.iActual].removeFromParentViewController();
        
        
        //print("sup:", scrol);
        //print("Frame: ", lonch!.subVista?.frame);
        if(pasa){
            let scrol=lonch?.padre;
            let sub=lonch?.subVista;
            scrol?.paginas[DatosC.contenedor.iActual].subVista=lonch!.subVista;
            scrol?.paginas[DatosC.contenedor.iActual].view!.addSubview(sub!);
            lonch!.view.bringSubviewToFront(lonch!.botadd!);
            lonch!.view.bringSubviewToFront(lonch!.botfavo!);
            lonch!.view.bringSubviewToFront(lonch!.botrem!);
            self.dismissViewControllerAnimated(true, completion: nil);
        }else{
            
        }
    }
    
    func bajaLonch()-> LoncheraO{
        return DatosC.contenedor.lonchera;
    }
    
    
    //Método que se llama desde un producto para mostrar su información
    func iniciaPanelInfo(prod: Producto){
        let bordeL = CGFloat(self.view.frame.width*0.1);
        let bordeA = CGFloat(self.view.frame.height*0.09);
        
        
        let frame = CGRectMake(bordeL, bordeA, self.view.frame.width*0.79, self.view.frame.height*0.8);
        //0.77let frameImagen = CGRectMake(bordeA, bordeA, frame.width-(2*bordeA), frame.height*0.4);
        let frameBoton = CGRectMake(0, frame.height*0.9, frame.width, frame.height*0.1);
        //let frameInfo = CGRectMake(0, frameImagen.height+frame.origin.y, frame.width, frame.height*0.4);
        panelInfo=DetalleProducto(frame: frame, prdo: prod);
        /*
        //panelInfo = UIView(frame: frame);
        let imagen = UIImageView(frame: frameImagen);
        let devuelve = UIButton(frame: frameBoton);
        let info=UIView(frame: frameInfo);
        devuelve.backgroundColor = UIColor.blackColor();
        devuelve.addTarget(self, action: #selector(cierraPanelInfo(_:)), forControlEvents: .TouchDown);
        //print("imagen: ", prod.imagen);
        imagen.image = prod.imagen;
        imagen.contentMode=UIViewContentMode.ScaleAspectFit;
        info.backgroundColor = UIColor.blueColor();
        iniciaCasillasInfo(info, prod: prod);
        panelInfo!.addSubview(imagen);
        panelInfo!.addSubview(devuelve);
        panelInfo!.addSubview(info);
        
        
        //print("tama: ",frame);
        panelInfo?.backgroundColor=UIColor.whiteColor();
        */
        self.view.addSubview(panelInfo!);
        self.view.bringSubviewToFront(panelInfo!);
        //print("infoProd:");
    }
    
    func cierraPanelInfo(sender: AnyObject){
        panelInfo?.removeFromSuperview();
    }
    
    
    //Método que inicia las casillas, y pone la información encontrada del producto
    func iniciaCasillasInfo(rec: UIView, prod: Producto){
        let ancho = rec.frame.width/3;
        let alto = rec.frame.height/2;
        var itera = 0;
        for fila in 0...1{
            //print("Fila: ", fila);
            for columna in 0...2{
                
                let frameCasilla = CGRectMake((0+(ancho*CGFloat(columna))), (0+(alto*CGFloat(fila))), ancho, alto);
                let casilla = UIView(frame: frameCasilla);
                casilla.backgroundColor = UIColor.init(red: 1, green: CGFloat(columna)*0.3, blue: 1, alpha: 1);
                rec.addSubview(casilla);
                if(itera < prod.listaDatos.count){
                    let tit = UILabel(frame: CGRectMake(0, 0, casilla.frame.width, (casilla.frame.height/2)));
                    let val = UILabel(frame: CGRectMake(0, (casilla.frame.height/2), casilla.frame.width, (casilla.frame.height/2)));
                    tit.text = prod.listaDatos[itera].tipo;
                    val.text = String(prod.listaDatos[itera].valor);
                    casilla.addSubview(tit);
                    casilla.addSubview(val);
                    //print("Columna: ", prod.listaDatos[itera].tipo);
                }
                itera += 1;
            }
        }
    }
    
    //Método que inicia la casilla del arrastre final, en reemplazo de la lonchera
    func iniciaCasillaBaja(){
        let ancho = CGFloat(DatosC.contenedor.anchoP*0.27);
        let alto = CGFloat(DatosC.contenedor.altoP*0.13);
        let OX = CGFloat((DatosC.contenedor.anchoP/2)-(ancho/2));
        //let OY = (espacioIntercambio.frame.height/2)-(alto/2);
        let OY = (DatosC.contenedor.altoP*(1-0.733)/2)-(alto/2);
        let frameCasilla = CGRectMake(OX, OY, ancho, alto);
        casillaBaja.frame=frameCasilla;
        casillaBaja.tipo=DatosC.contenedor.tipo;
        casillaBaja.activo=false;
        //casillaBaja.setFondo(true);
        //fondoCasilla(casillaBaja);
        //espacioIntercambio.bringSubviewToFront(casillaBaja);
        //espacioIntercambio.sendSubviewToBack(casillaBaja);
    }
    
    //Método que crea el espacio de la casilla de asignación
    func iniciaEspacioIntercambio(){
        let OY = DatosC.contenedor.altoP*0.733;
        let ancho = DatosC.contenedor.anchoP;
        let alto = DatosC.contenedor.altoP*(1-0.733);
        let frame = CGRectMake(0, OY, ancho, alto);
        espacioIntercambio = UIView(frame: frame);
        espacioIntercambio.backgroundColor = UIColor.clearColor();
        self.view.addSubview(espacioIntercambio);
        casillaBaja = Casilla();
        self.view.addSubview(casillaBaja);
        iniciaLoncheraReferencia();
        iniciaCasillaBaja();
        espacioIntercambio.accessibilityIdentifier = "Inter";
        
    }
    
    //Método que escoge la imagen referencia de la lonchera pequeña
    func iniciaLoncheraReferencia(){
        let OX = DatosC.contenedor.anchoP*0.73;
        let ancho = DatosC.contenedor.anchoP*0.21;
        let alto = DatosC.contenedor.altoP*0.1;
        let OY = (espacioIntercambio.frame.height*0.5)-(alto/2);
        
        
        let frame = CGRectMake(OX, OY, ancho, alto);
        
        //print("LoncherActual: ", DatosC.contenedor.tipo!);
        var color = "";
        var cant = "";
        var pos = "";
        if(DatosC.contenedor.lonchera.saludable == true){
            color = "V";
        }else{
            color = "B";
        }
        /*
        if(DatosC.contenedor.lonchera.color == nil){
            if(DatosC.contenedor.lonchera.saludable == true){
                color = "V";
            }else{
                color = "B";
            }
        }else{
            switch  DatosC.contenedor.lonchera.color! {
            case 2:
                color = "R";
                break;
            case 3:
                color = "A";
                break;
            case 1:
                color = "V";
                break;
            case -2:
                color = "AZ"
                break;
            default:
                break;
            }
        }
        */
        cant = String(DatosC.contenedor.lonchera.subVista!.casillas.count);
        pos = String(DatosC.contenedor.tipo!);
        
        let nomText = color+"-"+cant+"-"+pos;
        
        print("text: ", nomText);
        var imagen : UIImage;
        imagen = UIImage(named: nomText)!;
        
    
        //print("Tipo: ", frame);
        let referencia = UIImageView(frame: frame);
        referencia.image = imagen;
        espacioIntercambio.addSubview(referencia);
        espacioIntercambio.bringSubviewToFront(referencia);
    }
    
    //Método que pone el fondo de la casilla baja
    func fondoCasilla(cas: Casilla){
        let imagen = UIImage(named: "CasillaBaja");
        let frameF = CGRectMake(0, 0, cas.frame.width, cas.frame.height);
        let backImg = UIImageView(frame: frameF);
        backImg.image = imagen;
        cas.addSubview(backImg);
        cas.sendSubviewToBack(backImg);
    }
    //Mètodo que oculta la barra en este viewcontroller
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    
    func iniciaBotonVolver(){
        let frameVolver = CGRectMake(DatosC.contenedor.anchoP*0, DatosC.contenedor.anchoP*0.025, DatosC.contenedor.anchoP*0.125, LaBarra.frame.height*1.25);
        let volver = UIButton(frame: frameVolver);
        fondoVolver(volver);
        volver.addTarget(self, action: #selector(PantallaSV.cierraPantallaSV(_:)), forControlEvents: .TouchDown);
        self.view.addSubview(volver);
    }
    
    //Método que establece e fondo del botón de volver
    func fondoVolver(volver: UIButton){
        let image = UIImage(named: "Volver");
        let ancho = volver.frame.width * 0.5;
        let alto = volver.frame.height * 0.5;
        let backImg = UIImageView(frame: CGRectMake(0,0,ancho, alto));
        backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image=image;
        volver.addSubview(backImg);
    }
    
    //Método que cierra la alacenna
    func cierraPantallaSV(sender: UIButton){
        DatosC.contenedor.pantallaSV.devuelve(sender);
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
