//
//  LoginView.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 25/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit


class LoginView: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var ingresa: UIButton?;
    
    var aprueba:Bool=false;
    var Msg:String!;
    var entraNormal = false;
    
    override func viewDidLoad() {
        
        DatosB.cont.loginView=self;
        if(NSUserDefaults.standardUserDefaults().objectForKey("user")==nil||NSUserDefaults.standardUserDefaults().objectForKey("pass")==nil){
            
        }else{
            loginViejo();
        }
        
        super.viewDidLoad();
        //botTest();
        
        hideKeyboardWhenTappedAround();
        iniciaTitulo();
        setFondo();
        
        self.view.accessibilityIdentifier="LOG";
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginView.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
        
        
        // Do any additional setup after loading the view.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        //print("Teclado: ", frame);
        DatosK.cont.tecladoFrame=frame;
        DatosK.cont.subeVista(self.view);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func ingresa(sender: UIButton) {
        
        if(email.text != nil && pass.text != nil){
            
            
                let login = ConsultaLogin(plogin: self);
                login.PLogin=self;
                login.consulta(email.text!, pass: pass.text!);
                ingresa!.enabled=false;
            
           // print("t1");
            
        }
    }
    
    func pasa(){
        //

        if(aprueba == true){
            if esRecupera(pass.text!){
                print("Cambia PASS")
                self.performSegueWithIdentifier("Olvida2", sender: nil);
            }else{
                iniciamsg();
                //iniciaCargaCajas();
                guarda(email.text!, pas: pass.text!);
                print("Proceda Señor");
                entraNormal=true;
                _ = CargaInicial(log: self);
                if(DatosB.cont.cargaProductos != nil && DatosB.cont.cargaProductos == true){
                    //pasa2();
                }else{
                    //desbloquea();
                    print("DatosB: ",DatosB.cont.cargaProductos);
                    
                }
                //self.performSegueWithIdentifier("Ingresa", sender: nil);
            }
        }else{
            for sub in self.view.subviews{
                if(sub.accessibilityIdentifier=="msg"){
                    sub.removeFromSuperview();
                }
            }
            
            ingresa!.enabled=true;
            let ancho = self.view.frame.width*0.8;
            let alto = self.view.frame.height*0.4;
            let OX = (self.view.frame.width/2)-(ancho/2);
            let OY = (self.view.frame.height/2)-(alto/2);
            let frameMensaje = CGRectMake(OX, OY, ancho, alto);
            let mensaje = MensajeConexion(frame: frameMensaje, msg: self.Msg);
            mensaje.iniciaTimer();
            mensaje.layer.zPosition=5;
            self.view.addSubview(mensaje);
            self.view.bringSubviewToFront(mensaje);
            self.viewDidLoad();
            self.Msg=nil;
            DatosB.elimina();
            //DatosB.cont.cargaProductos=true;
            DatosC.elimina();
            DatosD.elimina();
            //self.performSegueWithIdentifier("Ingresa2", sender: nil);
            //print("No Proceda Señor");
        }
    }
    
    func pasa2(){
        if(DatosB.cont.olvida2.aprueba||entraNormal){
            print("pasa2");
            self.performSegueWithIdentifier("Ingresa", sender: nil);
            desbloquea();
        }
        
        
    }
    
    func iniciaCargaCajas(){
        //let cargaC = CargaCajas();
        //cargaC.CargaCajas(self);
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
        label.text = "¿No tienes una cuenta? Toca aquí para crearla";
        label.numberOfLines=2;
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
        iniciaCorreo();
    }
    
    func iniciaCorreo(){
        let OY = self.view.frame.height*0.55;
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
        let OX = self.view.frame.width*0.15;
        let ancho = self.view.frame.width*0.7;
        let alto = self.view.frame.height*0.05;
        let frameText = CGRectMake(OX, OY, ancho, alto);
        if(email == nil){
            email = UITextField();
        }
        email.frame=frameText;
        email.placeholder="Por Favor escribe tu correo"
        email.textColor=UIColor.grayColor();
        email.textAlignment=NSTextAlignment.Center;
        email.font=UIFont(name: "Gotham Bold", size: email.frame.height/2);
        email.adjustsFontSizeToFitWidth=true;
        //email.backgroundColor=UIColor.yellowColor();
        let framePers = CGRectMake(0, email.frame.height-2, email.frame.width, 2);
        DatosB.cont.poneFondoTot(email, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
        iniciaContrasena(OY+alto);
    }
    
    func iniciaContrasena(yini: CGFloat){
        let OY = yini
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameLabel = CGRectMake(OX, OY, ancho, alto);
        let labContra = UILabel(frame: frameLabel);
        labContra.text = "Contraseña";
        labContra.textAlignment=NSTextAlignment.Center;
        labContra.font=UIFont(name: "Gotham Bold", size: labContra.frame.height/2);
        labContra.textColor=UIColor.grayColor();
        labContra.adjustsFontSizeToFitWidth=true;
        //labContra.backgroundColor=UIColor.redColor();
        self.view.addSubview(labContra);
        iniciaTextContra(OY+alto);
    }
    
    func iniciaTextContra(yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.15;
        let ancho = self.view.frame.width*0.7;
        let alto = self.view.frame.height*0.05;
        let frameText = CGRectMake(OX, OY, ancho, alto);
        if(pass == nil){
            pass = UITextField();
        }
        pass.frame=frameText;
        pass.placeholder="Por favor escribe tu contraseña"
        pass.textColor=UIColor.grayColor();
        pass.textAlignment=NSTextAlignment.Center;
        pass.font=UIFont(name: "Gotham Bold", size: email.frame.height/2);
        pass.adjustsFontSizeToFitWidth=true;
        let framePers = CGRectMake(0, email.frame.height-2, email.frame.width, 2);
        DatosB.cont.poneFondoTot(pass, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
        iniciaRecu(OY+alto);
        iniciaBotonLogin(OY+alto);
        //pass.backgroundColor=UIColor.yellowColor();
    }
    
    func iniciaRecu(yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameText = CGRectMake(OX, OY, ancho, alto);
        let recupera = UILabel(frame: frameText);
        let bot = UIButton(frame: CGRectMake(OX, OY, ancho, alto));
        bot.addTarget(self, action: #selector(LoginView.pasaOlvido), forControlEvents: .TouchDown);
        //bot.backgroundColor=UIColor.yellowColor();
        recupera.text="¿Olvidaste tu contraseña?";
        recupera.textAlignment=NSTextAlignment.Center;
        recupera.font=UIFont(name: "Gotham Bold", size: recupera.frame.height/2);
        recupera.textColor=UIColor.grayColor();
        recupera.adjustsFontSizeToFitWidth=true;
        self.view.addSubview(bot);
        self.view.addSubview(recupera);
    }
    
    func pasaOlvido(){
        for sub in self.view.subviews{
            if(sub.accessibilityIdentifier=="msg"){
                sub.removeFromSuperview();
            }
        }
        self.performSegueWithIdentifier("Olvido", sender: nil);
    }
    
    func iniciaBotonLogin(yini: CGFloat){
        let OY = yini+self.view.frame.height*0.1;
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameBot = CGRectMake(OX, OY, ancho, alto);
        //ingresa = UIButton(frame: frameBot);
        if(ingresa == nil){
            ingresa = UIButton(frame: frameBot);
            print("nulo: ", ingresa);
        }
        
        ingresa!.frame=frameBot;
        
        
        DatosB.cont.poneFondoTot(ingresa!, fondoStr: "Botón ENTRAR", framePers: nil, identi: nil, scala: true)
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
    
    func cuentaNueva(sender: AnyObject){
        //print("aaaaaa");
        self.performSegueWithIdentifier("NuevaCuenta", sender: nil);
    }
    
    func bloquea(){
        mensaje("");
        //let msg = UILabel(frame: CGRectMake(0, 0, frameB.width, frameB.height));
        //msg.text="Conectando...";
        //msg.adjustsFontSizeToFitWidth=true;
        //msg.font=UIFont(name: "SansBeam Head", size: (msg.frame.height));
        //msg.textAlignment=NSTextAlignment.Center;
        
    }
    
    func desbloquea(){
        for vista in self.view.subviews{
            if(vista.accessibilityIdentifier=="msg"){
                vista.removeFromSuperview();
            }
        }
        ingresa!.enabled=true;
    }
    
    func loginViejo(){
        if(NSUserDefaults.standardUserDefaults().objectForKey("user")==nil||NSUserDefaults.standardUserDefaults().objectForKey("pass")==nil){
            print("Vacio");
        }else{
            bloquea();
            let user = NSUserDefaults.standardUserDefaults().objectForKey("user") as! String;
            let pass = NSUserDefaults.standardUserDefaults().objectForKey("pass") as! String;
            if(DatosD.contenedor.padre.email != nil || DatosD.contenedor.padre.pass != nil){
                //self.email.text=DatosD.contenedor.padre.email;
                //self.pass.text=DatosD.contenedor.padre.pass;
            }else{
                self.email.text=user;
                self.pass.text=pass;
                print("oooo: ", user);
                ingresa(ingresa!);
            }
            
            
        }
    }
    
    func guarda(ema: String, pas: String){
        print("ema: ", ema);
        print("pas: ", pas);
        NSUserDefaults.standardUserDefaults().setObject(ema, forKey: "user");
        NSUserDefaults.standardUserDefaults().setObject(pas, forKey: "pass");
    }
    
    func esRecupera(text: String)->Bool{
        if(text.characters.count>0){
            let tot = text.characters.count-1;
            let primera = text.substringWithRange(Range<String.Index>(start: text.startIndex, end: text.endIndex.advancedBy(-tot)));
            print("primera: ", primera);
            if(primera == "#"){
                return true;
            }else{
                return false;
            }
        }else{
            return false;
        }
        
        
    }
    
    func mensaje(msg: String){
        let ancho = self.view.frame.width*1;
        let alto = self.view.frame.height*1;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = (self.view.frame.height/2)-(alto/2);
        let frameMens = CGRectMake(OX, OY, ancho, alto);
        let msg = MensajeCrea(frame: frameMens, msg: msg);
        
        msg.layer.zPosition=1;
        msg.accessibilityIdentifier="msg";
        self.view.addSubview(msg);
    }
    
    
    func botTest(){
        let ancho = self.view.frame.width*0.2;
        let frame = CGRectMake(0, 0, ancho, ancho);
        let bot = UIButton(frame: frame);
        bot.backgroundColor=UIColor.blueColor();
        self.view.addSubview(bot);
        bot.addTarget(self, action: #selector(LoginView.poliogono), forControlEvents: .TouchDown);
    }
    
    func poliogono(){
        let cargaNod = CargaNodos();
        cargaNod.cargaNodosA();
    }
    
    var vista : UIView!;
    //var texto : UILabel?;
    var barra : UIProgressView!;
    
    func iniciamsg(){
        if(vista == nil){
            print("Inicia Msg");
            let alto = DatosC.contenedor.altoP;
            let ancho = DatosC.contenedor.anchoP;
            let rect = CGRectMake(0, 0, ancho, alto);
            vista = UIView(frame: rect);
            let alto2 = DatosC.contenedor.altoP * 0.2;
            let OY = DatosC.contenedor.altoP * 0.8;
            let rect2 = CGRectMake(0, OY, DatosC.contenedor.anchoP, alto2);
            barra = UIProgressView(frame: rect2);
            barra.progressTintColor=UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1);
            //barra.progress=0.5;
            vista.addSubview(barra);
            /*
            texto = UILabel(frame: rect2);
            texto!.textAlignment=NSTextAlignment.Center;
            texto!.text="0%";
            texto!.textColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
            texto?.font=UIFont(name: "Gotham Bold", size: alto2/2);
            vista.addSubview(texto!);
            print("Agrega MDG: ", texto?.text);
            */
            self.view.addSubview(vista);
            vista.layer.zPosition=1;
        }
        
        
    }
    



}
