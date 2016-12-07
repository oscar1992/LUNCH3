//
//  SubeListaProds.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 27/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class SubeListaProds : NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var mensajeEnviado: String = "";
    
    override init() {
        mensajeEnviado = "<soapenv:Envelope xmlns:soapenv= 'http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp= 'http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ingresaLista>";
    }
    
    func armaMensaje(prod: [Producto], idTipo: Int){
        for produ in prod{
            mensajeEnviado += "<listaProds>";
            mensajeEnviado += "<idLista>?</idLista>";
            mensajeEnviado += "<producto>";
            mensajeEnviado += "<idProducto>"+String(produ.id!)+"</idProducto>";
            mensajeEnviado += "</producto>";
            mensajeEnviado += "<tipoLonchera>";
            mensajeEnviado += "<idTipoLonchera>"+String(idTipo)+"</idTipoLonchera>";
            mensajeEnviado += "</tipoLonchera>";
            mensajeEnviado += "</listaProds>";
        }
        
    }
    
    func subeLitsaProds(padre: SubeTipoLonchera){
        
        mensajeEnviado += "</enp:ingresaLista></soapenv:Body></soapenv:Envelope>";
        print("envia: ", mensajeEnviado);
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
            
            //print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " + error!.description)
            }
            //print(self.resp)
            self.parser=NSXMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            dispatch_async(dispatch_get_main_queue(),{
                DatosB.cont.datosPadre.muestraMensajeExito();
            });
            
        })
        
        task.resume();
    }
    
    var bid = false;
    var id:String!;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("ingresaTipoLonchera"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case "idTipoLonchera":
            bid=true;
            break;
        default:
            break;
        }
    }
    
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bid){
            bid=false;
            id=string;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            print("id: ", self.id);
        }
    }
}
