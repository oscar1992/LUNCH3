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
    var lonch:Lonchera2!;
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
        lonch=DatosB.cont.home2.lonchera;
        print("LONC ATT: ", lonch);
         if(lonch != nil){
            print("Lleno")
         }else{
            print("vacio");
         }
         //lonch.ordena();
         //Lonchera.addSubview(lonch.view);
         padreLonch=lonch!.superview;
        let framePanelElementos = CGRectMake(0, 0, PanelElementos.frame.width, PanelElementos.frame.height);
        contenedor=ContenedorProductos(frame: framePanelElementos);
        //Lonchera?.frame=CGRectMake(0, framePanelElementos.height, (DatosC.contenedor.anchoP-20),
        
        //DatosC.contenedor.casillasF=lonch.subVista!.casillas;
        let volver = UIButton(frame: CGRectMake(0, (DatosC.contenedor.altoP*0.5), (DatosC.contenedor.anchoP*0.3), (DatosC.contenedor.altoP*0.07)));
        volver.addTarget(self, action: #selector(PantallaSV.devuelve(_:)), forControlEvents: .TouchDown)
        volver.setTitle("Volver", forState: .Normal);
        volver.backgroundColor=UIColor.blueColor();
        //self.view.bringSubviewToFront(PanelElementos);
        //self.view.addSubview(volver);
        PanelElementos.addSubview(contenedor)
        self.view.bringSubviewToFront(PanelElementos);
        PanelElementos.bringSubviewToFront(contenedor);
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
        
        if(pasa){
            
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
        _ = CGRectMake(0, frame.height*0.9, frame.width, frame.height*0.1);
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
        
        print("LoncherActual: ", DatosC.contenedor.tipo!);
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
        cant = String(DatosB.cont.home2.lonchera.casillas.count);
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
