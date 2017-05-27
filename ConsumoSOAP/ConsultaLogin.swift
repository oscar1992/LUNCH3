//
//  ConsultaLogin.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 25/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class ConsultaLogin : NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var PLogin:LoginView?;
    var task: URLSessionDataTask!;
    var profundidad = 0;
    
    init(plogin: LoginView) {
        self.PLogin=plogin;
    }
    
    func consulta(_ email: String!, pass: String!){
        PLogin?.bloquea();
        _=email;
        let pas=pass;
        //print(ema, pas);
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:login><email>"+email+"</email><pass>"+pas!+"</pass></enp:login></soapenv:Body></soapenv:Envelope>"
        
        print("Mensaje: ", mensajeEnviado);
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/adminEndpoint"
        
        let lobj_Request = NSMutableURLRequest(url: URL(string: is_URL)!)
        let session = URLSession.shared
        let _: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = mensajeEnviado.data(using: String.Encoding.utf8)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"bool\"", forHTTPHeaderField: "SOAPAction")
        
        task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //
            var nulo = false;
            if(data == nil){
                nulo = true;
                
                print("NULOOOO en consulta login");
                
                //print("Response: \(response)")
            }else{
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                
                //print("Body: \(strData)")
                
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
                self.PLogin?.Msg="Tu Usuario o Contraseña no son válidos";
               
            }
            DispatchQueue.main.async(execute: {
                print("nulo: ", nulo, "prof: ", self.profundidad);
                if(nulo && self.profundidad<2){
                    print("reinicia");
                    self.profundidad += 1;
                    self.consulta(email, pass: pass);
                    self.task.cancel();
                }else if(self.profundidad>=2 && nulo){
                    print("Se pasó de intentos");
                    self.msgDesconexion();
                    /*
                    let ancho = self.PLogin!.view.frame.width*0.8;
                    let alto = self.PLogin!.view.frame.height*0.4;
                    let OX = (self.PLogin!.view.frame.width/2)-(ancho/2);
                    let OY = (self.PLogin!.view.frame.height/2)-(alto/2);
                    let frameMensaje = CGRectMake(OX, OY, ancho, alto);
                    let mensaje = MensajeConexion(frame: frameMensaje, msg: nil);
                    mensaje.iniciaTimer();
                    self.PLogin?.view.addSubview(mensaje);
                    mensaje.layer.zPosition=5;
                    self.PLogin!.view.bringSubviewToFront(mensaje);
                    */
                }else{
                    print("aprueba: ",self.aprueba);
                    //self.PLogin?.ingresa.enabled=true;
                    self.PLogin?.aprueba = self.aprueba;
                    print("app: ", self.PLogin?.aprueba);
                    
                    if(self.PLogin!.aprueba == true){
                        print("pasa1: ", email, " - ", pass);
                        let cons = ConsultaNinos();
                        cons.consulta(self.PLogin!, aprueba: self.aprueba);
                        
                    }else{
                        DatosB.cont.favoritos=[Favoritos]();
                        
                        DatosC.elimina();
                        DatosD.elimina();
                        //_ = CargaInicial();
                        self.PLogin!.desbloquea();
                    }
                    self.PLogin!.pasa();
                    
                }
                }
                
            );
          
            //print(self.resp)
            
            //print("ini");
            
            
            
            
            
        
            
            
            
        })
        
        task.resume();
        
        //print("Consulta Login :",pasa);
        
        
    }
    
    
    
    //MARK: Delegados Parser
    var aprueba=false;
    
    var id=false;
    var nombre=false;
    var telefono=false;
    var direccion=false;
    var email=false;
    var pass=false;
    var primeravez=false;
    var numeroConf=false;
    var terminos=false;
    var terminoFecha=false;
    var genero = false;
    var adicional = false;
    var barrio = false;
    var ciudad = false;
    
    var Pid:Int?;
    var Pnombre:String?;
    var Ptelefono:String?;
    var Pdireccion:String?;
    var Pemail:String?
    var Ppass:String?
    var PprimeraVez:Bool?;
    var PnumeroConfirmacion:String?;
    var Pterminos:Bool?;
    var PterminoFecha:String?;
    var Pgenero:String?;
    var Padicional:String?;
    var Pbarrio:String?;
    var Pciudad:String?;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName as NSString;
        //print("eleNA: ",element);
        if(elementName as NSString).isEqual(to: "loginResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case "contrasena":
            pass=true;
            break;
        case "direccion":
            direccion=true;
            break;
        case "email":
            email=true;
            break;
        case "idPadre":
            id=true;
            break;
        case "nombre":
            nombre=true;
            break;
        case "numeroconfirmacion":
            numeroConf=true;
            break;
        case "primeravez":
            primeravez=true;
            break;
        case "telefono":
            telefono=true;
            break;
        case "termino":
            terminos=true;
            break;
        case "terminoFecha":
            terminoFecha=true;
            break;
        case "genero":
            genero=true;
            break;
        case "adicional":
            adicional=true;
            break;
        case "barrio":
            barrio=true;
            break;
        case "ciudad":
            ciudad=true;
            break;

            
        default:
            break;
        }
    
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(id){
            Pid=Int(string);
            //print("Pid: ",Pid);
            id=false;
        }
        if(nombre){
            Pnombre=string;
            //print("nom: ", string);
            nombre=false;
        }
        if(telefono){
            if(string == ""){
                Ptelefono = "";
            }else{
                Ptelefono = string;
            }
            
            
            //print("tel: ", string);
            telefono=false;
        }
        if(direccion){
            Pdireccion=string;
            //print("dir: ", string);
            direccion=false;
        }
        if(email){
            Pemail=string;
            //print("ema: ", string);
            email=false;
        }
        if(pass){
            Ppass=string;
            //print("pass: ", string);
            
            pass=false;
        }
        if(primeravez){
            if(string == "true"){
                PprimeraVez=true;
            }else{
                PprimeraVez=false;
            }
            primeravez=false;
            //print("primera: ", string);
        }
        if(numeroConf){
            //print("numerc: ", string);
            PnumeroConfirmacion=string;
            numeroConf=false;
        }
        if(terminos){
            if(string == "true"){
                Pterminos=true;
            }else{
                Pterminos=false;
            }
            terminos=false;
        }
        if(terminoFecha){
            PterminoFecha=string;
            print("termino: ", PterminoFecha!);
            terminoFecha=false;
        }
        if(genero){
            Pgenero=string;
            genero=false;
        }
        if(adicional){
            Padicional=string;
            adicional=false;
        }
        if(barrio){
            Pbarrio=string;
            barrio=false;
        }
        if(ciudad){
            Pciudad=string;
            ciudad=false;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("ff: ",elementName);
        if(elementName == "ns2:loginResponse"){
            //print("Pid", Pid);
            if(Pid == nil){
                //print("No")
                aprueba=false;
            }else{
                if(Ptelefono == nil){
                    Ptelefono = "--";
                }
                print("Si")
                /*
                print("id: ", Pid);
                print("nombre: ", Pnombre);
                print("tel: ", Ptelefono);
                print("dir: ", Pdireccion);
                print("ema: ", Pemail);
                print("pass: ", Ppass);
                print("prim: ", PprimeraVez);
                print("nconf: ", PnumeroConfirmacion);
 */
                let pad=Padre(id: Pid!, nombre: Pnombre!, telefono: Ptelefono!, direccion: Pdireccion!, email: Pemail!, pass: Ppass!, primeraVez: PprimeraVez!, numeroConf: PnumeroConfirmacion!, terminos: Pterminos!, terminoFecha: PterminoFecha!, genero: Pgenero!);
                pad.ciudad=Pciudad;
                pad.adicional=Padicional;
                print("Padicio: ", Padicional);
                pad.barrio=Pbarrio;
                DatosD.contenedor.padre=pad;
                aprueba=true;
            }
        }
    }
    
    func msgDesconexion(){
        var vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            
        }else{
            vista = PLogin!;
        }
        let ancho = vista.view.frame.width*0.8;
        let alto = vista.view.frame.height*0.4;
        let OX = (vista.view.frame.width/2)-(ancho/2);
        let OY = (vista.view.frame.height/2)-(alto/2);
        let frameMensaje = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let mensaje = MensajeConexion(frame: frameMensaje, msg: nil);
        vista.view.addSubview(mensaje);
        mensaje.layer.zPosition=5;
        vista.view.bringSubview(toFront: mensaje);
    }
}
