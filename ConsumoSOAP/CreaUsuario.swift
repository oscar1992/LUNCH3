//
//  CreaUsuario.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 30/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CreaUsuario: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var email:UITextField!;
    var pass = UITextField();
    var bot:UIButton!;
    var foto:VistaFoto!;
    var emailValido=false;
    var passValido = false;
    var emailExistente = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround();
        iniciaTitulo();
        iniciaBotonVolver();
        poneFondo();
        DatosK.cont.arriba=true;
        self.view.accessibilityIdentifier="CRE";
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CreaUsuario.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CreaUsuario.dismissKeyboard), name: UIKeyboardWillHideNotification, object: nil);

    }
    
    func keyboardWillShow(notification: NSNotification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        print("Teclado: ", frame);
        DatosK.cont.tecladoFrame=frame;
        DatosK.cont.subeVistaCreaUsuario(self.view);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    func poneFondo(){
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoCrea", framePers: nil, identi: nil, scala: false);
    }
    
    func iniciaTitulo(){
        let OY = self.view.frame.height*0.05;
        let OX = self.view.frame.width*0.2;
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.2;
        let frameTit=CGRectMake(OX, OY, ancho, alto);
        let titulo=UIView(frame: frameTit);
        DatosB.cont.poneFondoTot(titulo, fondoStr: "LogoLaLonchera", framePers: nil, identi: nil, scala: true);
        self.view.sendSubviewToBack(titulo);
        self.view.addSubview(titulo);
        framesText(OY+alto);
    }
    
    func framesText(yini: CGFloat){
        let ancho = self.view.frame.width*0.7;
        let espacioAlto = self.view.frame.height*0.4;
        let espacioU = espacioAlto/9;
        let OX = self.view.frame.width*0.15;
        var altov = CGFloat(0);
        for n in 0 ... 9{
            altov = (espacioU*CGFloat(n))+yini;
            let frame=CGRectMake(OX, altov, ancho, espacioU);
            switch n {
            case 0:
                let vista = UILabel(frame:frame);
                //vista.backgroundColor=UIColor.blueColor();
                vista.text="Vamos a crear tu cuenta de usuario";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.Center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.whiteColor();
                DatosK.cont.origen=vista.frame.origin.y;
                self.view.addSubview(vista);
                break;
            case 1:
                let vista = UILabel(frame:frame);
                //vista.backgroundColor=UIColor.blueColor();
                vista.text="Nombre y Apellido";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.Center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.whiteColor();
                self.view.addSubview(vista);
                break;
            case 2:
                let vista = UITextField(frame:frame);
                //vista.backgroundColor=UIColor.redColor();
                vista.textColor=UIColor.whiteColor();
                vista.attributedPlaceholder = NSAttributedString(string: "Escribe tu nombre", attributes: [NSForegroundColorAttributeName : UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]);
                vista.textAlignment=NSTextAlignment.Center;
                vista.font=UIFont(name: "Gotham Bold", size: vista.frame.height/2);
                vista.adjustsFontSizeToFitWidth=true;
                vista.accessibilityIdentifier="nombre";
                vista.autocapitalizationType=UITextAutocapitalizationType.None;
                let framePers = CGRectMake(0, vista.frame.height-2, vista.frame.width, 2);
                DatosB.cont.poneFondoTot(vista, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
                self.view.addSubview(vista);
                break;
            case 3:
                let vista = UILabel(frame:frame);
                //vista.backgroundColor=UIColor.blueColor();
                vista.text="Correo electrónico";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.Center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.whiteColor();
                self.view.addSubview(vista);
                break;
            case 4:
                email = UITextField(frame:frame);
                email.accessibilityIdentifier = "email";
                email.textColor=UIColor.whiteColor();
                email.attributedPlaceholder = NSAttributedString(string: "Escribe tu correo", attributes: [NSForegroundColorAttributeName : UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]);
                email.textAlignment=NSTextAlignment.Center;
                email.font=UIFont(name: "Gotham Bold", size: email.frame.height/2);
                email.adjustsFontSizeToFitWidth=true;
                email.accessibilityIdentifier="email";
                email.delegate=self;
                email.autocapitalizationType=UITextAutocapitalizationType.None;
                let framePers = CGRectMake(0, email.frame.height-2, email.frame.width, 2);
                DatosB.cont.poneFondoTot(email, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
                self.view.addSubview(email);
                break;
            case 5:
                let vista = UILabel(frame:frame);
                vista.text="Contraseña";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.Center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.whiteColor();
                self.view.addSubview(vista);
                break;
            case 6:
                pass = UITextField(frame:frame);
                
                pass.textColor=UIColor.whiteColor();
                pass.textAlignment=NSTextAlignment.Center;
                pass.attributedPlaceholder = NSAttributedString(string: "Escribe tu contraseña", attributes: [NSForegroundColorAttributeName : UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]);
                pass.font=UIFont(name: "Gotham Bold", size: pass.frame.height/2);
                pass.adjustsFontSizeToFitWidth=true;
                
                pass.accessibilityIdentifier="pass1";
                pass.autocapitalizationType=UITextAutocapitalizationType.None;
                pass.secureTextEntry=true;
                pass.delegate=self;
                let framePers = CGRectMake(0, pass.frame.height-2, pass.frame.width, 2);
                DatosB.cont.poneFondoTot(pass, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
                self.view.addSubview(pass);
                break;
            case 7:
                let vista = UILabel(frame:frame);
                vista.text="Confirmar Contraseña";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.Center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.whiteColor();
                self.view.addSubview(vista);
                break;
            case 8:
                let vista = UITextField(frame:frame);
                vista.textColor=UIColor.whiteColor();
                vista.attributedPlaceholder = NSAttributedString(string: "Confirma tu contraseña", attributes: [NSForegroundColorAttributeName : UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]);
                vista.textAlignment=NSTextAlignment.Center;
                vista.font=UIFont(name: "Gotham Bold", size: vista.frame.height/2);
                vista.adjustsFontSizeToFitWidth=true;
                vista.accessibilityIdentifier="pass2";
                
                vista.autocapitalizationType=UITextAutocapitalizationType.None;
                vista.secureTextEntry=true;
                let framePers = CGRectMake(0, vista.frame.height-2, vista.frame.width, 2);
                DatosB.cont.poneFondoTot(vista, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
                self.view.addSubview(vista);
                break;
            default:
                break;
            }
        }
        generos(altov+espacioU);
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        //print("fin: ", textField.text, " acc: ", textField.accessibilityIdentifier);
        validaEmail(textField);
    }
    
    func validaEmail(textField: UITextField){
        if(textField.text != "" && textField.accessibilityIdentifier=="email"){
            //print("comprueba");
            if(compruebaPatron(textField.text!)){
                let comp = CompruebaEmail();
                comp.Comprueba(textField.text!, padre: self, restaura: nil);
                emailValido=true;
            }else{
                let ancho = self.view.frame.width*0.8;
                let alto = self.view.frame.height*0.4;
                let OX = (self.view.frame.width/2)-(ancho/2);
                let OY = (self.view.frame.height/2)-(alto/2);
                let frameMens = CGRectMake(OX, OY, ancho, alto);
                let msg = MensajeCrea(frame: frameMens, msg: "Correo no válido");
                msg.iniciaTimer();
                self.view.addSubview(msg);
                //bot.enabled=false;
                emailValido=false;
            }
            
        }else if(textField.accessibilityIdentifier=="pass1"){
            print("largo?")
            if(textField.text?.characters.count<6){
                print("Menor");
                let ancho = self.view.frame.width*0.8;
                let alto = self.view.frame.height*0.4;
                let OX = (self.view.frame.width/2)-(ancho/2);
                let OY = (self.view.frame.height/2)-(alto/2);
                let frameMens = CGRectMake(OX, OY, ancho, alto);
                let msg = MensajeCrea(frame: frameMens, msg: "La clave debe contener minimo 6 caracteres");
                msg.iniciaTimer();
                self.view.addSubview(msg);
                passValido=false;
            }else{
                print("pass ok");
                passValido=true;
            }
        }
    }
    
    func compruebaPatron(texto: String)->Bool{
        var rueda = true;
        var p = 0;
        var a = false;
        var b = false;
        while(rueda){
            let index = texto.startIndex.advancedBy(p);
            //print("car: ", texto[index])
            if(texto[index]=="@"){
                //print("tiene arroba")
                a = true;
            }else if(texto[index]=="."){
                //print("tien punto")
                b = true;
            }
            p += 1;
            if(p>=texto.characters.count||(a == true && b == true)){
                rueda = false;
            }
        }
        if(a == true && b == true){
            return true;
        }else{
            return false;
        }
    }
    
    func generos(yini: CGFloat){
        let ancho = self.view.frame.width*0.3;
        let OX = self.view.frame.width*0.15;
        let OY = yini;
        let alto = self.view.frame.height*0.1;
        let frameGenero = CGRectMake(OX, OY, ancho, alto);
        let genero = VistaGenero(frame: frameGenero);
        genero.accessibilityIdentifier="genero";
        self.view.addSubview(genero);
        iniciaFoto(yini);iniciaCheckTerminos(OY+alto);
    }
    
    func iniciaFoto(yini: CGFloat){
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.1;
        let OX = self.view.frame.width*0.45;
        let OY = yini;
        let frameFoto = CGRectMake(OX, OY, ancho, alto);
        foto = VistaFoto(frame: frameFoto, padre: self);
        //self.view.addSubview(foto);
    }
    
    func iniciaCheckTerminos(yini: CGFloat){
        let ancho = self.view.frame.width*0.1;
        let ancho2 = self.view.frame.width*0.5;
        let alto = self.view.frame.height*0.03;
        let OX = self.view.frame.width*0.2;
        let OX2 = (OX+ancho);
        let OY = yini;
        let frameCheck = CGRectMake(OX, OY, ancho, alto);
        let frameLabel = CGRectMake(OX2, OY, ancho2, alto);
        let check = SelectorTerminos(frame: frameCheck);
        let texto = UILabel(frame: frameLabel);
        check.accessibilityIdentifier="terminos";
        texto.text="Acepto los términos y condiciones";
        texto.textColor=UIColor.whiteColor();
        texto.font=UIFont(name: "Gotham Bold", size: alto);
        texto.adjustsFontSizeToFitWidth=true;
        self.view.addSubview(check);
        self.view.addSubview(texto);
        iniciaBotonCreacion(OY+(alto*2));
    }
    
    func iniciaBotonCreacion(yini: CGFloat){
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.1;
        let OX = self.view.frame.width*0.2;
        let OY = yini;
        let frameBoton = CGRectMake(OX, OY, ancho, alto);
        bot = UIButton(frame: frameBoton);
        DatosB.cont.poneFondoTot(bot,fondoStr: "Botón Crear cuenta", framePers: nil, identi: "sele", scala: true);
        bot.addTarget(self, action: #selector(CreaUsuario.sube2), forControlEvents: .TouchDown);
        self.view.addSubview(bot);
    }
    
    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let ancho2 = ancho/3;
        let centr = (ancho/2)-(ancho2/2);
        let frameBoton = CGRectMake(0, 0, ancho, ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(CreaUsuario.cierraVista), forControlEvents: .TouchDown);
        let subFrame = CGRectMake(centr, centr, ancho2, ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "FlechaVBlanco", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    func sube2(){
        validaEmail(self.pass);
        validaEmail(self.email);
    }
    
    func sube (){
        let datos=recoje();
        if(datos.0==true){
            print("sube");
            let sube = SubePadre();
            var datosFoto:NSData?
            if(foto.contiene){
                //print("data: ", foto.datos);
                datosFoto=foto.datos;
            }
            sube.subePadre(datos.1, email: datos.2, pass: datos.3, genero: datos.4 , foto: datosFoto, padre: self);
            
        }
    }
    
    func recoje ()->(Bool, String, String, String, String, Bool){
        //textFieldDidEndEditing(self.pass);
        //textFieldDidEndEditing(self.email);
        print("Valida");
        
        var nombre : String!;
        var email : String!;
        var pass : String!;
        var pass2 : String!;
        var genero : String!;
        var terminos = false;
        for ele in self.view.subviews{
            let qq = ele.accessibilityIdentifier;
            if(qq != nil){
                switch qq! {
                case "nombre":
                    nombre = (ele as! UITextField).text;
                    break;
                case "email":
                    email = (ele as! UITextField).text;
                    break;
                case "pass1":
                    pass = (ele as! UITextField).text;
                    break;
                case "pass2":
                    pass2 = (ele as! UITextField).text;
                    break;
                case "genero":
                    for g in  (ele as! VistaGenero).selects{
                        if(g.seleccion){
                            if(g.nombre == "Masculino"){
                                genero = "M";
                            }else{
                                genero = "F";
                            }
                        }
                        
                    }
                    
                    break;
                case "terminos":
                    if ((ele as! SelectorTerminos).seleccion){
                        terminos = true;
                    }
                    break;
                default:
                    break;
                }
            }
            }
        var bnomb = false;
        var bema = false;
        var bpass = false;
        var bgene = false;
        var bterm = false;
        var pasa = false;
       
        if(nombre == ""){
            print("Nombre Vacio")
        }else{
            bnomb=true;
        }
        if(email == ""){
            print("Email Vacio")
        }else{
            bema=true;
        }
        if(pass == ""){
            print("Pass1 Vacio")
        }
        if(pass2 == ""){
            print("Pass2 Vacio")
        }
        if(pass != "" && pass2 != ""){
            if(pass == pass2){
                //print("OK pass");
                bpass=true;
            }else{
                //print("Contraseñas no concuerdan");
            }
        }
        if(genero == nil){
            //print("Genero Vacio")
            genero="";
        }else{
            bgene=true;
        }
        if(terminos == false){
            //print("Terminos no aceptados")
        }else{
            bterm=true;
        }
        
        print("emailValido: ", emailValido);
        print("emailExistente: ", emailExistente);
        if(bnomb==false||bema==false||bpass==false||bgene==false||bterm==false||emailValido==false||passValido==false||emailExistente==true){
            let ancho = self.view.frame.width*0.8;
            let alto = self.view.frame.height*0.4;
            let OX = (self.view.frame.width/2)-(ancho/2);
            let OY = (self.view.frame.height/2)-(alto/2);
            let frameMens = CGRectMake(OX, OY, ancho, alto);
            var msgT = "";
            if(bnomb==false){
                msgT = msgT + "\nFalta tu nombre";
            }
            if(bema==false){
                msgT = msgT + "\nEmail Vacio";
            }
            if(bpass==false){
                msgT = msgT + "\nUps! las contraseñas no son iguales! Trata de nuevo.";
            }
            if(bgene==false){
                msgT = msgT + "\nNo nos dijiste si eres hombre o mujer.";
            }
            if(bterm==false){
                msgT = msgT + "\nSe te olvidó seleccionar los términos y condiciones";
            }
            if(!emailValido){
                msgT = msgT + "\nTu correo electrónico no es válido";
            }
            if(passValido==false){
                msgT = msgT + "\nPreferimos una contraseña de minimo 6 caracteres por seguridad!";
            }
            if(emailExistente==true){
                bot.enabled=true;
                msgT = msgT + "\nEste correo ya existe! Seguro ya creaste un usuario!";
            }
            //print("msg: ", msgT);
            let msg = MensajeCrea(frame: frameMens, msg: msgT);
            msg.iniciaTimer();
            self.view.addSubview(msg);
            
        }else{
            pasa = true;
        }
        return (pasa, nombre, email, pass2, genero, terminos);
    }
    
    func cierraVista(){
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    func msgUsuarioExitoso(mensaje: String, adv: Bool){
        let ancho = self.view.frame.width*0.8;
        let alto = self.view.frame.height*0.4;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = (self.view.frame.height/2)-(alto/2);
        let frameMens = CGRectMake(OX, OY, ancho, alto);
        let msg = MensajeCrea(frame: frameMens, msg: mensaje);
        if(adv){
            msg.iniciaImagen3();
            _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(CreaUsuario.pasaHome), userInfo: nil, repeats: false);
        }else{
            msg.iniciaTimer();
        }
        
        self.view.addSubview(msg);
        
    }
    
    func pasaHome(){
        let login = ConsultaLogin(plogin: DatosB.cont.loginView);
        //login.PLogin=DatosB.cont.loginView;
        login.consulta(email.text!, pass: pass.text!);
        //self.performSegueWithIdentifier("Ingresa2", sender: nil);
        cierraVista();
    }
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        DatosK.cont.bajaVista(self.view);
        self.view.endEditing(true);
    }
    
    func inciaPicker(){
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(ImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var image = UIImage();
        image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        foto.setFoto(image);
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    //Método que oculta la barra en este viewcontroller
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
