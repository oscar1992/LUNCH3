//
//  DatosPadreViewController.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 15/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class DatosPadre: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var laBarra: LaBarra!
    var borde:CGFloat!
    var fecha: String!;
    var idFecha:Int!;
    var hora: String!;
    var metodoV:String!;
    var texto:UILabel!;
    var texto2:UILabel!;
    var direccion1:UITextField!;
    var direccion2:UITextField!;
    var direccion3:UITextField!;
    var direccion4:UILabel!;
    var vista5:UIButton!;
    var vistaCiudad: UIView!;
    var telefono:UITextField!;
    var metodo:UILabel!;
    var boton : UIButton!;
    var carrito: Carrito!;
    var bloq:UIView!;
    
    
    var vistaDir: VistaDirecciones!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround()
        borde=DatosC.contenedor.altoP*0.02;
        iniciaNombre();
        iniciaBotonVolver();
        iniciaFondo()
        poliogono();
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginView.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
        carrito=DatosB.cont.carrito;
        DatosB.cont.datosPadre=self;
        listaCiudad();
        
        // Do any additional setup after loading the view.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        //print("Teclado: ", frame);
        DatosK.cont.tecladoFrame=frame;
        DatosK.cont.subeVistaCantidad(self.view, cant: 150);
    }
    
    //Método que inicia el fondo de los datops
    func iniciaFondo(){
        let fondo = CGRectMake(0, laBarra.frame.height, self.view.frame.width, (self.view.frame.height-laBarra.frame.height));
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: fondo, identi: "FondoCar", scala: false);
    }
    
    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let ancho2 = ancho/3;
        let centr = (ancho/2)-(ancho2/2);
        let frameBoton = CGRectMake(0, 0, ancho, ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(DatosPadre.vuelve), forControlEvents: .TouchDown);
        let subFrame = CGRectMake(centr, centr, ancho2, ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    //Método que cierra la ventana
    func vuelve(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Método que inicia el nombre del padre y el mensaje de referencia
    func iniciaNombre(){
        let ancho = DatosC.contenedor.anchoP*0.8;
        let alto = DatosC.contenedor.anchoP*0.05;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.15
        ;
        let frameNomb = CGRectMake(OX, OY, ancho, alto);
        let nom = UILabel(frame: frameNomb);
        nom.text=DatosD.contenedor.padre.nombre;
        nom.font=UIFont(name: "SansBeamBody-Heavy", size: nom.frame.height);
        nom.textAlignment=NSTextAlignment.Center;
        nom.textColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        self.view.addSubview(nom);
        let ancho2 = DatosC.contenedor.anchoP*0.8;
        let OX2=(DatosC.contenedor.anchoP/2)-(ancho2/2);
        let frame2 = CGRectMake(OX2, OY+alto, ancho2, alto);
        let text = UILabel(frame: frame2);
        text.text="Confírmanos tus datos de entrega:";
        text.textAlignment=NSTextAlignment.Center;
        self.view.addSubview(text);
        iniciaTabDireccion((text.frame.height+text.frame.origin.y));
    }
    
    //Método que inicia la tabla de los datos de la dirreción
    func iniciaTabDireccion(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Dirección";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let frameVista3=CGRectMake(0, (frameVista2.origin.y+alto), ancho, alto);
        let frameVista4=CGRectMake(0, (frameVista3.origin.y+alto), ancho*0.5, alto);
        let frameVista5=CGRectMake(ancho*0.5, (frameVista3.origin.y+alto), ancho*0.5, alto);
        let vista2 = UIView(frame: frameVista2);
        let vista3 = UIView(frame: frameVista3);
        let vista4 = UIView(frame: frameVista4);
        vista5 = UIButton(frame: frameVista5);
        vista5.addTarget(self, action: #selector(DatosPadre.muestraCiudad), forControlEvents: .TouchDown);
        vista2.backgroundColor=UIColor.whiteColor();
        vista3.backgroundColor=UIColor.whiteColor();
        vista4.backgroundColor=UIColor.whiteColor();
        vista5.backgroundColor=UIColor.whiteColor();
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        
        direccion1 = UITextField(frame: frameText2);
        direccion2 = UITextField(frame: frameText2);
        direccion3 = UITextField(frame: frameText2);
        direccion4 = UILabel(frame: frameText2);
        vista2.addSubview(direccion1);
        vista3.addSubview(direccion2);
        vista4.addSubview(direccion3);
        vista5.addSubview(direccion4);
        direccion1.text=DatosD.contenedor.padre.direccion;
        direccion2.text="Edificio / Casa / Apartamento";
        direccion3.text="Barrio";
        direccion4.text="Ciudad v";
        direccion1.textColor=UIColor.grayColor();
        direccion2.textColor=UIColor.grayColor();
        direccion3.textColor=UIColor.grayColor();
        direccion4.textColor=UIColor.grayColor();
        direccion1.delegate=self;
        direccion2.delegate=self;
        direccion3.delegate=self;
        //direccion4.delegate=self;
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        self.view.addSubview(vista3);
        self.view.addSubview(vista4);
        self.view.addSubview(vista5);
        
        iniciaTabTelefono((vista2.frame.height+vista2.frame.origin.y+vista3.frame.height+vista5.frame.height));
    }
    
    func muestraCiudad(){
        vistaCiudad.hidden=false;
    }
    
    func listaCiudad(){
        print("lista");
        let lista = ["Bogotá"];
        let frame = CGRectMake(vista5.frame.origin.x, vista5.frame.origin.y+vista5.frame.height, vista5.frame.width, vista5.frame.height*CGFloat(lista.count));
        vistaCiudad = UIView(frame: frame);
        vistaCiudad.hidden=true;
        var n = 0;
        for bott in lista{
            let frameBot = CGRectMake(0, vista5.frame.height*CGFloat(n), frame.width, (frame.height/CGFloat(lista.count))*0.9);
            print("nomb: ", frameBot)
            let bot = UIButton(frame: frameBot);
            let frameNom = CGRectMake(frame.width*0.2, 0, frame.width, vista5.frame.height);
            let lab = UILabel(frame: frameNom);
            lab.textColor=UIColor.grayColor();
            lab.text=bott;
            bot.addSubview(lab);
            bot.backgroundColor=UIColor.whiteColor();
            bot.addTarget(self, action: #selector(DatosPadre.botCiudad(_:)), forControlEvents: .TouchDown);
            vistaCiudad.addSubview(bot);
            n += 1;
        }
        
        vistaCiudad.backgroundColor=UIColor.whiteColor();
        self.view.addSubview(vistaCiudad);
    }
    
    func botCiudad(sender: UIButton){
        vistaCiudad.hidden=true;
        for vista in sender.subviews{
            if vista is UILabel{
                var lab = vista as! UILabel;
                print("qq: ", lab.text);
                direccion4.text=lab.text;
            }
        }
        //print("Bot: ", sender);
    }
    
    //Método que inicia la tabla de la direccion
    func iniciaTabTelefono(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Teléfono / Celular";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let vista2 = UIView(frame: frameVista2);
        vista2.backgroundColor=UIColor.whiteColor();
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        telefono = UITextField(frame: frameText2);
        vista2.addSubview(telefono);
        telefono.text=DatosD.contenedor.padre.telefono;
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabFechaEntrega((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la fecha de netrega
    func iniciaTabFechaEntrega(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Fecha de entrega";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let vista2 = UIButton(frame: frameVista2);

        vista2.addTarget(self, action: #selector(DatosPadre.listaDesplegable1(_:)), forControlEvents: .TouchDown);
        vista2.backgroundColor=UIColor.whiteColor();
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        self.texto = UILabel(frame: frameText2);
        self.texto.text="Fecha";
        vista2.addSubview(self.texto);
        
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabHoraEntrega((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la fecha de netrega
    func iniciaTabHoraEntrega(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Hora de entrega";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let vista2 = UIButton(frame: frameVista2);
        //vista2.addTarget(self, action: #selector(DatosPadre.listaDesplegable2(_:)), forControlEvents: .TouchDown);
        vista2.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        self.texto2 = UILabel(frame: frameText2);
        vista2.addSubview(self.texto2);
        self.texto2.text="Te entregaremos el pedido durante el día. Si no estas, lo dejaremos en portería!";
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabMetodo((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la fecha de netrega
    func iniciaTabMetodo(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Forma de pago";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let vista2 = UIButton(frame: frameVista2);
        vista2.backgroundColor=UIColor.whiteColor();
        vista2.addTarget(self, action: #selector(DatosPadre.iniciaListaDesplegableMetodo(_:)), forControlEvents: .TouchDown);
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        metodo = UILabel(frame: frameText2);
        vista2.addSubview(metodo);
        metodo.text="Forma de Pago";
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciabotonPedido(vista2.frame.origin.y+vista2.frame.height);
    }
    
    func iniciaListaDesplegableMetodo(sender: UIButton){
        bloqueador();
        let Datos = ["Efectivo"];
        let despliega = VistaMetodos(opciones: Datos);
        
        self.view.addSubview(despliega);
        //DatosK.cont.subeVista(self.view);
    }
    
    
    //Método que inicia el boton del pedido
    func iniciabotonPedido(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP*0.6;
        let alto = DatosC.contenedor.anchoP*0.1;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let frameBarra = CGRectMake(OX, (yini+borde), ancho, alto);
        boton = UIButton(frame: frameBarra);
        DatosB.cont.poneFondoTot(boton, fondoStr: "Botón Hacer pedido", framePers: nil, identi: nil, scala: true);
        boton.addTarget(self, action: #selector(DatosPadre.valida), forControlEvents: .TouchDown);
        self.view.addSubview(boton);
        
    }
   
    func listaDesplegable1(vistai: UIView){
        bloqueador();
            print("Vista");
            var opc = [(String, String, Int)]();
            for fecha in DatosB.cont.FechasEntrega{
                opc.append((fecha.fechaMuestra, fecha.fechaSiguiente, fecha.idFecha));
            }
            let vistafecha = VistaFecha(opciones: opc);
            self.view.addSubview(vistafecha);
        
        
        
        /*self.view.bringSubviewToFront(vistai);
        for vista in self.view.subviews{
            if vista.accessibilityIdentifier=="despliega"{
                vista.removeFromSuperview();
            }
        }
        let frameScroll = CGRectMake(0, (vistai.frame.origin.y+vistai.frame.height), vistai.frame.width, (vistai.frame.height));
        let despliega = Despliega(frame: frameScroll, tipo: FechaEntrega.classForCoder(), fecha: nil);
        despliega.accessibilityIdentifier="despliega";
        despliega.padre=self;
        despliega.alto=vistai.frame.height;
        
        self.view.bringSubviewToFront(despliega);
        self.view.addSubview(despliega);
        */
    }
    
    func listaDesplegable2(vistai: UIView){
        
        print("Vista");
        if(idFecha != nil){
            var opc = [String]();
            for hora in DatosB.cont.HorasEntrega{
                if(hora.fechaEntrega.idFecha == idFecha){
                    opc.append(hora.horaInicial+" - "+hora.horaFinal);
                }
            }
            let vistaHora = VistaHora(opciones: opc);
            bloqueador();
            self.view.addSubview(vistaHora);
        }
        
        /*
        self.view.bringSubviewToFront(vistai);
        for vista in self.view.subviews{
            if vista.accessibilityIdentifier=="despliega"{
                vista.removeFromSuperview();
            }
        }
        let frameScroll = CGRectMake(0, (vistai.frame.origin.y+vistai.frame.height), vistai.frame.width, (vistai.frame.height));
        let despliega = Despliega(frame: frameScroll, tipo: HoraEntrega.classForCoder(), fecha: fecha);
        despliega.accessibilityIdentifier="despliega";
        despliega.padre=self;
        //despliega.alto=vistai.frame.height;
        self.view.bringSubviewToFront(despliega);
        self.view.addSubview(despliega);
         */
    }
    
    
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            view.addGestureRecognizer(tap)
            for vista in self.view.subviews{
                if (vista.accessibilityIdentifier=="Despliega2"){
                    print("Remueve")
                    vista.removeFromSuperview();
                }
            }
        }
        
        func dismissKeyboard() {
            DatosK.cont.bajaVista(self.view);
            view.endEditing(true)
        }
    
    //Método que oculta la barra en este viewcontroller
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = "";
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        print("oooo");
        if(textField.text != ""&&tieneNumeros(textField.text!)){
            //let cons = ConsultaD();
            //cons.consulta(textField.text!, padre: self);
            
        }
        if (vistaDir != nil){
            self.vistaDir.removeFromSuperview();
        }
        
    }
    
    func iniciaMensaje(direcciones: [Direcciones]){
        let ancho = self.view.frame.width*0.8;
        let alto = self.view.frame.height*0.4;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = (self.view.frame.height/2)-(alto/2);
        let frameMens = CGRectMake(OX, OY, ancho, alto);
        vistaDir = VistaDirecciones(frame: frameMens, direc: direcciones);
        self.view.addSubview(vistaDir);
    }
    
    func poliogono(){
        let cargaNod = CargaNodos();
        cargaNod.cargaNodosA();
        DatosB.cont.nodos=cargaNod;
    }
    
    func valida(){
        var pasaDir = false;
        var pasaTel = false;
        var pasaHora = true;
        var pasaFecha = false;
        var pasaMetodo = false;
        var info = "Por favor diligencia estos campos:";
        if(direccion1.text?.characters.count<0){
            pasaDir=false;
            
            info += "¿Donde quieres recibir Las Loncheras?";
        }else{
            if(direccion1.text?.characters.count<5||tieneNumeros(direccion1.text!)==false){
                info += "Dirección Inválida";
                pasaDir=false;
            }else{
                
                pasaDir=true;
            }
            
        }
        if(telefono.text?.characters.count==0){
            info += "\n¿Nos das tu teléfono?";
            pasaTel=false;
        }
        if(telefono.text?.characters.count<7||tieneLetras(telefono.text!)){
            pasaTel = false;
            info += "\nTelefono Invalido";
        }else{
            pasaTel = true;
        }
        if(hora == nil){//Modificación forzosa
            pasaHora=true;
        }else{
            pasaHora=false;
            info += "\n*Hora de Entrega de tus loncheras";
        }
        if(fecha != nil){
            pasaFecha = true;
        }else{
            pasaFecha = false;
            info += "\n*Fecha de entrega de tus loncheras";
        }
        if(metodoV != nil){
            pasaMetodo = true;
        }else{
            pasaMetodo = false;
            info += "\n¿Cómo quieres pagar?";
        }
        print("Info: ", info);
        print("dir: ", pasaDir," tel: ", pasaTel);
        if(pasaTel==false||pasaDir==false||pasaHora==false||pasaMetodo==false){
            let msg = ValidaPedido(texto: info);
            self.view.addSubview(msg);
        }else{
            print("lonchs")
            for tipos in DatosB.cont.listaLoncheras{
                print("tipo: ", tipos.0.nombr);
                print("cants: ", tipos.1);
            }
            subePedido();
            
        }
        
        
    }
    
    func tieneNumeros(texto: String)->Bool{
        var pasa = true;
        var p = 0;
        var tiene=false;
        while (pasa) {
            let indice = texto.startIndex.advancedBy(p);
            do{
                let char = String(texto[indice]);
                let num = try Int(char);
                if(num>0){
                    tiene=true;
                }
            }catch _{
                print("letra");
            }
            
            p += 1;
            if(p >= texto.characters.count){
                pasa = false;
            }
        }
        print("numeros: ", tiene);
        return tiene;
    }
    
    func tieneLetras(texto: String)->Bool{
        var pasa = true;
        var p = 0;
        var tiene=true;
        while (pasa) {
            let indice = texto.startIndex.advancedBy(p);
            do{
                let char = String(texto[indice]);
                let num = try (Int(char));
                if(num>0){
                    tiene=false;
                }
            }catch{
                print("letra");
            }
            
            p += 1;
            if(p >= texto.characters.count){
                pasa = false;
            }
        }
        print("letras: ", tiene);
        return tiene;
    }
    
    func subePedido(){
        let subeP = SubePedido();
        
        //print("hora: ", hora);
        hora="----";
        print("fecha: ", texto);
        print("id padre: ", DatosD.contenedor.padre.id);
        print("fecha actual: ", fechaActual());
        print("fecha entrega: ", fecha);
        print("valor", valor());
        print("cantidad: ", cant());
        
        let actua=ActualizaPadre();
        if(direccion2.text == "Edificio / Casa / Apartamento"){
            direccion2.text="";
        }
        if(direccion3.text == "Barrio"){
            direccion3.text="";
        }
        if(direccion4.text == "Ciudad v"){
            direccion4.text="";
        }
        DatosD.contenedor.padre.direccion=(direccion1.text!+" "+direccion2.text!+" "+direccion3.text!+" "+direccion4.text!);
        DatosD.contenedor.padre.telefono=telefono.text;
        actua.actualizaPadre(DatosD.contenedor.padre);
        
        subeP.subePedido(DatosD.contenedor.padre, fechaPedido: fechaActual(), fechaEntrega: fecha, horaEntrega: hora, valor: valor(), cantidad: cant(), metodo: metodoV);
        boton.enabled=false;
    }
    
    func muestraMensajeExito(){
        let msgExito = VistaSubidaExito();
        self.view.addSubview(msgExito);
        //performSegueWithIdentifier("Regresa", sender: nil);
        
        //(self.superview as Carrito).dismissViewControllerAnimated(true, completion: nil);
    }
    
    func cierraPadre(){
        
        self.dismissViewControllerAnimated(true, completion: nil);
        carrito.dismissViewControllerAnimated(false, completion: nil);
        DatosB.cont.listaLoncheras=[(Lonchera2, Int)]();
        DatosB.cont.loncheras=[Lonchera2]();
        DatosB.cont.home2.botonCarrito.cant.text="0";
    }
    
    func fechaActual()->String{
        let date = NSDate();
        let formateador:NSDateFormatter=NSDateFormatter();
        formateador.locale = NSLocale.init(localeIdentifier: "es_CO");
        formateador.dateFormat="yyyy-MM-dd hh:mm:ss-";
        return  formateador.stringFromDate(date)+"04";
    }
    
    func cant()->Int{
        var cant = 0;
        for tipos in DatosB.cont.listaLoncheras{
            cant += tipos.1;
        }
        return cant;
    }
    
    func valor()->Double{
        var valor = 0.0;
        for tipo in DatosB.cont.listaLoncheras{
            valor += Double(tipo.0.valor*tipo.1);
        }
        let envio = Double(DatosB.cont.envia);
        valor += envio;
        print("valor: ", valor, " envio: ", envio);
        return valor
    }
    
    func bloqueador(){
        let ancho = self.view.frame.width;
        let alto = self.view.frame.height;
        let frameB = CGRectMake(0, 0, ancho, alto);
        bloq = UIView(frame: frameB);
        self.view.addSubview(bloq);
        bloq.backgroundColor=UIColor.clearColor();
    }
    
    func desbloqueador(){
        if (bloq != nil){
            bloq.removeFromSuperview();
        }
    }

}
