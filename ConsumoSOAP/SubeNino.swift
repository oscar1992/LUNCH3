//
//  SubeNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 30/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class SubeNino: NSObject , NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    var fechaN : String!;
    var genero : String!;
    var nombre : String!;
    var padre : String!;
    var inserta : Bool!;
    var crea : CreaNino?;
    
    func envía(_ nino: Ninos){
        print("Entra");
        fechaN = String(describing: nino.fechaNacimiento!);
        genero = String(nino.genero!);
        nombre = String(nino.nombre!);
        padre = String(nino.padre!);
        var datos = "";
        datos = "<nino><fechaNacimineto>"+fechaN!+"</fechaNacimineto><genero>"+genero!+"</genero><idNino>?</idNino><nombreNino>"+nombre!+"</nombreNino><padre><idPadre>"+padre!+"</idPadre></padre></nino>";
        
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ingresaNino>"+datos+"</enp:ingresaNino></soapenv:Body></soapenv:Envelope>";
        
        print("ENV: ", mensajeEnviado);
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint"
        
        let lobj_Request = NSMutableURLRequest(url: URL(string: is_URL)!)
        let session = URLSession.shared
        let _: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = mensajeEnviado.data(using: String.Encoding.utf8)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"bool\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
            
            print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " , error!)
            }
            //print(self.resp)
            self.parser=XMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            DispatchQueue.main.async(execute: {
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
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if(elementName as NSString).isEqual(to: "ingresaNinoResponse"){
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
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(ret){
            if(string == "true"){
                inserta = true;
            }else{
                inserta = false;
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
}
