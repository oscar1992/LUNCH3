//
//  ConsultaNinos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 25/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class ConsultaNinos: NSObject , NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString();
        
    func consulta(Plogin: LoginView, aprueba: Bool){
        let padre = DatosD.contenedor.padre;
        //print("pp:", padre.id);
        let mensajeEnviado:String
        var pasa = false;
        if(padre.id != nil){
            pasa=true;
            mensajeEnviado = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ninosPorPadre><padre><contrasena></contrasena><direccion></direccion><email></email><idPadre>"+String(padre.id!)+"</idPadre><nombre></nombre><numeroconfirmacion></numeroconfirmacion><primeravez></primeravez><telefono></telefono></padre></enp:ninosPorPadre></soapenv:Body></soapenv:Envelope>"
        }else{
            
            mensajeEnviado = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ninosPorPadre><padre><contrasena></contrasena><direccion></direccion><email></email><idPadre>0</idPadre><nombre></nombre><numeroconfirmacion></numeroconfirmacion><primeravez></primeravez><telefono></telefono></padre></enp:ninosPorPadre></soapenv:Body></soapenv:Envelope>"
        }
        
        
        
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint"
        
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
            
            
            //print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " + error!.description)
            }
            if(data == nil){
                print("NULOOOO en consulta Ninos");
            }else{
                //print(self.resp)
                self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
                self.parser=NSXMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
                self.consume(Plogin);
                //Plogin.desbloquea();
            }
            lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
        })
        
        task.resume();
        
        //print("Consulta Hijos :",pasa);
        
        
    }
    
    //MARK: Delegados + Atributos Ninos
    
    var Bid=false;
    var Bnombre=false;
    var Bfecha=false;
    var Bpadre=false;
    var Bgenero=false;
    
    var id=Int?();
    var nombre=String();
    var fechaNaci=NSDate()
    var padre=Int();
    var genero=String();
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName;
        //print("ETIQUETA: ",element);
        if(elementName as NSString).isEqualToString("ninosPorPadreResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch (elementName){
            
            case "idNino":
                Bid=true;
                break;
            case "nombreNino":
                Bnombre=true;
                break;
            case "genero":
                Bgenero=true;
                break;
            case "id":
                Bpadre=true;
                break;
            case "fechaNacimineto":
                Bfecha=true;
                break;
            default:
                break;
            
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if(Bid){
            id=Int(string);
            Bid=false;
        }
        if(Bnombre){
            nombre=string;
            Bnombre=false;
        }
        if(Bgenero){
            genero=string;
            Bgenero=false;
        }
        if(Bpadre){
            padre = Int(string)!;
            Bpadre=false;
        }
        if(Bfecha){
            let dateFormatter = NSDateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd";
            
            let ss=(string as NSString).substringWithRange(NSRange(location: 0, length: 10));
            //print("ff:", ss);
            let fecha=dateFormatter.dateFromString(ss);
            //print("fff", fecha);
            fechaNaci=fecha!;
            Bfecha=false;
        }
        //print("dat: ",string);
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            if(id != nil){
                //print("trae");
                let nino=Ninos(id: id!, nombre: nombre, fechaN: fechaNaci, padre: padre, genero: genero);
                DatosD.contenedor.ninos.append(nino);
                
            }
        }
    }
    
    func consume(Plogin: LoginView){
        //let cargaI=ConsultaProductos();
        //let cargaII=CargaTItems();
        let cargaIII=CargaSecuencia();
        //let cargaIV=CargaCajas();
        let cargaV=ConsultaCatergorias();
        let cargaVI=CargaEnvio();
        
        
        
        //let cargaVI=CargaFavoritos();
        //print("cargs")
        //cargaI.consulta();
        //cargaII.CargaTItems();
        cargaIII.CargaSecuencia();
        //cargaIV.CargaCajas(Plogin);
        cargaV.consulta();
        cargaVI.cargaEnvio();
        
        
        //cargaVI.consulta(DatosD.contenedor.padre.id);
        
    }

}