//
//  Olvida1.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 4/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Olvida1: UIViewController {
    
    var email: UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        iniciaTitulo();
        setFondo();
        hideKeyboardWhenTappedAround();
        iniciaBotonVolver();
        DatosB.cont.olvida1=self;
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginView.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
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
        label.text = "Déjanos tu correo y te enviaremos un mensaje para que recuperes tu contraseña";
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
        iniciaCorreo()
    }
    
    func iniciaCorreo(){
        let OY = self.view.frame.height*0.6;
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameLabel = CGRectMake(OX, OY, ancho, alto);
        let labEmail = UILabel(frame: frameLabel);
        labEmail.text = "Correo electrónico";
        labEmail.textAlignment=NSTextAlignment.Center;
        labEmail.font=UIFont(name: "Gotham Bold", size: labEmail.frame.height/2);
        labEmail.textColor=UIColor.grayColor();
        labEmail.adjustsFontSizeToFitWidth=true;

        //labEmail.backgroundColor=UIColor.redColor();
        self.view.addSubview(labEmail);
        iniciaTextEmail(OY+alto)
    }
    
    func iniciaTextEmail(yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.2;
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.05;
        let frameText = CGRectMake(OX, OY, ancho, alto);
        email = UITextField(frame: frameText);
        email.placeholder="Por Favor escribe tu correo"
        email.textColor=UIColor.grayColor();
        email.textAlignment=NSTextAlignment.Center;
        email.font=UIFont(name: "Gotham Bold", size: email.frame.height/2);
        email.adjustsFontSizeToFitWidth=true;
        email.autocapitalizationType=UITextAutocapitalizationType.None;
        //email.backgroundColor=UIColor.yellowColor();
        let framePers = CGRectMake(0, email.frame.height-2, email.frame.width, 2);
        DatosB.cont.poneFondoTot(email, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
        self.view.addSubview(email);
        iniciaBoton(OY+alto);
        //iniciaContrasena(OY+alto);
    }
    
    func iniciaBoton(yini: CGFloat){
        let OY = yini+self.view.frame.height*0.1;
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameBot = CGRectMake(OX, OY, ancho, alto);
        let ingresa = UIButton(frame: frameBot);
        DatosB.cont.poneFondoTot(ingresa, fondoStr: "Botón enviar", framePers: nil, identi: nil, scala: true);
        ingresa.addTarget(self, action: #selector(Olvida1.envia), forControlEvents: .TouchDown);
        self.view.addSubview(ingresa);
    }
    
    func envia(){
        let rest = PideRestauracion();
        rest.existe(email.text!, olvia: self);
        //cierraVista();
    }
    
    func cambia(){
        self.performSegueWithIdentifier("Olvida2", sender: nil);
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
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func mensajeCorreoEnviado(){
        let ancho = self.view.frame.width*0.8;
        let alto = self.view.frame.height*0.4;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = (self.view.frame.height/2)-(alto/2);
        let frameMens = CGRectMake(OX, OY, ancho, alto);
        let msg = MensajeCrea(frame: frameMens, msg: "Listo! Ahora entra a tu correo.!");
        msg.iniciaImagen3();
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(Olvida1.cierraVista), userInfo: nil, repeats: false);
        self.view.addSubview(msg);
    }
}
