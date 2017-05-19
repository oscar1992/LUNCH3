//
//  CargaTItems.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaTItems: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var objs=[TItems]();
    var mensajeEnviado:String="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaItemEntity/></soapenv:Body></soapenv:Envelope>";
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    func CargaTItems(_ cInicial: CargaInicial){
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
        lobj_Request.addValue("\"listaItemsEntity\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
            
            //print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " , error!)
            }
            //print(self.resp)
            self.parser=XMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse()
            DispatchQueue.main.async(execute: {
                print("Carga Items");
                let cargaI2 = CargaInicial2(cInicial: cInicial);
                cargaI2.guarda(DatosC.contenedor.titems, tipo: TItems.self);
                lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
            });
        })
        
        task.resume()
        

    }
    
    //MARK: Delegados Parser
    
    var id:Int?;
    var idProducto:Int?;
    var idCombinacion:Int?;
    
    var flagId=false;
    var flagProducto=false;
    var flagIdCombinacion=false;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName as NSString;
        //print("eleNA: ",element);
        if(elementName as NSString).isEqual(to: "listaItemEntityResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch (elementName as NSString) {
        
        case "idItem":
            flagId=true;
            break;
        case "idProducto":
            flagProducto=true;
            break;
        case "idCombinaciones":
            flagIdCombinacion=true;
            break;
        default:
            break;
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if(flagProducto){
            //print("idProducto: ",string);
            idProducto=Int(string);
            flagProducto=false;
        }
        if(flagId){
            //print("id; ",string);
            id=Int(string);
            flagId=false;
        }
        if(flagIdCombinacion){
            //print("Id combina: ",string);
            idCombinacion=Int(string);
            flagIdCombinacion=false;
        }
    }
    
     func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "return"){
            
            let titem=TItems(id: id!);
            //titem.Combinacion=idCombinacion;
            //titem.idProducto=idProducto;
            DatosC.contenedor.titems.append(titem);
            //print("ingreso Ok: ", titem.idProducto);
            
        }
        
    }
    
}
