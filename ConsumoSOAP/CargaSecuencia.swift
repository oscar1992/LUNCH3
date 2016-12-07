//
//  CargaSecuencia.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 13/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaSecuencia: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate {
    
    var mensajeEnviado:String="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaCombinacionesEntity/></soapenv:Body></soapenv:Envelope>";
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    //MARK: Consulta
    
    func CargaSecuencia(){
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
        lobj_Request.addValue("\"listaSecuenciaEntity\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            if(data == nil){
                print("nulo en secuencias");
            }else{
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
                self.parser=NSXMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse()
            }
            
            dispatch_async(dispatch_get_main_queue(),{
                print("Carga Secuencias");
                lobj_Request.setValue("Connection", forHTTPHeaderField: "close");

                
            });
        })
        
        task.resume()
        
    }
    
    //MARK: Delegados Parser
    
    var id:Int?;
    var Nombre:String?;
    var orden:Int?;
    var idCaja:Int?;
    
    var flagId=false;
    var flagNombre=false;
    var flagOrden=false;
    var flagIdCaja=false;
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element=elementName;
        //print("elementos: ", element);
        if(elementName as NSString).isEqualToString("listaCombinacionesEntityResponse"){
            estado=NSMutableString();
            estado="";
        }
        
        switch (elementName as NSString) {
        case "idCombinaciones":
            flagId=true;
            break;
        case "nombre":
            flagNombre=true;
            break;
        case "orden":
            flagOrden=true;
            break;
        case "idCaja":
            flagIdCaja=true;
            break;
        default:
            break;
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(flagId){
            id=Int(string);
            //print("id secu: ", id)
            flagId=false;
        }
        if(flagNombre){
            Nombre=string;
            flagNombre=false;
        }
        if(flagOrden){
            orden=Int(string);
            flagOrden=false;
        }
        if(flagIdCaja){
            idCaja=Int(string);
            //print("id caja: ");
            flagIdCaja=false;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqualToString("return"){
            
            let secu=Secuencia(id: id!);
            secu.caja=idCaja;
            secu.nombre=Nombre;
            //print("Secuencia: ",Nombre);
            DatosC.contenedor.secuencia.append(secu)
            //print("Añade Secuencia: ",secu.id);
        }
    }
}
