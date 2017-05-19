//
//  CargaLista.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaLista: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString();
    
    var productos = [Producto]();
    var cargaT: CargaTipos;
    
    init(cargaT: CargaTipos){
        self.cargaT=cargaT;
    }
    
    func cargaLista(_ idTipo: Int){
        
        
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:productosPorTipo>";
        
        mensajeEnviado += "<idTipo>"+String(idTipo)+"</idTipo>";
        
        mensajeEnviado += "</enp:productosPorTipo></soapenv:Body></soapenv:Envelope>";
        
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
            
            //print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " , error!)
            }
            //print(self.resp)
            self.parser=XMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            DispatchQueue.main.async(execute: {
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
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqual(to: "listaSaludResponse"){
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
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
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
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
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
