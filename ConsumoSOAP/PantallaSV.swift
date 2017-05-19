//
//  PantallaSV.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 18/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class PantallaSV: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var PanelElementos: UIView!
    //@IBOutlet weak var Lonchera: UIView!
    @IBOutlet weak var LaBarra: UIView!
    
    
    
    var CasillaF:CGRect?;
    var FrameOriginal:CGRect?;
    var CasiillaOriginal:CGRect?;
    var lonch:Lonchera2!;
    var padreLonch:UIView?;
    var panelInfo:UIView?;
    let reductor = CGFloat(0.5);
    var casillaBaja:Casilla!;
    var espacioIntercambio:UIView!;
    var contenedor:ContenedorProductos!;
    var barraBusqueda : UIView?;
    var scrol : ScrollResultados?;
    var inputT:UITextField!;
    var timer:Timer!;
    var btimer=false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaBotonVolver();
        iniciaBuscar();
        //print("IACT: ", DatosC.contenedor.iActual);
        iniciaEspacioIntercambio();
        DatosC.contenedor.pantallaSV=self;
        PanelElementos!.frame=CGRect(x: 0, y: LaBarra.frame.height, width: DatosC.contenedor.anchoP, height: (DatosC.contenedor.altoP));
        lonch=DatosB.cont.home2.lonchera;
        //print("LONC ATT: ", lonch);
         if(lonch != nil){
            //print("Lleno")
         }else{
            //print("vacio");
         }
         //lonch.ordena();
         //Lonchera.addSubview(lonch.view);
         padreLonch=lonch!.superview;
        iniciaContenedor();
        //Lonchera?.frame=CGRectMake(0, framePanelElementos.height, (DatosC.contenedor.anchoP-20),
        
        //DatosC.contenedor.casillasF=lonch.subVista!.casillas;
        let volver = UIButton(frame: CGRect(x: 0, y: (DatosC.contenedor.altoP*0.5), width: (DatosC.contenedor.anchoP*0.3), height: (DatosC.contenedor.altoP*0.07)));
        volver.addTarget(self, action: #selector(PantallaSV.devuelve(_:)), for: .touchDown)
        volver.setTitle("Volver", for: UIControlState());
        volver.backgroundColor=UIColor.blue;
        //self.view.bringSubviewToFront(PanelElementos);
        //self.view.addSubview(volver);
        
        self.view.bringSubview(toFront: PanelElementos);
        //PanelElementos.bringSubviewToFront(contenedor);
        //PanelElementos.addSubview(lonch!.subVista!);
         //cargaElementos();
        //self.view.bringSubviewToFront(LaBarra);
        self.view.sendSubview(toBack: LaBarra);
        iniciaTutorial();
        
        
        // Do any additional setup after loading the view.
    }
    
    func iniciaContenedor(){
        
        
        let framePanelElementos = CGRect(x: 0, y: 0, width: PanelElementos.frame.width, height: PanelElementos.frame.height);
        contenedor=ContenedorProductos(frame: framePanelElementos);
        PanelElementos.addSubview(contenedor)
    }
    
    func reiniciaContenedor(){
        if(contenedor != nil){
            contenedor.removeFromSuperview();
        }
        print("cont");
        let framePanelElementos = CGRect(x: 0, y: 0, width: PanelElementos.frame.width, height: PanelElementos.frame.height);
        contenedor=ContenedorProductos(frame: framePanelElementos);
        PanelElementos.addSubview(contenedor)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func cargaElementos(){
        print("carga?");
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
                //print("panelE: ", self.PanelElementos);
                //producto.PanelOrigen=self.view;
                //producto.espacio=self.view;
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
    */
    func boto(_ sender: UIButton){
        //print("Boto")
    }
    
    func devuelve(_ sender: UIButton){
        
        actuaLonch(true);
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func actuaLonch(_ pasa: Bool){
        
        if(pasa){
            
            self.dismiss(animated: true, completion: nil);
        }else{
            
        }
    }
    
    
    /*func bajaLonch()-> LoncheraO{
        return DatosC.contenedor.lonchera;
    }*/
    
    
    //Método que se llama desde un producto para mostrar su información
    func iniciaPanelInfo(_ prod: Producto){
        let bordeL = CGFloat(self.view.frame.width*0.1);
        let bordeA = CGFloat(self.view.frame.height*0.09);
        
        
        let frame = CGRect(x: bordeL, y: bordeA, width: self.view.frame.width*0.79, height: self.view.frame.height*0.8);
        //0.77let frameImagen = CGRectMake(bordeA, bordeA, frame.width-(2*bordeA), frame.height*0.4);
        _ = CGRect(x: 0, y: frame.height*0.9, width: frame.width, height: frame.height*0.1);
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
        self.view.bringSubview(toFront: panelInfo!);
        //print("infoProd:");
    }
    
    func cierraPanelInfo(_ sender: AnyObject){
        panelInfo?.removeFromSuperview();
    }
    
    
    //Método que inicia las casillas, y pone la información encontrada del producto
    func iniciaCasillasInfo(_ rec: UIView, prod: Producto){
        let ancho = rec.frame.width/3;
        let alto = rec.frame.height/2;
        var itera = 0;
        for fila in 0...1{
            //print("Fila: ", fila);
            for columna in 0...2{
                
                let frameCasilla = CGRect(x: (0+(ancho*CGFloat(columna))), y: (0+(alto*CGFloat(fila))), width: ancho, height: alto);
                let casilla = UIView(frame: frameCasilla);
                casilla.backgroundColor = UIColor.init(red: 1, green: CGFloat(columna)*0.3, blue: 1, alpha: 1);
                rec.addSubview(casilla);
                if(itera < prod.listaDatos.count){
                    let tit = UILabel(frame: CGRect(x: 0, y: 0, width: casilla.frame.width, height: (casilla.frame.height/2)));
                    let val = UILabel(frame: CGRect(x: 0, y: (casilla.frame.height/2), width: casilla.frame.width, height: (casilla.frame.height/2)));
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
        let ancho = CGFloat(DatosC.contenedor.anchoP);
        let alto = CGFloat(DatosC.contenedor.altoP*0.13);
        let OX = CGFloat((DatosC.contenedor.anchoP/2)-(ancho/2));
        //let OY = (espacioIntercambio.frame.height/2)-(alto/2);
        let OY = (DatosC.contenedor.altoP*(1-0.733)/2)-(alto/2);
        let frameCasilla = CGRect(x: OX, y: OY, width: ancho, height: alto);
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
        let frame = CGRect(x: 0, y: OY, width: ancho, height: alto);
        espacioIntercambio = UIView(frame: frame);
        espacioIntercambio.backgroundColor = UIColor.red;
        self.view.addSubview(espacioIntercambio);
        casillaBaja = Casilla();
        self.view.addSubview(casillaBaja);
        iniciaLoncheraReferencia();
        iniciaCasillaBaja();
        espacioIntercambio.accessibilityIdentifier = "Inter";
        //espacioIntercambio.addTarget(self, action: #selector(PantallaSV.devuelve(_:)), forControlEvents: .TouchDown);
    }
    
    //Método que escoge la imagen referencia de la lonchera pequeña
    func iniciaLoncheraReferencia(){
        let OX = DatosC.contenedor.anchoP*0.73;
        let ancho = DatosC.contenedor.anchoP*0.21;
        let alto = DatosC.contenedor.altoP*0.1;
        let OY = (espacioIntercambio.frame.height*0.5)-(alto/2);
        
        
        let frame = CGRect(x: OX, y: OY, width: ancho, height: alto);
        
        //print("LoncherActual: ", DatosC.contenedor.tipo);
        var color = "";
        var cant = "";
        var pos = "";
        /*if(DatosC.contenedor.lonchera.saludable == true){
            color = "V";
        }else{
            color = "B";
        }*/
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
        cant = String(DatosB.cont.home2.lonchera.casillas.count);
        pos = String(DatosC.contenedor.tipo);
        
        let nomText = color+"-"+cant+"-"+pos;
        
        
        print("text: ", nomText);
        var imagen : UIImage;
        //imagen = UIImage(named: nomText)!;
        
    
        //print("Tipo: ", frame);
        let referencia = UIImageView(frame: frame);
        //referencia.image = imagen;
        espacioIntercambio.addSubview(referencia);
        espacioIntercambio.bringSubview(toFront: referencia);
    }
    
    //Método que pone el fondo de la casilla baja
    func fondoCasilla(_ cas: Casilla){
        let imagen = UIImage(named: "CasillaBaja");
        let frameF = CGRect(x: 0, y: 0, width: cas.frame.width, height: cas.frame.height);
        let backImg = UIImageView(frame: frameF);
        backImg.image = imagen;
        cas.addSubview(backImg);
        cas.sendSubview(toBack: backImg);
    }
    //Mètodo que oculta la barra en este viewcontroller
    override var prefersStatusBarHidden : Bool {
        return true
    }

    func iniciaBuscar(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let centr = (ancho/2)-(ancho/4);
        let OX = DatosC.contenedor.anchoP-ancho;
        let frameBoton = CGRect(x: OX, y: 0, width: ancho, height: ancho);
        let buscar = UIButton(frame: frameBoton);
        //buscar.backgroundColor=UIColor.redColor();
        buscar.addTarget(self, action: #selector(PantallaSV.productosTag(_:)), for: .touchDown);
        let subFrame = CGRect(x: centr, y: centr, width: ancho/3, height: ancho/3);
        DatosB.cont.poneFondoTot(buscar, fondoStr: "Lupa", framePers: subFrame, identi: nil, scala: true);
        
        self.view.addSubview(buscar);
    }
    
    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let ancho2 = ancho/3;
        let centr = (ancho/2)-(ancho2/2);
        let frameBoton = CGRect(x: 0, y: 0, width: ancho, height: ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(PantallaSV.cierraPantallaSV(_:)), for: .touchDown);
        let subFrame = CGRect(x: centr, y: centr, width: ancho2, height: ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    //Método que se llama al tocar el botón de buscar
    func productosTag(_ sender : AnyObject){
        //print("Busca");
        iniciaBarraBúsqueda();
        
    }
    
    //Método que inicializa la barra de búsqueda y sus componentes
    func iniciaBarraBúsqueda(){
        let frameBarra = CGRect(x: 0, y: DatosC.contenedor.altoP*0.05, width: DatosC.contenedor.anchoP, height: DatosC.contenedor.altoP*0.05);
        barraBusqueda = UIView(frame: frameBarra);
        //barraBusqueda?.backgroundColor=UIColor.blueColor();
        let frameFondo = CGRect(x: 0, y: 0, width: barraBusqueda!.frame.width, height: barraBusqueda!.frame.height);
        let corimmiento = DatosC.contenedor.anchoP*0.1;
        let frameTexto = CGRect(x: corimmiento, y: 0, width: frameBarra.width-(corimmiento), height: frameBarra.height);
        inputT=UITextField(frame: frameTexto);
        //inputT.backgroundColor=UIColor.yellowColor();
        inputT.placeholder = "Buscar...";
        inputT.delegate=self;
        inputT.addTarget(self, action: #selector(PantallaSV.busqueda), for: .editingChanged);
        let imagen = UIImage(named: "CasillaBusqueda");
        let bacImg = UIImageView(frame: frameFondo);
        bacImg.image=imagen;
        //bacImg.contentMode=UIViewContentMode.ScaleAspectFit;
        let frameCerrar = CGRect(x: DatosC.contenedor.anchoP*0.9, y: 0, width: DatosC.contenedor.anchoP*0.1, height: frameBarra.height);
        let cierra = UIButton(frame: frameCerrar);
        cierra.addTarget(self, action: #selector(PantallaSV.cierraBusqueda(_:)), for: .touchDown);
        DatosB.cont.poneFondoTot(cierra, fondoStr: "BotonCerrar", framePers: nil, identi: nil, scala: true);
        //cierra.backgroundColor=UIColor.redColor();
        barraBusqueda!.addSubview(bacImg);
        barraBusqueda!.addSubview(inputT);
        barraBusqueda!.addSubview(cierra);
        self.view.bringSubview(toFront: cierra);
        barraBusqueda!.sendSubview(toBack: bacImg);
        
        //barraBusqueda.backgroundColor=UIColor.orangeColor();
        self.view.addSubview(barraBusqueda!);
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        subeBusqueda();
    }
    
    func subeBusqueda() {
        if(inputT.text?.characters.count>2){
            print("texto: ", inputT.text);
            let subeB = SubeBusqueda();
            subeB.subeBusqueda(DatosD.contenedor.padre.id!, texto: inputT.text!);
        }
        btimer=false;
    }
    
    //Método que retorna una lista de productos que contienen una etiqueta
    func busqueda(_ sender: UITextField){
        //print("tt: ", sender.text);
        var lista = [Producto]();
        var busca = sender.text;
        busca = busca?.lowercased();
        iniciaContador();
        //print("busca: ", busca);
        //print("tama: ", DatosD.contenedor.tags.count);
        var anterior : Int?;
        for tag in DatosD.contenedor.tags{
            let nombre = tag.nombreTag?.lowercased();
            
            
            /*
             print("nom: ", nombre);
             print("nom: ", tag.idProducto);
             print("nom: ", tag.idTag);
             */
            if((nombre!.range(of: busca!)) != nil){
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
        let frameScroll = CGRect(x: 0, y: OY, width: DatosC.contenedor.anchoP, height: alto);
        if(scrol != nil){
            scrol!.removeFromSuperview();
        }
        
        scrol = ScrollResultados(frame: frameScroll);
        scrol!.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5);
        //scrol.backgroundColor!.colorWithAlphaComponent(0.5);
        self.view.addSubview(scrol!);
        var p = CGFloat(0);
        let espaciado = DatosC.contenedor.altoP*0.01;
        let altoB = DatosC.contenedor.altoP*0.05;
        for prod in lista{
            let OY2 = espaciado + (p*(altoB+espaciado));
            let frameBoton = CGRect(x: 0, y: OY2, width: DatosC.contenedor.anchoP, height: altoB);
            //print("frame Bot: ", frameBoton);
            var pestañaBoton : PestanasProductos?;
            for pest in contenedor.pestanasA{
                if(pest.tipo==prod.tipo){
                    pestañaBoton=pest;
                }
            }
            if(pestañaBoton != nil){
                
            }else{
                pestañaBoton = contenedor.pestanasA.first!;
            }
            let bot=BotonResultado(frame: frameBoton, producto:  prod, pestañas: pestañaBoton!);
            
            bot.backgroundColor=UIColor.white;
            //print("Prod: ",prod.nombre);
            scrol!.addSubview(bot);
            p += 1;
        }
        scrol!.contentSize=CGSize(width: DatosC.contenedor.anchoP, height: (altoB*p+(2*(espaciado))));
    }
    
    //Método que inicia el contador del input de la búsqueda
    func iniciaContador(){
        if(btimer == false){
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(PantallaSV.subeBusqueda), userInfo: nil, repeats: false);
            btimer=true;
        }
        
    }
    
    //Método que quita la barra de busqueda y el scroll de los resultados
    func cierraBusqueda(_ sender: AnyObject){
        print("cierra");
        if(barraBusqueda != nil){
            scrol?.removeFromSuperview();
            barraBusqueda?.removeFromSuperview();
            barraBusqueda?.isUserInteractionEnabled=false;
            barraBusqueda?.frame=CGRect.zero;
        }
        
        if(scrol != nil){
            
            
        }
    }
    
    //Método que cierra la alacenna
    func cierraPantallaSV(_ sender: UIButton){
        
        DatosC.contenedor.pantallaSV.devuelve(sender);
    }
    
    let tut = BaseImagenes2(transitionStyle: UIPageViewControllerTransitionStyle.scroll,
                           navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal,
                           options: nil);
    
    //Método que inicia el tutorial, si es la primera vez que inicia la app
    func iniciaTutorial(){
        if(DatosD.contenedor.padre.primeraVez==true){
            self.view.addSubview(tut.view);
            tut.view.frame=CGRect(x: 0, y: 0, width: self.view.frame.width*1, height: self.view.frame.height/1);
            DatosD.contenedor.padre.primeraVez=false;
            let actuaP = ActualizaPadre();
            actuaP.actualizaPadre(DatosD.contenedor.padre);
            print("TUTORIAL");
        }else{
            print("no tutorial");
        }
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
