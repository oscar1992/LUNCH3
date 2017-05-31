//
//  CreaUsuario.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 30/09/16.
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
        NotificationCenter.default.addObserver(self, selector: #selector(CreaUsuario.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CreaUsuario.dismissKeyboard), name: UIKeyboardWillHideNotification, object: nil);

    }
    
    func keyboardWillShow(_ notification: Notification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
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
        let frameTit=CGRect(x: OX, y: OY, width: ancho, height: alto);
        let titulo=UIView(frame: frameTit);
        DatosB.cont.poneFondoTot(titulo, fondoStr: "LogoLaLonchera", framePers: nil, identi: nil, scala: true);
        self.view.sendSubview(toBack: titulo);
        self.view.addSubview(titulo);
        framesText(OY+alto);
    }
    
    func framesText(_ yini: CGFloat){
        let ancho = self.view.frame.width*0.7;
        let espacioAlto = self.view.frame.height*0.4;
        let espacioU = espacioAlto/9;
        let OX = self.view.frame.width*0.15;
        var altov = CGFloat(0);
        for n in 0 ... 9{
            altov = (espacioU*CGFloat(n))+yini;
            let frame=CGRect(x: OX, y: altov, width: ancho, height: espacioU);
            switch n {
            case 0:
                let vista = UILabel(frame:frame);
                //vista.backgroundColor=UIColor.blueColor();
                vista.text="Vamos a crear tu cuenta de usuario";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.white;
                DatosK.cont.origen=vista.frame.origin.y;
                self.view.addSubview(vista);
                break;
            case 1:
                let vista = UILabel(frame:frame);
                //vista.backgroundColor=UIColor.blueColor();
                vista.text="Nombre y Apellido";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.white;
                self.view.addSubview(vista);
                break;
            case 2:
                let vista = UITextField(frame:frame);
                //vista.backgroundColor=UIColor.redColor();
                vista.textColor=UIColor.white;
                vista.attributedPlaceholder = NSAttributedString(string: "Escribe tu nombre", attributes: [NSForegroundColorAttributeName : UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]);
                vista.textAlignment=NSTextAlignment.center;
                vista.font=UIFont(name: "Gotham Bold", size: vista.frame.height/2);
                vista.adjustsFontSizeToFitWidth=true;
                vista.accessibilityIdentifier="nombre";
                vista.autocapitalizationType=UITextAutocapitalizationType.none;
                let framePers = CGRect(x: 0, y: vista.frame.height-2, width: vista.frame.width, height: 2);
                DatosB.cont.poneFondoTot(vista, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
                self.view.addSubview(vista);
                break;
            case 3:
                let vista = UILabel(frame:frame);
                //vista.backgroundColor=UIColor.blueColor();
                vista.text="Correo electrónico";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.white;
                self.view.addSubview(vista);
                break;
            case 4:
                email = UITextField(frame:frame);
                email.accessibilityIdentifier = "email";
                email.textColor=UIColor.white;
                email.attributedPlaceholder = NSAttributedString(string: "Escribe tu correo", attributes: [NSForegroundColorAttributeName : UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]);
                email.textAlignment=NSTextAlignment.center;
                email.font=UIFont(name: "Gotham Bold", size: email.frame.height/2);
                email.adjustsFontSizeToFitWidth=true;
                email.accessibilityIdentifier="email";
                email.delegate=self;
                email.autocapitalizationType=UITextAutocapitalizationType.none;
                let framePers = CGRect(x: 0, y: email.frame.height-2, width: email.frame.width, height: 2);
                DatosB.cont.poneFondoTot(email, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
                self.view.addSubview(email);
                break;
            case 5:
                let vista = UILabel(frame:frame);
                vista.text="Contraseña";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.white;
                self.view.addSubview(vista);
                break;
            case 6:
                pass = UITextField(frame:frame);
                
                pass.textColor=UIColor.white;
                pass.textAlignment=NSTextAlignment.center;
                pass.attributedPlaceholder = NSAttributedString(string: "Escribe tu contraseña", attributes: [NSForegroundColorAttributeName : UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]);
                pass.font=UIFont(name: "Gotham Bold", size: pass.frame.height/2);
                pass.adjustsFontSizeToFitWidth=true;
                
                pass.accessibilityIdentifier="pass1";
                pass.autocapitalizationType=UITextAutocapitalizationType.none;
                pass.isSecureTextEntry=true;
                pass.delegate=self;
                let framePers = CGRect(x: 0, y: pass.frame.height-2, width: pass.frame.width, height: 2);
                DatosB.cont.poneFondoTot(pass, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
                self.view.addSubview(pass);
                break;
            case 7:
                let vista = UILabel(frame:frame);
                vista.text="Confirmar Contraseña";
                vista.adjustsFontSizeToFitWidth=true;
                vista.textAlignment=NSTextAlignment.center;
                vista.font=UIFont(name: "Gotham Bold", size: espacioU/2);
                vista.textColor=UIColor.white;
                self.view.addSubview(vista);
                break;
            case 8:
                let vista = UITextField(frame:frame);
                vista.textColor=UIColor.white;
                vista.attributedPlaceholder = NSAttributedString(string: "Confirma tu contraseña", attributes: [NSForegroundColorAttributeName : UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]);
                vista.textAlignment=NSTextAlignment.center;
                vista.font=UIFont(name: "Gotham Bold", size: vista.frame.height/2);
                vista.adjustsFontSizeToFitWidth=true;
                vista.accessibilityIdentifier="pass2";
                
                vista.autocapitalizationType=UITextAutocapitalizationType.none;
                vista.isSecureTextEntry=true;
                let framePers = CGRect(x: 0, y: vista.frame.height-2, width: vista.frame.width, height: 2);
                DatosB.cont.poneFondoTot(vista, fondoStr: "Línea texto", framePers: framePers, identi: nil, scala: true);
                self.view.addSubview(vista);
                break;
            default:
                break;
            }
        }
        generos(altov+espacioU);
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        //print("fin: ", textField.text, " acc: ", textField.accessibilityIdentifier);
        if(textField.accessibilityIdentifier=="email"){
            validaEmail(textField);
        }
        if(textField.accessibilityIdentifier=="pass1"){
            validaPass(textField);
        }
    }
    
    func validaEmail(_ textField: UITextField){
        if((textField.text?.characters.count)! > 6){
            if(compruebaPatron(textField.text!)){
                let comp = CompruebaEmail();
                comp.Comprueba(textField.text!, padre: self, restaura: nil);
                emailValido=true;
            }else{
                let ancho = self.view.frame.width*0.8;
                let alto = self.view.frame.height*0.4;
                let OX = (self.view.frame.width/2)-(ancho/2);
                let OY = (self.view.frame.height/2)-(alto/2);
                let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
                let msg = MensajeCrea(frame: frameMens, msg: "Correo no válido", gif: false);
                msg.iniciaTimer();
                self.view.addSubview(msg);
                //bot.enabled=false;
                emailValido=false;
            }
        }
        
        /*
        if(textField.text != "" && textField.accessibilityIdentifier=="email"){
            //print("comprueba");
        }else if(textField.accessibilityIdentifier=="pass1"){
            
        }*/
    }
    
    func validaPass(_ textField: UITextField){
        print("largo?: ", textField.text?.characters.count);
        if((textField.text?.characters.count)!<6 && (textField.text?.characters.count)! > 0){
            print("Menor");
            let ancho = self.view.frame.width*0.8;
            let alto = self.view.frame.height*0.4;
            let OX = (self.view.frame.width/2)-(ancho/2);
            let OY = (self.view.frame.height/2)-(alto/2);
            let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
            let msg = MensajeCrea(frame: frameMens, msg: "La clave debe contener minimo 6 caracteres" , gif: false);
            msg.iniciaTimer();
            self.view.addSubview(msg);
            passValido=false;
        }else{
            print("pass ok");
            passValido=true;
        }
    }
    
    func compruebaPatron(_ texto: String)->Bool{
        var rueda = true;
        var p = 0;
        var a = false;
        var b = false;
        while(rueda){
            let index = texto.characters.index(texto.startIndex, offsetBy: p);
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
    
    func generos(_ yini: CGFloat){
        let ancho = self.view.frame.width*0.3;
        let OX = self.view.frame.width*0.15;
        let OY = yini;
        let alto = self.view.frame.height*0.1;
        let frameGenero = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let genero = VistaGenero(frame: frameGenero);
        genero.accessibilityIdentifier="genero";
        //self.view.addSubview(genero);
        iniciaFoto(yini);iniciaCheckTerminos(OY+alto);
    }
    
    func iniciaFoto(_ yini: CGFloat){
        let ancho = self.view.frame.width*0.4;
        let alto = self.view.frame.height*0.1;
        let OX = self.view.frame.width*0.45;
        let OY = yini;
        let frameFoto = CGRect(x: OX, y: OY, width: ancho, height: alto);
        foto = VistaFoto(frame: frameFoto, padre: self);
        //self.view.addSubview(foto);
    }
    
    func iniciaCheckTerminos(_ yini: CGFloat){
        let ancho = self.view.frame.width*0.1;
        let ancho2 = self.view.frame.width*0.5;
        let alto = self.view.frame.height*0.03;
        let OX = self.view.frame.width*0.2;
        let OX2 = (OX+ancho);
        let OY = yini;
        let frameCheck = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let frameLabel = CGRect(x: OX2, y: OY, width: ancho2, height: alto);
        let check = SelectorTerminos(frame: frameCheck);
        let texto = UILabel(frame: frameLabel);
        check.accessibilityIdentifier="terminos";
        texto.text="Acepto los términos y condiciones";
        texto.textColor=UIColor.white;
        texto.font=UIFont(name: "Gotham Bold", size: alto);
        texto.adjustsFontSizeToFitWidth=true;
        self.view.addSubview(check);
        self.view.addSubview(texto);
        iniciaBotonCreacion(OY+(alto*2));
    }
    
    func iniciaBotonCreacion(_ yini: CGFloat){
        let ancho = self.view.frame.width*0.6;
        let alto = self.view.frame.height*0.1;
        let OX = self.view.frame.width*0.2;
        let OY = yini;
        let frameBoton = CGRect(x: OX, y: OY, width: ancho, height: alto);
        bot = UIButton(frame: frameBoton);
        DatosB.cont.poneFondoTot(bot,fondoStr: "Botón Crear cuenta", framePers: nil, identi: "sele", scala: true);
        bot.addTarget(self, action: #selector(CreaUsuario.sube2), for: .touchDown);
        self.view.addSubview(bot);
    }
    
    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let ancho2 = ancho/3;
        let centr = (ancho/2)-(ancho2/2);
        let frameBoton = CGRect(x: 0, y: 0, width: ancho, height: ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(CreaUsuario.cierraVista), for: .touchDown);
        let subFrame = CGRect(x: centr, y: centr, width: ancho2, height: ancho2);
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
            var datosFoto:Data?
            if(foto.contiene){
                //print("data: ", foto.datos);
                datosFoto=foto.datos as! Data;
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
        if(pass != "" && pass2 != "" && (self.pass.text?.characters.count)! > 0){
            print("Tamaño contraseña: ", self.pass.text?.characters.count);
            if(pass == pass2){
                print("OK pass");
                bpass=true;
            }else{
                print("Contraseñas no concuerdan");
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
        bgene = true;
        genero = "-";
        if(bnomb==false||bema==false||bpass==false||bgene==false||bterm==false||emailValido==false||passValido==false||emailExistente==true){
            let ancho = self.view.frame.width*0.8;
            let alto = self.view.frame.height*0.4;
            let OX = (self.view.frame.width/2)-(ancho/2);
            let OY = (self.view.frame.height/2)-(alto/2);
            let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
            var msgT = "";
            if(bnomb==false){
                msgT = msgT + "\nFalta tu nombre";
            }
            if(bema==false){
                msgT = msgT + "\nEmail Vacio";
            }
            if(pass != pass2){
                msgT = msgT + "\nUps! las contraseñas no son iguales! Trata de nuevo.";
            }
            
            if(bgene==false){
                msgT = msgT + "\nNo nos dijiste si eres hombre o mujer.";
            }
      
            if(bterm==false && pass != ""){
                msgT = msgT + "\nSe te olvidó seleccionar los términos y condiciones";
            }
            if(!emailValido){
                msgT = msgT + "\nTu correo electrónico no es válido";
            }
            if(passValido==false && pass != ""){
                msgT = msgT + "\nPreferimos una contraseña de minimo 6 caracteres por seguridad!";
            }
            if(emailExistente==true){
                bot.isEnabled=true;
                msgT = msgT + "\nEste correo ya existe! Seguro ya creaste un usuario!";
            }
            //print("msg: ", msgT);
            if(msgT != ""){
                let msg = MensajeCrea(frame: frameMens, msg: msgT, gif: false);
                msg.iniciaTimer();
                self.view.addSubview(msg);
            }
            
            
        }else{
            pasa = true;
        }
        print("sube: ", pasa);
        return (pasa, nombre, email, pass2, genero, terminos);
    }
    
    func cierraVista(){
        self.dismiss(animated: false, completion: nil);
    }
    
    func msgUsuarioExitoso(_ mensaje: String, adv: Bool){
        let ancho = self.view.frame.width*0.8;
        let alto = self.view.frame.height*0.4;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = (self.view.frame.height/2)-(alto/2);
        let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let msg = MensajeCrea(frame: frameMens, msg: mensaje, gif: false);
        if(adv){
            msg.iniciaImagen3();
            _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(CreaUsuario.pasaHome), userInfo: nil, repeats: false);
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
        ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(ImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image = UIImage();
        image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        foto.setFoto(image);
        self.dismiss(animated: true, completion: nil)
        
    }

    //Método que oculta la barra en este viewcontroller
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
