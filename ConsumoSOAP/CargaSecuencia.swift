//
//  CargaSecuencia.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 13/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaSecuencia: NSObject, NSURLConnectionDelegate, XMLParserDelegate {
    
    var mensajeEnviado:String="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaCombinacionesEntity/></soapenv:Body></soapenv:Envelope>";
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    //MARK: Consulta
    
    func CargaSecuencia(){
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
        lobj_Request.addValue("\"listaSecuenciaEntity\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            if(data == nil){
                print("nulo en secuencias");
            }else{
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse()
            }
            
            DispatchQueue.main.async(execute: {
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
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element=elementName as NSString;
        //print("elementos: ", element);
        if(elementName as NSString).isEqual(to: "listaCombinacionesEntityResponse"){
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
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
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
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "return"){
            
            let secu=Secuencia(id: id!);
            secu.caja=idCaja;
            secu.nombre=Nombre;
            //print("Secuencia: ",Nombre);
            DatosC.contenedor.secuencia.append(secu)
            //print("Añade Secuencia: ",secu.id);
        }
    }
}
