//
//  SubeNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 30/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class SubeNino: NSObject , NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    var fechaN : String!;
    var genero : String!;
    var nombre : String!;
    var padre : String!;
    var inserta : Bool!;
    var crea : CreaNino?;
    
    func envía(nino: Ninos){
        print("Entra");
        fechaN = String(nino.fechaNacimiento!);
        genero = String(nino.genero!);
        nombre = String(nino.nombre!);
        padre = String(nino.padre!);
        var datos = "";
        datos = "<nino><fechaNacimineto>"+fechaN!+"</fechaNacimineto><genero>"+genero!+"</genero><idNino>?</idNino><nombreNino>"+nombre!+"</nombreNino><padre><idPadre>"+padre!+"</idPadre></padre></nino>";
        
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ingresaNino>"+datos+"</enp:ingresaNino></soapenv:Body></soapenv:Envelope>";
        
        print("ENV: ", mensajeEnviado);
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
                if(self.inserta == true){
                    print("Sube Nino OK");
                    self.crea?.apruebaInserción(nino);
                }else{
                    print("Sube Nino ERROR");
                }
                
            });
            
        })
        
        task.resume();
    }
    
    var ret=false;
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if(elementName as NSString).isEqualToString("ingresaNinoResponse"){
            estado=NSMutableString();
            estado="";
        }
        
        switch(elementName as NSString){
        case "return":
            ret = true;
            break;
        default:
            break;
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(ret){
            if(string == "true"){
                inserta = true;
            }else{
                inserta = false;
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
}
