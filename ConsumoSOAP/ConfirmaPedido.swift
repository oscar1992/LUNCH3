//
//  SubePedido.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 25/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ConfirmaPedido: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var idReferencia:Int!;
    
    func confirmaPedido(_ idPedido: String, idPadre: Padre, fechaPedido: String, fechaEntrega: String, horaEntrega: String, valor: Double, cantidad: Int, metodo: String, aprobado: Bool){
        
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:actualizaPedido><Pedido>";
        
        mensajeEnviado += "<aprobado>"+String(aprobado)+"</aprobado>";
        mensajeEnviado += "<cantidad>"+String(cantidad)+"</cantidad>";
        mensajeEnviado += "<fechaEntrega>"+fechaEntrega+"</fechaEntrega>";
        mensajeEnviado += "<fechaPedido>"+fechaPedido+"</fechaPedido>";
        mensajeEnviado += "<horaEntrega>"+horaEntrega+"</horaEntrega>";
        mensajeEnviado += "<idPedido>"+idPedido+"</idPedido>";
        mensajeEnviado += "<padre><idPadre>"+String(idPadre.id!)+"</idPadre>";
        mensajeEnviado += "<terminoFecha>"+idPadre.terminoFecha!+"</terminoFecha></padre>";
        mensajeEnviado += "<valor>"+String(valor)+"</valor>";
        mensajeEnviado += "<metodo>"+metodo+"</metodo>";
        
        mensajeEnviado += "</Pedido></enp:actualizaPedido></soapenv:Body></soapenv:Envelope>";
        
        print("envia Pedido: ", mensajeEnviado);
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
                print("Exito: ", data);
            });
            
        })
        
        task.resume();
    }
    
    var bid = false;
    var id:String!;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqual(to: "listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case "idPedido":
            bid=true;
            break;
        default:
            break;
        }
    }
    
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(bid){
            bid=false;
            id=string;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            idReferencia = Int(id);
            //print("idPedido: ", self.id);
        }
    }
    
    
}
