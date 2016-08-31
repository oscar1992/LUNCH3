//
//  CargaTags.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 15/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaTags: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    func consulta(idProdcuto: Producto){
        
        let idP = String(idProdcuto.id!);
        //print(idP);
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:tagsPorProducto><idProducto>"+idP+"</idProducto></enp:tagsPorProducto></soapenv:Body></soapenv:Envelope>";
        
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
        lobj_Request.addValue("\"tagsPorProducto\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
            //print("envia: ", mensajeEnviado);
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
            
                dispatch_async(dispatch_get_main_queue(),{
                    //print("Carga Tags");
                    
                    
                    }
                );
                
            
        })
        
        task.resume();
    }
    
    var idTag=false;
    var nombreTag=false;
    var idProducto=false;
    
    var idt:Int?;
    var nombre:String?;
    var producto:Int?;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if(elementName as NSString).isEqualToString("loginResponse"){
            estado=NSMutableString();
            estado="";
        }
        //print("estado: ", estado);
        switch(elementName as NSString){
        case "idTag":
            idTag=true;
            break;
        case "nombreTag":
            nombreTag=true;
            break;
        case "idProducto":
            idProducto=true;
            break;
        default:
            break;
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(idTag){
            idt=Int(string);
            idTag=false;
        }
        if(nombreTag){
            //print("nombre", string);
            nombre=string;
            nombreTag=false;
        }
        if(idProducto){
            producto=Int(string);
            idProducto=false;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print(" r. ",elementName);
        if(elementName == "nombreTag"){
            
        }
        if(elementName == "return"){
            
            if(idt != nil){
                //print("nn tag: ", nombre);
                //print("idt:", idt)
                let tag = Tag(id: idt!, nombreTag: nombre!, idProducto: producto!);
                DatosD.contenedor.tags.append(tag);
                
                
            }
            
        }
    }
}
