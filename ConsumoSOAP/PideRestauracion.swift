//
//  PideRestauracion.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 4/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class PideRestauracion: NSObject ,NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var olvia: Olvida1!;
    
    func existe(email: String, olvia: Olvida1){
        self.olvia=olvia;
        let comp = CompruebaEmail();
        comp.Comprueba(email, padre: nil, restaura: self);
        
    }
    
    func activa(email: String){
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:enviaRecuperacion><email>"+email+"</email></enp:enviaRecuperacion></soapenv:Body></soapenv:Envelope>";
        
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
            self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
            
            print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " + error!.description)
            }
            //print(self.resp)
            self.parser=NSXMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            dispatch_async(dispatch_get_main_queue(),{
                print("enviado");
                self.olvia.mensajeCorreoEnviado();
                //self.olvia.cierraVista();
            });
            
        })
        
        task.resume();
    }
    
    var bpp = true;
    var valida:String!;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("validaEmailResponse"){
            estado=NSMutableString();
            estado="";
        }
        print("ele: ", elementName);
        switch(elementName as NSString){
        case "return":
            bpp=true;
            break;
        default:
            break;
        }
    }
    
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bpp){
            bpp=false;
            valida=string;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            print("id: ", self.valida);
        }
    }
}