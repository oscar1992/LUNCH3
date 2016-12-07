//
//  CargaFechaEntrega.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 19/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaFechaEntrega: NSObject , NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    
    func cargaFechaEntrega(){
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaFechaEntrega/></soapenv:Body></soapenv:Envelope>";
        //print("envia: ", mensajeEnviado);
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/adminEndpoint"
        
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        let session = NSURLSession.sharedSession()
        let _: NSError?
        
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = mensajeEnviado.dataUsingEncoding(NSASCIIStringEncoding)
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
                print("Carga Fechas Envio OK");
                
                let cargaHora=CargaHoraEntrega();
                cargaHora.cargaHorasEntrega();
                
            });
            
        })
        task.resume();
        
    }
    
    var bidf=false;
    var bf=false;
    var bd=false;
    
    var idf:Int!;
    var f:String!;
    var d:Int!;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case"idFecha":
            bidf=true;
            break;
        case"fecha":
            bf=true;
            break;
        case"dia":
            bd=true;
            break;
        default:
            break;
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bidf){
            bidf=false;
            idf=Int(string);
        }
        if(bf){
            bf=false;
            f=string;
        }
        if(bd){
            bd=false;
            d=Int(string);
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            //print("añade")
            let fechaEntrega = FechaEntrega(id: idf, nom: f, ndia: d);
            DatosB.cont.FechasEntrega.append(fechaEntrega);
        }
    }

}