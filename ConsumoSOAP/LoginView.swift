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
        if(UserDefaults.standard.string(forKey: "user")==nil||UserDefaults.standard.string(forKey: "pass")==nil){
            print("Login sin datos");
        }else{
            loginViejo();
        }
        
        super.viewDidLoad();
        //botTest();
        
        hideKeyboardWhenTappedAround();
        iniciaTitulo();
        setFondo();
        
        self.view.accessibilityIdentifier="LOG";
        NotificationCenter.default.addObserver(self, selector: #selector(LoginView.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        UIApplication.shared.isIdleTimerDisabled=true;
        //errorZip();
        // Do any additional setup after loading the view.
    }
    
    func keyboardWillShow(_ notification: Notification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //print("Teclado: ", frame);
        DatosK.cont.tecladoFrame=frame;
        DatosK.cont.subeVista(self.view);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func ingresa(_ sender: UIButton) {
        
        if(email.text != nil && pass.text != nil){
            
            
                let login = ConsultaLogin(plogin: self);
                login.PLogin=self;
                login.consulta(email.text!, pass: pass.text!);
                ingresa!.isEnabled=false;
            
           // print("t1");
            
        }
    }
    
    func pasa(){
        //

        if(aprueba == true){
            if esRecupera(pass.text!){
                print("Cambia PASS")
                self.performSegue(withIdentifier: "Olvida2", sender: nil);
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
            
            ingresa!.isEnabled=true;
            let ancho = self.view.frame.width*0.8;
            let alto = self.view.frame.height*0.4;
            let OX = (self.view.frame.width/2)-(ancho/2);
            let OY = (self.view.frame.height/2)-(alto/2);
            let frameMensaje = CGRect(x: OX, y: OY, width: ancho, height: alto);
            let mensaje = MensajeConexion(frame: frameMensaje, msg: self.Msg);
            mensaje.iniciaTimer();
            mensaje.layer.zPosition=5;
            self.view.addSubview(mensaje);
            self.view.bringSubview(toFront: mensaje);
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
            self.performSegue(withIdentifier: "Ingresa", sender: nil);
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
        let frame1 = CGRect(x: 0, y: 0, width: ancho, height: OY);
        let frame2 = CGRect(x: 0, y: OY, width: ancho, height: OY);
        let fondo1 = UIView(frame: frame1);
        let fondo2 = UIView(frame: frame2);
        self.view.addSubview(fondo1);
        self.view.addSubview(fondo2);
        self.view.sendSubview(toBack: fondo1);
        self.view.sendSubview(toBack: fondo2);
        DatosB.cont.poneFondoTot(fondo1, fondoStr: "FondoDegradado", framePers: nil, identi: nil, scala: false);
        DatosB.cont.poneFondoTot(fondo2, fondoStr: "FondoBlanco", framePers: nil, identi: nil, scala: false);
    }
    
    func iniciaTitulo(){
        let OY = self.view.frame.height*0.15;
        let OX = self.view.frame.width*0.2;
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.2;
        let frameTit=CGRect(x: OX, y: OY, width: ancho, height: alto);
        let titulo=UIView(frame: frameTit);
        titulo.isUserInteractionEnabled=false;
        DatosB.cont.poneFondoTot(titulo, fondoStr: "LogoLaLonchera", framePers: nil, identi: nil, scala: true);
        self.view.sendSubview(toBack: titulo);
        self.view.addSubview(titulo);
        iniciaTextoCuenta(OY+alto)
    }
    
    func iniciaTextoCuenta(_ yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.2;
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.2;
        let frameLabel = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let frameBot = CGRect(x: OX, y: OY+(alto/4), width: ancho, height: alto/2);
        let label = UILabel(frame: frameLabel);
        label.text = "¿No tienes una cuenta? Toca aquí para crearla";
        label.numberOfLines=2;
        label.textAlignment=NSTextAlignment.center;
        label.font=UIFont(name: "Gotham Bold", size: label.frame.height/6);
        label.adjustsFontSizeToFitWidth=true;
        label.textColor=UIColor.white;
        let bot = UIButton(frame: frameBot);
        bot.addTarget(self, action: #selector(LoginView.cuentaNueva(_:)), for: .touchDown);
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
        let frameLabel = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let labEmail = UILabel(frame: frameLabel);
        labEmail.text = "Correo electrónico";
        labEmail.textAlignment=NSTextAlignment.center;
        labEmail.font=UIFont(name: "Gotham Bold", size: labEmail.frame.height/2);
        labEmail.textColor=UIColor.gray;
        labEmail.adjustsFontSizeToFitWidth=true;
        //labEmail.backgroundColor=UIColor.redColor();
        self.view.addSubview(labEmail);
        iniciaTextEmail(OY+alto)
    }
    
    func iniciaTextEmail(_ yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.15;
        let ancho = self.view.frame.width*0.7;
        let alto = self.view.frame.height*0.05;
        let frameText = CGRect(x: OX, y: OY, width: ancho, height: alto);
        if(email == nil){
            email = UITextField();
        }
        email.frame=frameText;
        email.placeholder="Por Favor escribe tu correo"
        email.textColor=UIColor.gray;
        email.textAlignment=NSTextAlignment.center;
        email.font=UIFont(name: "Gotham Bold", size: email.frame.height/2);
        email.adjustsFontSizeToFitWidth=true;
        //email.backgroundColor=UIColor.yellowColor();
        let framePers = CGRect(x: 0, y: email.frame.height-2, width: email.frame.width, height: 2);
        DatosB.cont.poneFondoTot(email, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
        iniciaContrasena(OY+alto);
    }
    
    func iniciaContrasena(_ yini: CGFloat){
        let OY = yini
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameLabel = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let labContra = UILabel(frame: frameLabel);
        labContra.text = "Contraseña";
        labContra.textAlignment=NSTextAlignment.center;
        labContra.font=UIFont(name: "Gotham Bold", size: labContra.frame.height/2);
        labContra.textColor=UIColor.gray;
        labContra.adjustsFontSizeToFitWidth=true;
        //labContra.backgroundColor=UIColor.redColor();
        self.view.addSubview(labContra);
        iniciaTextContra(OY+alto);
    }
    
    func iniciaTextContra(_ yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.15;
        let ancho = self.view.frame.width*0.7;
        let alto = self.view.frame.height*0.05;
        let frameText = CGRect(x: OX, y: OY, width: ancho, height: alto);
        if(pass == nil){
            pass = UITextField();
        }
        pass.frame=frameText;
        pass.placeholder="Por favor escribe tu contraseña"
        pass.textColor=UIColor.gray;
        pass.textAlignment=NSTextAlignment.center;
        pass.font=UIFont(name: "Gotham Bold", size: email.frame.height/2);
        pass.adjustsFontSizeToFitWidth=true;
        let framePers = CGRect(x: 0, y: email.frame.height-2, width: email.frame.width, height: 2);
        DatosB.cont.poneFondoTot(pass, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
        iniciaRecu(OY+alto);
        iniciaBotonLogin(OY+alto);
        //pass.backgroundColor=UIColor.yellowColor();
    }
    
    func iniciaRecu(_ yini: CGFloat){
        let OY = yini;
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameText = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let recupera = UILabel(frame: frameText);
        let bot = UIButton(frame: CGRect(x: OX, y: OY, width: ancho, height: alto));
        bot.addTarget(self, action: #selector(LoginView.pasaOlvido), for: .touchDown);
        //bot.backgroundColor=UIColor.yellowColor();
        recupera.text="¿Olvidaste tu contraseña?";
        recupera.textAlignment=NSTextAlignment.center;
        recupera.font=UIFont(name: "Gotham Bold", size: recupera.frame.height/2);
        recupera.textColor=UIColor.gray;
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
        self.performSegue(withIdentifier: "Olvido", sender: nil);
    }
    
    func iniciaBotonLogin(_ yini: CGFloat){
        let OY = yini+self.view.frame.height*0.1;
        let OX = self.view.frame.width*0.3;
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.05;
        let frameBot = CGRect(x: OX, y: OY, width: ancho, height: alto);
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
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func cuentaNueva(_ sender: AnyObject){
        //print("aaaaaa");
        self.performSegue(withIdentifier: "NuevaCuenta", sender: nil);
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
        ingresa!.isEnabled=true;
    }
    
    func loginViejo(){
        if(UserDefaults.standard.object(forKey: "user")==nil||UserDefaults.standard.object(forKey: "pass")==nil){
            print("Vacio");
        }else{
            bloquea();
            let user = UserDefaults.standard.string(forKey: "user");
            let pass = UserDefaults.standard.string(forKey: "pass");
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
    
    func guarda(_ ema: String, pas: String){
        print("ema: ", ema);
        print("pas: ", pas);
        UserDefaults.standard.set(ema, forKey: "user");
        UserDefaults.standard.set(pas, forKey: "pass");
    }
    
    func esRecupera(_ text: String)->Bool{
        if(text.characters.count>0){
            let tot = text.characters.count-1;
            let primera = text.substring(with: (text.startIndex ..< text.characters.index(text.endIndex, offsetBy: -tot)));
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
    
    func mensaje(_ msg: String){
        let ancho = self.view.frame.width*1;
        let alto = self.view.frame.height*1;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = (self.view.frame.height/2)-(alto/2);
        let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let msg = MensajeCrea(frame: frameMens, msg: msg, gif: true);
        
        msg.layer.zPosition=1;
        msg.accessibilityIdentifier="msg";
        self.view.addSubview(msg);
    }
    
    
    func botTest(){
        let ancho = self.view.frame.width*0.2;
        let frame = CGRect(x: 0, y: 0, width: ancho, height: ancho);
        let bot = UIButton(frame: frame);
        bot.backgroundColor=UIColor.blue;
        self.view.addSubview(bot);
        bot.addTarget(self, action: #selector(LoginView.poliogono), for: .touchDown);
    }
    
    func poliogono(){
        let cargaNod = CargaNodos();
        cargaNod.cargaNodosA();
    }
    
    var vista : UIView!;
    var texto : UILabel?;
    var barra : UIProgressView!;
    
    func iniciamsg(){
        if(vista == nil){
            print("Inicia Msg");
            let alto = DatosC.contenedor.altoP;
            let ancho = DatosC.contenedor.anchoP;
            let rect = CGRect(x: 0, y: 0, width: ancho, height: alto);
            vista = UIView(frame: rect);
            let alto2 = DatosC.contenedor.altoP * 0.2;
            let OY = DatosC.contenedor.altoP * 0.8;
            let rect2 = CGRect(x: DatosC.contenedor.anchoP*0.1, y: OY, width: DatosC.contenedor.anchoP*0.8, height: alto2);
            
            let anchoG = ancho*0.1;
            let OX = (ancho/2)-(anchoG/2);
            let OY2=alto2+OY;
            let rect3 = CGRect(x: OX, y: OY, width: anchoG, height: anchoG);
            
            let imaGif = UIImage.gifImageWithName("spinner");
            let gif = UIImageView(image: imaGif);
            gif.contentMode = UIViewContentMode.scaleAspectFill;
            gif.frame=rect3;
            vista.addSubview(gif);
            barra = UIProgressView(frame: rect2);
            barra.progressTintColor=UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1);
            //barra.progress=0.5;
            vista.addSubview(barra);
            
            texto = UILabel(frame: rect2);
            texto!.textAlignment=NSTextAlignment.center;
            texto!.text="";
            texto!.textColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
            texto?.font=UIFont(name: "Gotham Bold", size: alto2/4);
            //vista.addSubview(texto!);
            print("Agrega MDG: ", texto?.text);
            
            self.view.addSubview(vista);
            vista.layer.zPosition=1;
        }
        
        
    }
    
    var vmsg : UIView!;
    
    func errorZip(){
        print("Ini?");
        let ancho = self.view.frame.width*0.8 ;
        let alto = self.view.frame.height*0.5;
        let OX = (self.view.frame.width - ancho)/2;
        let OY = (self.view.frame.height-alto)/2;
        let tama = CGRect(x: OX, y: OY, width: ancho, height: alto);
        vmsg = ErrorZip(frame: tama);
        //vmsg.backgroundColor=UIColor.blueColor();
        vista.addSubview(vmsg);
        print("Tama: ", vmsg);
        
    }


}
