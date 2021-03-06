//
//  Home2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 1/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Home2: UIViewController {
    
    
    @IBOutlet weak var laBarra: LaBarra!
    var predeterminadas:Pred2!;
    var lonchera:Lonchera2!;
    var botonCarrito:BotonCarrito!;
    var panelInfo:DetalleProducto!;
    var sentido = false;
    var menu: UIView!;
    var BotonMenu:UIButton!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround();
        DatosB.cont.home2=self;
        //leefuentes()
        iniciaBotonMenu();
        iniciaBotonCarrito();
        iniciaPredeterminadas();
        iniciaLonchera();
        iniciaBotonAgregar();
        iniciaMenuLateral();
        //iniciaCargaCajas();
        let fondo = CGRect(x: 0, y: laBarra.frame.height, width: self.view.frame.width, height: (self.view.frame.height-laBarra.frame.height));
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: fondo, identi: "FondoTot", scala: false);
        //print("carga home");
        predeterminadas.cargaSaludables();
        iniciaTutorial();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Método que oculta la barra en este viewcontroller
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //Método que Inicia el Botoón del Menú
    func iniciaBotonMenu(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let frameBoton = CGRect(x: 0, y: 0, width: ancho, height: ancho);
        print("iniciaBoton");
        BotonMenu = UIButton(frame: frameBoton);
        //BotonMenu.backgroundColor=UIColor.redColor();
        BotonMenu.addTarget(self, action: #selector(Home2.muestra), for: .touchDown);
        DatosB.cont.poneFondoTot(BotonMenu, fondoStr: "MenuLat", framePers: CGRect(x: ancho/3, y: ancho/3, width: ancho*0.3, height: ancho*0.3), identi: nil, scala: false);
        self.view.addSubview(BotonMenu);
    }
    
    //Método que inicia el botón del carrito
    func iniciaBotonCarrito(){
        let OX = DatosC.contenedor.anchoP-(DatosC.contenedor.altoP * 0.0922);
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let frameBoton = CGRect(x: OX, y: 0, width: ancho, height: ancho);
        botonCarrito = BotonCarrito(frame: frameBoton);
        //botonCarrito.backgroundColor=UIColor.blueColor();
        self.view.bringSubview(toFront: botonCarrito);
        self.view.addSubview(botonCarrito);
    }
    
    //Método que inicia el espacio de las loncheras predeterminadas
    func iniciaPredeterminadas(){
        //let cargaF = CargaFavoritos();
        //cargaF.consulta(DatosD.contenedor.padre.id);
        let frame = CGRect(x: 0, y: DatosC.contenedor.altoP * 0.12, width: DatosC.contenedor.anchoP, height: (DatosC.contenedor.altoP*0.16866));
        predeterminadas = Pred2(frame: frame);
        
        //DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoPredeterminadas", framePers: frame, identi: "FondoPred" , scala: false);
        self.view.addSubview(predeterminadas);
        
    }
    
    //Método que inicia la lonchera
    func iniciaLonchera(){
        let ancho = DatosC.contenedor.anchoP*0.9;
        let alto = DatosC.contenedor.altoP*0.4;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.30;
        let frameLonchera = CGRect(x: OX, y: OY, width: ancho, height: alto);
        lonchera = Lonchera2(frame: frameLonchera);
        //lonchera.backgroundColor=UIColor.blueColor();
        self.view.addSubview(lonchera);
    }
    
    //Método que inicia el boton de agregar al carrito
    func iniciaBotonAgregar(){
        let ancho = DatosC.contenedor.anchoP*0.7;
        let alto = DatosC.contenedor.altoP*0.07;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.9;
        let frameBoton = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let boton = UIButton(frame: frameBoton);
        /*
        let frameLabel = CGRectMake(0, 0, ancho, alto);
        let label = UILabel(frame: frameLabel);
        label.text="Agregar al Carrito";
        label.textAlignment=NSTextAlignment.Center;
        label.textColor=UIColor.whiteColor();
        label.font=UIFont(name: "SansBeamBody-Heavy", size: (label.frame.height/2));
        boton.addSubview(label);
         */
        DatosB.cont.poneFondoTot(boton, fondoStr: "BotonOrdenar2", framePers: nil, identi: nil, scala: false);
        boton.addTarget(self, action: #selector(Home2.anade), for: .touchDown);
        
        self.view.addSubview(boton);
    }
    
    //Método que permite añadir una lonchera al carrito
    func anade(){
        let ancho = DatosC.contenedor.anchoP*0.8
        let ox = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let oy = (DatosC.contenedor.altoP/2)-(ancho/2);
        let frameLet = CGRect(x: ox, y: oy, width: ancho, height: ancho);
        if(lonchera.estaLLena()){
            let letrero = LetreroAgregar(frame: frameLet, lonchera: lonchera);
            self.view.addSubview(letrero);
        }else{
            
            print("Vacía");
        }
        
    }
    
    func leefuentes(){
        let ff = UIFont.familyNames;
        for nn in ff{
            print(nn);
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Método que se llama desde un producto para mostrar su información
    func iniciaPanelInfo(_ prod: Producto){
        let bordeL = CGFloat(self.view.frame.width*0.1);
        let bordeA = CGFloat(self.view.frame.height*0.09);
        
        
        let frame = CGRect(x: bordeL, y: bordeA, width: self.view.frame.width*0.79, height: self.view.frame.height*0.9);
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
    
    func muestra(){
        let mov = -self.view.frame.width;
        mueveMenu(mov, vista: menu);
    }
    
    func mueveMenu(_ mov: CGFloat, vista: UIView){
        let tiempo = 0.3;
        var movi = CGFloat(0);
        if(sentido){
            movi = mov;
            sentido=false;
        }else{
            sentido=true;
            movi = -mov;
        }
        UIView.beginAnimations("DeslizaMenu", context: nil);
        UIView.setAnimationBeginsFromCurrentState(true);
        UIView.setAnimationDuration(tiempo);
        vista.frame = vista.frame.offsetBy(dx: movi, dy: 0);
        UIView.commitAnimations();
    }
    
    func iniciaMenuLateral(){
        /*
        let ancho = self.view.frame.width*0.7;
        let alto = self.view.frame.height*0.7;
        let OX = -ancho;
        let OY = BotonMenu.frame.height;
        let frame = CGRectMake(OX, OY, ancho, alto);
         */
        menu = Menu(padre:self);
        //menu.backgroundColor=UIColor.greenColor();
        self.view.addSubview(menu);
    }
    
    //Mñetodo que inicia el Pop Up del chulo al agregar un producto
    func chulo(){
        print("Chulo");
        let msgChulo=MensajeChulo();
        self.view.addSubview(msgChulo);
    }
    
    
    let tut = BaseImagenes(transitionStyle: UIPageViewControllerTransitionStyle.scroll,
                           navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal,
                           options: nil);
    
    //Método que inicia el tutorial, si es la primera vez que inicia la app
    func iniciaTutorial(){
        if(DatosD.contenedor.padre.primeraVez==true){
            self.view.addSubview(tut.view);
            tut.view.frame=CGRect(x: 0, y: 0, width: self.view.frame.width*1, height: self.view.frame.height/1);
            
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
