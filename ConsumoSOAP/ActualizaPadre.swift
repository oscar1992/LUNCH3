//
//  ActualizaPadre.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 7/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ActualizaPadre: NSObject, NSURLConnectionDelegate, XMLParserDelegate {
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var vista:Olvida2?;
    func actualizaPadre(_ padre: Padre){
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:actualizaPadre><padre><contrasena>"+padre.pass!+"</contrasena>";
        
        mensajeEnviado+="<direccion>"+padre.direccion!+"</direccion><email>"+padre.email!+"</email>"
        
        mensajeEnviado+="<genero>"+padre.genero!+"</genero>";
        
        mensajeEnviado+="<idPadre>"+String(padre.id!)+"</idPadre><nombre>"+padre.nombre!+"</nombre>"
        
        mensajeEnviado+="<numeroconfirmacion>"+padre.numeroConfirmacion!+"</numeroconfirmacion>";
        
        mensajeEnviado+="<primeravez>"+String(padre.primeraVez!)+"</primeravez><telefono>"+padre.telefono!+"</telefono>"
        
        mensajeEnviado+="<termino>"+String(padre.terminos!)+"</termino>"
        
        mensajeEnviado+="<terminoFecha>"+padre.terminoFecha!+"</terminoFecha>";
        
        mensajeEnviado+="</padre></enp:actualizaPadre></soapenv:Body></soapenv:Envelope>";
        
        //print("Mensaje: ", mensajeEnviado);
        
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint"
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
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            var vustaOK=false;
            if(data != nil){
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
                vustaOK=true;
                
            }else{
                vustaOK=false;
                
            }
            
            DispatchQueue.main.async(execute: {
                //DatosB.cont.olvida2.aprueba=true;
                if(self.vista != nil){
                    self.vista!.finCambia(vustaOK);
                }
                //DatosB.cont.loginView.pasa2();
            });
        })
        task.resume();
    }
    
    var id=false;
    var nombre=false;
    var telefono=false;
    var direccion=false;
    var email=false;
    var pass=false;
    var primeravez=false;
    var numeroConf=false;
    var termino=false;
    var terminoFecha=false;
    var genero = false;
    
    var Pid:Int?;
    var Pnombre:String?;
    var Ptelefono:String?;
    var Pdireccion:String?;
    var Pemail:String?
    var Ppass:String?
    var PprimeraVez:Bool?;
    var PnumeroConfirmacion:String?;
    var Ptermino:Bool?;
    var PterminoFecha:String?;
    var Pgenero:String?;
    
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
            termino=true;
            break;
        case "terminoFecha":
            terminoFecha=true;
            break;
        case "genero":
            genero=true;
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
        if(termino){
            termino=false;
            if(string=="true"){
                Ptermino=true;
            }else{
                Ptermino=false;
            }
        }
        if(terminoFecha){
            PterminoFecha=string;
            terminoFecha=false;
        }
        if(genero){
            Pgenero=string;
            genero=false;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("ff: ",elementName);
        if(elementName == "ns2:loginResponse"){
            //print("Pid", Pid);
            if(Pid == nil){
                print("No")

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
                let pad=Padre(id: Pid!, nombre: Pnombre!, telefono: Ptelefono!, direccion: Pdireccion!, email: Pemail!, pass: Ppass!, primeraVez: PprimeraVez!, numeroConf: PnumeroConfirmacion!, terminos: Ptermino!, terminoFecha: PterminoFecha!, genero: Pgenero!);
                DatosD.contenedor.padre=pad;

            }
        }
    }
    
    
    
}
