//
//  ConsultaLogin.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 25/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class ConsultaLogin : NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var PLogin:LoginView?;
    
    
    func consulta(email: String!, pass: String!){
        
        let ema=email;
        let pas=pass;
        //print(ema, pas);
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:login><email>"+email+"</email><pass>"+pas+"</pass></enp:login></soapenv:Body></soapenv:Envelope>"
        
        //print("Mensaje: ", mensajeEnviado);
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/adminEndpoint"
        
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        let session = NSURLSession.sharedSession()
        let _: NSError?
        
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = mensajeEnviado.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"bool\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
            
            //print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " + error!.description)
            }
            //print(self.resp)
            self.parser=NSXMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            //print("ini");
            let consNinos=ConsultaNinos();
            self.PLogin?.aprueba = self.aprueba;
            
            if(self.PLogin!.aprueba == true){
                consNinos.consulta(self.PLogin!, aprueba: self.aprueba);
            }else{
                dispatch_async(dispatch_get_main_queue(),{
                    //print("aprueba: ",self.aprueba);
                    
                    self.PLogin!.pasa();
                    
                    }
                );

            }
            
            
            
        
            
            
            
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
    
    var Pid:Int?;
    var Pnombre:String?;
    var Ptelefono:String?;
    var Pdireccion:String?;
    var Pemail:String?
    var Ppass:String?
    var PprimeraVez:Bool?;
    var PnumeroConfirmacion:String?;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName;
        //print("eleNA: ",element);
        if(elementName as NSString).isEqualToString("loginResponse"){
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
        
        default:
            break;
        }
    
    }

    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(id){
            Pid=Int(string);
            //print("Pid: ",Pid);
            id=false;
        }
        if(nombre){
            Pnombre=string;
            nombre=false;
        }
        if(telefono){
            Ptelefono=string;
            telefono=false;
        }
        if(direccion){
            Pdireccion=string;
            direccion=false;
        }
        if(email){
            Pemail=string;
            email=false;
        }
        if(pass){
            Ppass=string;
            pass=false;
        }
        if(primeravez){
            if(string == "true"){
                PprimeraVez=true;
            }else{
                PprimeraVez=false;
            }
            primeravez=false;
        }
        if(numeroConf){
            PnumeroConfirmacion=string;
            numeroConf=false;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("ff: ",elementName);
        if(elementName == "ns2:loginResponse"){
            //print("Pid", Pid);
            if(Pid == nil){
                //print("No")
                aprueba=false;
            }else{
                //print("Si")
                let pad=Padre(id: Pid!, nombre: Pnombre!, telefono: Ptelefono!, direccion: Pdireccion!, email: Pemail!, pass: Ppass!, primeraVez: PprimeraVez!, numeroConf: PnumeroConfirmacion!);
                DatosD.contenedor.padre=pad;
                aprueba=true;
            }
        }
    }
}
