
//
//  DatosPadreViewController.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 15/09/16.
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
    var tarjeta: TarjetaEntidad!;
    var idReferencia : Int!; //Referencia para las compras con tarjeta de crédito
    
    var vistaDir: VistaDirecciones!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround()
        borde=DatosC.contenedor.altoP*0.02;
        iniciaNombre();
        iniciaBotonVolver();
        iniciaFondo()
        poliogono();
        NotificationCenter.default.addObserver(self, selector: #selector(DatosPadre.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        carrito=DatosB.cont.carrito;
        DatosB.cont.datosPadre=self;
        listaCiudad();
        
        // Do any additional setup after loading the view.
    }
    
    func keyboardWillShow(_ notification: Notification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //print("Teclado: ", frame);
        DatosK.cont.tecladoFrame=frame;
        DatosK.cont.subeVistaCantidad(self.view, cant: 150);
    }
    
    
    
    //Método que inicia el fondo de los datops
    func iniciaFondo(){
        let fondo = CGRect(x: 0, y: laBarra.frame.height, width: self.view.frame.width, height: (self.view.frame.height-laBarra.frame.height));
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: fondo, identi: "FondoCar", scala: false);
    }
    
    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let ancho2 = ancho/3;
        let centr = (ancho/2)-(ancho2/2);
        let frameBoton = CGRect(x: 0, y: 0, width: ancho, height: ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(DatosPadre.vuelve), for: .touchDown);
        let subFrame = CGRect(x: centr, y: centr, width: ancho2, height: ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    //Método que cierra la ventana
    func vuelve(){
        self.dismiss(animated: true, completion: nil);
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
        let frameNomb = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let nom = UILabel(frame: frameNomb);
        nom.text=DatosD.contenedor.padre.nombre;
        nom.font=UIFont(name: "SansBeamBody-Heavy", size: nom.frame.height);
        nom.textAlignment=NSTextAlignment.center;
        nom.textColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        self.view.addSubview(nom);
        let ancho2 = DatosC.contenedor.anchoP*0.8;
        let OX2=(DatosC.contenedor.anchoP/2)-(ancho2/2);
        let frame2 = CGRect(x: OX2, y: OY+alto, width: ancho2, height: alto);
        let text = UILabel(frame: frame2);
        text.text="Confírmanos tus datos de entrega:";
        text.textAlignment=NSTextAlignment.center;
        text.adjustsFontSizeToFitWidth=true;
        self.view.addSubview(text);
        iniciaTabDireccion((text.frame.height+text.frame.origin.y));
    }
    
    //Método que inicia la tabla de los datos de la dirreción
    func iniciaTabDireccion(_ yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRect(x: 0, y: (yini+borde), width: ancho, height: alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        let texto = UILabel(frame: frameText);
        texto.text="Dirección";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRect(x: 0, y: (frameBarra.origin.y+alto), width: ancho, height: alto);
        let frameVista3=CGRect(x: 0, y: (frameVista2.origin.y+alto), width: ancho, height: alto);
        let frameVista4=CGRect(x: 0, y: (frameVista3.origin.y+alto), width: ancho*0.5, height: alto);
        let frameVista5=CGRect(x: ancho*0.5, y: (frameVista3.origin.y+alto), width: ancho*0.5, height: alto);
        let vista2 = UIView(frame: frameVista2);
        let vista3 = UIView(frame: frameVista3);
        let vista4 = UIView(frame: frameVista4);
        vista5 = UIButton(frame: frameVista5);
        vista5.addTarget(self, action: #selector(DatosPadre.muestraCiudad), for: .touchDown);
        vista2.backgroundColor=UIColor.white;
        vista3.backgroundColor=UIColor.white;
        vista4.backgroundColor=UIColor.white;
        vista5.backgroundColor=UIColor.white;
        let frameText2=CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        
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
        direccion1.textColor=UIColor.gray;
        direccion2.textColor=UIColor.gray;
        direccion3.textColor=UIColor.gray;
        direccion4.textColor=UIColor.gray;
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
        vistaCiudad.isHidden=false;
    }
    
    func listaCiudad(){
        print("lista");
        let lista = ["Bogotá"];
        let frame = CGRect(x: vista5.frame.origin.x, y: vista5.frame.origin.y+vista5.frame.height, width: vista5.frame.width, height: vista5.frame.height*CGFloat(lista.count));
        vistaCiudad = UIView(frame: frame);
        vistaCiudad.isHidden=true;
        var n = 0;
        for bott in lista{
            let frameBot = CGRect(x: 0, y: vista5.frame.height*CGFloat(n), width: frame.width, height: (frame.height/CGFloat(lista.count))*0.9);
            print("nomb: ", frameBot)
            let bot = UIButton(frame: frameBot);
            let frameNom = CGRect(x: frame.width*0.2, y: 0, width: frame.width, height: vista5.frame.height);
            let lab = UILabel(frame: frameNom);
            lab.textColor=UIColor.gray;
            lab.text=bott;
            bot.addSubview(lab);
            bot.backgroundColor=UIColor.white;
            bot.addTarget(self, action: #selector(DatosPadre.botCiudad(_:)), for: .touchDown);
            vistaCiudad.addSubview(bot);
            n += 1;
        }
        
        vistaCiudad.backgroundColor=UIColor.white;
        self.view.addSubview(vistaCiudad);
    }
    
    func botCiudad(_ sender: UIButton){
        vistaCiudad.isHidden=true;
        for vista in sender.subviews{
            if vista is UILabel{
                let lab = vista as! UILabel;
                print("qq: ", lab.text);
                direccion4.text=lab.text;
            }
        }
        //print("Bot: ", sender);
    }
    
    //Método que inicia la tabla de la direccion
    func iniciaTabTelefono(_ yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRect(x: 0, y: (yini+borde), width: ancho, height: alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        let texto = UILabel(frame: frameText);
        texto.text="Teléfono / Celular";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRect(x: 0, y: (frameBarra.origin.y+alto), width: ancho, height: alto);
        let vista2 = UIView(frame: frameVista2);
        vista2.backgroundColor=UIColor.white;
        let frameText2=CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        telefono = UITextField(frame: frameText2);
        vista2.addSubview(telefono);
        telefono.text=DatosD.contenedor.padre.telefono;
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabFechaEntrega((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la fecha de netrega
    func iniciaTabFechaEntrega(_ yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRect(x: 0, y: (yini+borde), width: ancho, height: alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        let texto = UILabel(frame: frameText);
        texto.text="Fecha de entrega";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRect(x: 0, y: (frameBarra.origin.y+alto), width: ancho, height: alto);
        let vista2 = UIButton(frame: frameVista2);

        vista2.addTarget(self, action: #selector(DatosPadre.listaDesplegable1(_:)), for: .touchDown);
        vista2.backgroundColor=UIColor.white;
        let frameText2=CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        self.texto = UILabel(frame: frameText2);
        self.texto.text="Selecciona la Fecha";
        vista2.addSubview(self.texto);
        
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabHoraEntrega((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la fecha de netrega
    func iniciaTabHoraEntrega(_ yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRect(x: 0, y: (yini+borde), width: ancho, height: alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        let texto = UILabel(frame: frameText);
        texto.text="Hora de entrega";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRect(x: 0, y: (frameBarra.origin.y+alto), width: ancho, height: alto);
        let vista2 = UIButton(frame: frameVista2);
        //vista2.addTarget(self, action: #selector(DatosPadre.listaDesplegable2(_:)), forControlEvents: .TouchDown);
        vista2.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameText2=CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        self.texto2 = UILabel(frame: frameText2);
        vista2.addSubview(self.texto2);
        self.texto2.text="Te entregaremos el pedido durante el día";
        self.texto2.adjustsFontSizeToFitWidth=true;
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabMetodo((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la fecha de netrega
    func iniciaTabMetodo(_ yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.06;
        let frameBarra = CGRect(x: 0, y: (yini+borde), width: ancho, height: alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        let texto = UILabel(frame: frameText);
        texto.text="Forma de pago";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRect(x: 0, y: (frameBarra.origin.y+alto), width: ancho, height: alto);
        let vista2 = UIButton(frame: frameVista2);
        vista2.backgroundColor=UIColor.white;
        vista2.addTarget(self, action: #selector(DatosPadre.iniciaListaDesplegableMetodo(_:)), for: .touchDown);
        let frameText2=CGRect(x: bordeTxt, y: 0, width: ancho, height: alto);
        metodo = UILabel(frame: frameText2);
        vista2.addSubview(metodo);
        metodo.text="Selecciona tu forma de pago";
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciabotonPedido(vista2.frame.origin.y+vista2.frame.height);
    }
    
    func iniciaListaDesplegableMetodo(_ sender: UIButton){
        bloqueador();
        let Datos = ["Crédito"];
        let despliega = VistaMetodos(opciones: Datos);
        
        self.view.addSubview(despliega);
        //DatosK.cont.subeVista(self.view);
    }
    
    
    //Método que inicia el boton del pedido
    func iniciabotonPedido(_ yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP*0.6;
        let alto = DatosC.contenedor.anchoP*0.1;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let frameBarra = CGRect(x: OX, y: (yini+borde), width: ancho, height: alto);
        boton = UIButton(frame: frameBarra);
        DatosB.cont.poneFondoTot(boton, fondoStr: "Botón Hacer pedido", framePers: nil, identi: nil, scala: true);
        boton.addTarget(self, action: #selector(DatosPadre.valida), for: .touchDown);
        self.view.addSubview(boton);
        
    }
   
    func listaDesplegable1(_ vistai: UIView){
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
    
    func listaDesplegable2(_ vistai: UIView){
        
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
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "";
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        print("oooo");
        if(textField.text != ""&&tieneNumeros(textField.text!)){
            //let cons = ConsultaD();
            //cons.consulta(textField.text!, padre: self);
            
        }
        if (vistaDir != nil){
            self.vistaDir.removeFromSuperview();
        }
        
    }
    
    func iniciaMensaje(_ direcciones: [Direcciones]){
        let ancho = self.view.frame.width*0.8;
        let alto = self.view.frame.height*0.4;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = (self.view.frame.height/2)-(alto/2);
        let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
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
            debita();
            //subePedido();
        }
    }
    
    func debita(){
        subePedido();
    }
    
    func debita2(){
        if(tarjeta != nil && metodo.text != "Efectivo"){
                       var tipos = "";
            var precio = 0;
            for lonch in DatosB.cont.listaLoncheras{
                tipos += lonch.0.nombr+"-"+String(lonch.1);
                precio += lonch.0.valor;
            }
            precio += Int(DatosB.cont.envia);
            print("TT: ", tipos);
            let debita = DebitCard(tarjeta: tarjeta, cantidad: String(precio), descripcion: tipos, referencia: String(idReferencia), vat: "0.00");
            //debita.debita(String(precio), descripcion: tipos, referencia: String(idReferencia), vat: "0.00");
        }else{
            print("No hay método");
        }
    }
    
    func tieneNumeros(_ texto: String)->Bool{
        var pasa = true;
        var p = 0;
        var tiene=false;
        while (pasa) {
            let indice = texto.characters.index(texto.startIndex, offsetBy: p);
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
    
    func tieneLetras(_ texto: String)->Bool{
        var pasa = true;
        var p = 0;
        var tiene=true;
        while (pasa) {
            let indice = texto.characters.index(texto.startIndex, offsetBy: p);
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
        var aprobado = false
        print("MétodoV: ", metodoV);
        if(metodoV == "Efectivo"){
            aprobado = true;
        }
        subeP.subePedido(DatosD.contenedor.padre, fechaPedido: fechaActual(), fechaEntrega: fecha, horaEntrega: hora, valor: valor(), cantidad: cant(), metodo: metodoV, aprobado: aprobado);
        boton.isEnabled=false;
    }
    
    func muestraMensajeExito(){
        let msgExito = VistaSubidaExito();
        self.view.addSubview(msgExito);
        //performSegueWithIdentifier("Regresa", sender: nil);
        
        //(self.superview as Carrito).dismissViewControllerAnimated(true, completion: nil);
    }
    
    func cierraPadre(){
        
        self.dismiss(animated: true, completion: nil);
        carrito.dismiss(animated: false, completion: nil);
        DatosB.cont.listaLoncheras=[(Lonchera2, Int)]();
        DatosB.cont.loncheras=[Lonchera2]();
        DatosB.cont.home2.botonCarrito.cant.text="0";
    }
    
    func fechaActual()->String{
        let date = Date();
        let formateador:DateFormatter=DateFormatter();
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="yyyy-MM-dd hh:mm:ss-";
        return  formateador.string(from: date)+"04";
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
        let frameB = CGRect(x: 0, y: 0, width: ancho, height: alto);
        bloq = UIView(frame: frameB);
        self.view.addSubview(bloq);
        bloq.backgroundColor=UIColor.clear;
    }
    
    func desbloqueador(){
        if (bloq != nil){
            bloq.removeFromSuperview();
        }
    }

}
