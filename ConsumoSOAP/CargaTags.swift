//
//  CargaTags.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 15/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaTags: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var task: URLSessionDataTask!;
    var produndidad: Int;
    var mal = false;
    
    override init(){
        self.produndidad = 0;
    }
    
    func consulta(_ idProdcuto: Producto){
        
        let idP = String(idProdcuto.id!);
        //print(idP);
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:tagsPorProducto><idProducto>"+idP+"</idProducto></enp:tagsPorProducto></soapenv:Body></soapenv:Envelope>";
        
        //print("Mensaje: ", mensajeEnviado);
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
        lobj_Request.addValue("\"tagsPorProducto\"", forHTTPHeaderField: "SOAPAction")
        
        task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            self.task.priority=1.0;
            if(data == nil){
                print("NULOOOO en Tags");
                self.task.cancel();
                print("Cancela Tags ", self.idProducto);
                self.mal = true;
            }else{
                //print("Inicia Tags: ", self.produndidad);
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                //print("envia: ", mensajeEnviado);
                //print("Body: \(strData)")

                //print(self.resp)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
            }
            
            //print("ini");
            
                DispatchQueue.main.async(execute: {
                    print("Carga Tags: ", self.mal);
                    if(self.mal){
                        self.produndidad += 1;
                        self.consulta(idProdcuto);
                    }
                    
                    
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
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if(elementName as NSString).isEqual(to: "loginResponse"){
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
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
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
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
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
