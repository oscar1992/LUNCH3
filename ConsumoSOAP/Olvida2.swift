//
//  Olvida2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 5/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Olvida2: UIViewController , UITextFieldDelegate{
    
    var pass1: UITextField!;
    var pass2: UITextField!;
    var ingresa: UIButton!;
    var aprueba = false;
    var plogin : LoginView!;
    var vistaBloq : UIView!;

    
    override func viewDidLoad(){
        super.viewDidLoad();
        self.plogin=DatosB.cont.loginView;
        iniciaTitulo();
        setFondo();
        hideKeyboardWhenTappedAround();
        //iniciaBotonVolver();
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginView.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
        DatosB.cont.olvida2=self;
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        //print("Teclado: ", frame);
        DatosK.cont.tecladoFrame=frame;
        DatosK.cont.subeVista(self.view);
    }
    
    func iniciaTitulo(){
        let OY = self.view.frame.height*0.15;
        let OX = self.view.frame.width*0.2;
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.2;
        let frameTit=CGRectMake(OX, OY, ancho, alto);
        let titulo=UIView(frame: frameTit);
        titulo.userInteractionEnabled=false;
        DatosB.cont.poneFondoTot(titulo, fondoStr: "LogoLaLonchera", framePers: nil, identi: nil, scala: true);
        self.view.sendSubviewToBack(titulo);
        self.view.addSubview(titulo);
        iniciaTextoCuenta(OY+alto)
    }
    
    func iniciaTextoCuenta(yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.2;
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.2;
        let frameLabel = CGRectMake(OX, OY, ancho, alto);
        let frameBot = CGRectMake(OX, OY+(alto/4), ancho, alto/2);
        let label = UILabel(frame: frameLabel);
        label.text = "En esta pestaña podrás recuperar tu contraseña";
        label.numberOfLines=3;
        label.textAlignment=NSTextAlignment.Center;
        label.font=UIFont(name: "Gotham Bold", size: label.frame.height/6);
        label.adjustsFontSizeToFitWidth=true;
        label.textColor=UIColor.whiteColor();
        let bot = UIButton(frame: frameBot);
        bot.addTarget(self, action: #selector(LoginView.cuentaNueva(_:)), forControlEvents: .TouchDown);
        self.view.addSubview(bot);
        //label.bringSubviewToFront(bot);
        //bot.backgroundColor=UIColor.blueColor();
        self.view.addSubview(label);
        iniciaLab1();
    }
    
    func iniciaLab1(){
        let OY = self.view.frame.height*0.55;
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameLabel = CGRectMake(OX, OY, ancho, alto);
        let labEmail = UILabel(frame: frameLabel);
        labEmail.text = "Contraseña Nueva";
        labEmail.textAlignment=NSTextAlignment.Center;
        labEmail.font=UIFont(name: "Gotham Bold", size: labEmail.frame.height/2);
        labEmail.textColor=UIColor.grayColor();
        labEmail.adjustsFontSizeToFitWidth=true;
        //labEmail.backgroundColor=UIColor.redColor();
        self.view.addSubview(labEmail);
        iniciaTextPass1(OY+alto)
    }
    
    func iniciaTextPass1(yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.2;
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.05;
        let frameText = CGRectMake(OX, OY, ancho, alto);
        pass1 = UITextField(frame: frameText);
        pass1.placeholder="Escribe tu nueva Contraseña"
        pass1.textColor=UIColor.grayColor();
        pass1.textAlignment=NSTextAlignment.Center;
        pass1.font=UIFont(name: "Gotham Bold", size: pass1.frame.height/2);
        pass1.adjustsFontSizeToFitWidth=true;
        pass1.autocapitalizationType=UITextAutocapitalizationType.None;
        //email.backgroundColor=UIColor.yellowColor();
        let framePers = CGRectMake(0, pass1.frame.height-2, pass1.frame.width, 2);
        DatosB.cont.poneFondoTot(pass1, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
        self.view.addSubview(pass1);
        //iniciaBoton(OY+alto);
        iniciaLab2(OY+alto);
    }
    
    func iniciaLab2(yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameLabel = CGRectMake(OX, OY, ancho, alto);
        let labEmail = UILabel(frame: frameLabel);
        labEmail.text = "Confirma";
        labEmail.textAlignment=NSTextAlignment.Center;
        labEmail.font=UIFont(name: "Gotham Bold", size: labEmail.frame.height/2);
        labEmail.textColor=UIColor.grayColor();
        labEmail.adjustsFontSizeToFitWidth=true;
        //labEmail.backgroundColor=UIColor.redColor();
        self.view.addSubview(labEmail);
        iniciaTextPass2(OY+alto)
    }
    
    func iniciaTextPass2(yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.2;
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.05;
        let frameText = CGRectMake(OX, OY, ancho, alto);
        pass2 = UITextField(frame: frameText);
        pass2.placeholder="Confirma tu nueva contraseña"
        pass2.textColor=UIColor.grayColor();
        pass2.textAlignment=NSTextAlignment.Center;
        pass2.font=UIFont(name: "Gotham Bold", size: pass2.frame.height/2);
        pass2.adjustsFontSizeToFitWidth=true;
        pass2.delegate=self;
        pass2
            .autocapitalizationType=UITextAutocapitalizationType.None;
        //email.backgroundColor=UIColor.yellowColor();
        let framePers = CGRectMake(0, pass2.frame.height-2, pass2.frame.width, 2);
        DatosB.cont.poneFondoTot(pass2, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
        self.view.addSubview(pass2);
        iniciaBotones(OY+alto);
        //iniciaContrasena(OY+alto);
    }
    
    func iniciaBotones(yini: CGFloat){
        let OY = yini+self.view.frame.height*0.05;
        let OX = self.view.frame.width*0.2;
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.05;
        let frameBot = CGRectMake(OX, OY, ancho, alto);
        let framebot2 = CGRectMake(OX, OY+(alto*1.7), ancho, alto);
        ingresa = UIButton(frame: frameBot);
        let ingresa2 = UIButton(frame: framebot2);
        DatosB.cont.poneFondoTot(ingresa, fondoStr: "Botón enviar", framePers: nil, identi: nil, scala: true);
        DatosB.cont.poneFondoTot(ingresa2, fondoStr: "Botón Cancelar", framePers: nil, identi: nil, scala: true);
        ingresa.addTarget(self, action: #selector(Olvida2.cambiaPass), forControlEvents: .TouchDown);
        ingresa2.addTarget(self, action: #selector(Olvida2.cierraVista), forControlEvents: .TouchDown);
        self.view.addSubview(ingresa);
        self.view.addSubview(ingresa2);
    }
    
    func setFondo(){
        let OY = self.view.frame.height/2;
        let ancho = self.view.frame.width;
        let frame1 = CGRectMake(0, 0, ancho, OY);
        let frame2 = CGRectMake(0, OY, ancho, OY);
        let fondo1 = UIView(frame: frame1);
        let fondo2 = UIView(frame: frame2);
        self.view.addSubview(fondo1);
        self.view.addSubview(fondo2);
        self.view.sendSubviewToBack(fondo1);
        self.view.sendSubviewToBack(fondo2);
        DatosB.cont.poneFondoTot(fondo1, fondoStr: "FondoDegradado", framePers: nil, identi: nil, scala: false);
        DatosB.cont.poneFondoTot(fondo2, fondoStr: "FondoBlanco", framePers: nil, identi: nil, scala: false);
    }
    
    func hideKeyboardWhenTappedAround() {
        //print("setea el h")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        DatosK.cont.bajaVista(self.view);
        self.view.endEditing(true)
    }
    
    //Método que oculta la barra en este viewcontroller
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let ancho2 = ancho/3;
        let centr = (ancho/2)-(ancho2/2);
        let frameBoton = CGRectMake(0, 0, ancho, ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(Olvida1.cierraVista), forControlEvents: .TouchDown);
        let subFrame = CGRectMake(centr, centr, ancho2, ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "FlechaVBlanco", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    func cierraVista(){
        //self.dismissViewControllerAnimated(true, completion: nil);
        DatosK.cont.bajaVista(self.view);
        plogin.pass.text="";
        plogin.desbloquea();
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "user");
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "pass");
        
    }
    
    func cambiaPass(){
        bloquea();
        if(pass2.text != ""&&validaLargo()){
            let actua=ActualizaPadre();
            actua.vista=self;
            actua.actualizaPadre(padre(pass2.text!));
            
        }else{
            msgValidacion("La contraseña debe ser mayor de 6 caracteres");
        }
        
    }
    
    func finCambia(cambi: Bool){
        desbloquea();
        if(cambi){
            if(plogin != nil){
                plogin.desbloquea();
            }
            //
            cierraVista();
            msgValidacion("Contraseña Cambiada con éxito");
                        //DatosB();
            DatosB.cont.cargaProductos=true;
            DatosC.elimina();
            DatosD.elimina();
            self.dismissViewControllerAnimated(true, completion: nil);
        }else{
            let ancho = self.view.frame.width*0.8;
            let alto = self.view.frame.height*0.4;
            let OX = (self.view.frame.width/2)-(ancho/2);
            let OY = (self.view.frame.height/2)-(alto/2);
            let frameMensaje = CGRectMake(OX, OY, ancho, alto);
            let mensaje = MensajeConexion(frame: frameMensaje, msg: nil);
            self.view.addSubview(mensaje);
            mensaje.layer.zPosition=5;
            self.view.bringSubviewToFront(mensaje);
        }
        
    }
    
    func pasa(){
        aprueba=true;
        //DatosB.cont.loginView.ingresa.enabled=true;
        self.performSegueWithIdentifier("Ingresa3", sender: nil);
    }
    
    func padre(pass: String)->Padre{
        let padre = DatosD.contenedor.padre;
        padre.pass=pass;
        print("pad: ",padre.nombre);
        return padre;
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        //print("fin: ", textField.text);
        if(textField.text != pass1.text){
            print("Diferentes");
            msgValidacion("Las contraseñas no coinciden");
            ingresa.enabled=false;
        }else{
            ingresa.enabled=true;
        }
    }
    
    func validaLargo()->Bool{
        if(pass1.text?.characters.count<6){
            return false;
        }else{
            return true;
        }
    }
    
    func msgValidacion(mensaje: String){
        let ancho = self.view.frame.width*0.8;
        let alto = self.view.frame.height*0.4;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = (self.view.frame.height/2)-(alto/2);
        let frameMens = CGRectMake(OX, OY, ancho, alto);
        let msg = MensajeCrea(frame: frameMens, msg: mensaje, gif: false);
        msg.iniciaTimer();
        self.view.addSubview(msg);
    }
    
    func bloquea(){
        let ancho = self.view.frame.width;
        let alto = self.view.frame.height;
        let rect = CGRectMake(0, 0, ancho, alto);
        //vistaBloq = UIView(frame: rect);
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light);
        vistaBloq = UIVisualEffectView(effect: blurEffect)
        vistaBloq.backgroundColor=UIColor.blueColor();
        vistaBloq.frame=rect;
        self.view.addSubview(vistaBloq);
    }
    
    func desbloquea(){
        if(self.vistaBloq != nil){
            vistaBloq.removeFromSuperview();
        }
    }
}
