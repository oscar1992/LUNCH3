//
//  CargaLista.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaLista: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString();
    
    var productos = [Producto]();
    var cargaT: CargaTipos;
    
    init(cargaT: CargaTipos){
        self.cargaT=cargaT;
    }
    
    func cargaLista(idTipo: Int){
        
        
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:productosPorTipo>";
        
        mensajeEnviado += "<idTipo>"+String(idTipo)+"</idTipo>";
        
        mensajeEnviado += "</enp:productosPorTipo></soapenv:Body></soapenv:Envelope>";
        
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
                print("retorna: ", self.idTipo);
                self.cargaT.agregaLista((self.idTipo, self.productos));
                self.productos = [Producto]();
                print("------fin tipolista-------");
            });
            
        })
        
        task.resume();
    }
    
    var idLista: Int!;
    var idProducto: Int!;
    var idTipo: Int!;
    
    var bIdLista = false;
    var bIdProducto = false;
    var bIdTipo = false;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case "idLista":
            bIdLista=true;
            break;
        case "idProducto":
            bIdProducto=true;
            break;
        case "idTipoLonchera":
            bIdTipo=true;
            break;
        default:
            break;
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bIdLista){
            idLista=Int(string);
            bIdLista=false;
        }
        if(bIdProducto){
            idProducto=Int(string);
         
            bIdProducto=false;
        }
        if(bIdTipo){
            idTipo=Int(string);
            bIdTipo=false;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            
            for prod in DatosC.contenedor.productos{
                if(prod.id == idProducto){
                    print("prod: ", prod.nombre);
                    productos.append(prod);
                }
            }
        }
    }
}
