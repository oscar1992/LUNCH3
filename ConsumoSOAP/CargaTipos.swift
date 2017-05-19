//
//  CargaTipos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaTipos: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString();
    var pedido:Pedido!;
    var tipos = [(String, Int, Int)]();
    var tiposR = [((String, Int, Int), [Producto])]();
    
    func cargaTipos(_ pedido: Pedido){
        self.pedido=pedido;
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:tiposPorPedido>";
        
        mensajeEnviado += "<idPedido>"+String(pedido.id!)+"</idPedido>";
        
        mensajeEnviado += "</enp:tiposPorPedido></soapenv:Body></soapenv:Envelope>";
        
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
                print("Carga Tipos")
                let cargaL = CargaLista(cargaT: self);
                
                for tipo in self.tipos{
                    cargaL.cargaLista(tipo.2);
                    print("nnn: ", tipo.0, tipo.2);
                }
            });
            
        })
        
        task.resume();
    }
    
    var cantidad: Int!;
    var id: Int!;
    var nombre: String!;
    
    
    var bcantidad = false;
    var bid = false;
    var bnombre = false;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqual(to: "listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case "cantidad":
            bcantidad=true;
            break;
        case "idTipoLonchera":
            bid=true;
            break;
        case "nombreTipo":
            bnombre=true;
            break;
        default:
            break;
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(bcantidad){
            cantidad=Int(string);
            bcantidad=false;
        }
        if(bid){
            id=Int(string);
            print("idT: ", id);
            bid=false;
        }
        if(bnombre){
            nombre=string;
            bnombre=false;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            let tipo = (nombre!, cantidad!, id!);
            tipos.append(tipo);
        }
    }
    
    func agregaLista(_ lista: (Int, [Producto])){
        for tipo in self.tipos{
            print("lista0: ", lista.0, " tipo2: ", tipo.2);
            if(lista.0 == tipo.2){
                tiposR.append((tipo, lista.1));
            }
        }
        DatosB.cont.tipos.actuaScroll(tiposR);
        
    }
}
