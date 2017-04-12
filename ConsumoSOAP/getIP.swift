//
//  getIP.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 6/04/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class getIP: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var task: NSURLSessionDataTask!;
    var element=NSString();
    var resp: NSData! = nil
    var estado:NSMutableString!
    var ip: String!;
    var padre: DebitCard!;
    var parser=NSXMLParser();
    
    init(padre: DebitCard){
        self.padre=padre;
        
    }
    
    func consulta(){
        
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint"
        let mensaje = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ipCliente/></soapenv:Body></soapenv:Envelope>";
        
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        let session = NSURLSession.sharedSession()
        let _: NSError?
        
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = mensaje.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensaje.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"ipCliente\"", forHTTPHeaderField: "SOAPAction")

        task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in 
            print("Get IPPPPP");
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
            self.parser=NSXMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();

            dispatch_async(dispatch_get_main_queue(),{
                self.padre.ip = self.ip;
                self.padre.consulta();
            });
        });
        task.resume();
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName;
        print("elementos: ", element);
        if(elementName as NSString).isEqualToString("ipCliente"){
            estado=NSMutableString();
            estado="";
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        ip = string;
        print("IP ext: ", ip);
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("fin ip");
    }
    
}
