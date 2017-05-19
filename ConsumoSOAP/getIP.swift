//
//  getIP.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 6/04/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class getIP: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var task: URLSessionDataTask!;
    var element=NSString();
    var resp: Data! = nil
    var estado:NSMutableString!
    var ip: String!;
    var padre: DebitCard!;
    var parser=XMLParser();
    
    init(padre: DebitCard){
        self.padre=padre;
        
    }
    
    func consulta(){
        
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint"
        let mensaje = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ipCliente/></soapenv:Body></soapenv:Envelope>";
        
        let lobj_Request = NSMutableURLRequest(url: URL(string: is_URL)!)
        let session = URLSession.shared
        let _: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = mensaje.data(using: String.Encoding.utf8)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensaje.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"ipCliente\"", forHTTPHeaderField: "SOAPAction")

        task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Get IPPPPP");
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
            self.parser=XMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();

            DispatchQueue.main.async(execute: {
                self.padre.ip = self.ip;
                self.padre.consulta();
            });
        });
        task.resume();
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName as NSString;
        print("elementos: ", element);
        if(elementName as NSString).isEqual(to: "ipCliente"){
            estado=NSMutableString();
            estado="";
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        ip = string;
        print("IP ext: ", ip);
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("fin ip");
    }
    
}
