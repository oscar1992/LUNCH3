//
//  CargaTItems.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaTItems: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var objs=[TItems]();
    var mensajeEnviado:String="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaItemEntity/></soapenv:Body></soapenv:Envelope>";
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    func CargaTItems(){
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
        lobj_Request.addValue("\"listaItemsEntity\"", forHTTPHeaderField: "SOAPAction")
        
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
            self.parser.parse()
            dispatch_async(dispatch_get_main_queue(),{
                print("Carga Items");
                
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
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName;
        //print("eleNA: ",element);
        if(elementName as NSString).isEqualToString("listaItemEntityResponse"){
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
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
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
    
     func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqualToString("return"){
            
            let titem=TItems(id: id!);
            titem.Combinacion=idCombinacion;
            titem.idProducto=idProducto;
            DatosC.contenedor.titems.append(titem);
            //print("ingreso Ok: ", titem.idProducto);
            
        }
        
    }
    
}
