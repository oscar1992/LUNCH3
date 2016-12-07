//
//  CancelaPedido.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 4/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CancelaPedido: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var vista: VIstaDeseaCancelar;
    
    init(vista: VIstaDeseaCancelar){
        self.vista=vista;
    }
    
    func cancelaPedido(pedi: Pedido){
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:cancelaPedido><pedido>";
        
        mensajeEnviado += "<cantidad>"+String(pedi.cantidad)+"</cantidad>";
        mensajeEnviado += "<fechaEntrega>"+pedi.fechaEntrega+"</fechaEntrega>";
        mensajeEnviado += "<fechaPedido>"+pedi.fechaPedido+"</fechaPedido>";
        mensajeEnviado += "<horaEntrega>"+pedi.horaEntrega+"</horaEntrega>";
        mensajeEnviado += "<idPedido>"+String((pedi.id!))+"</idPedido>";
        mensajeEnviado += "<padre><idPadre>"+String(pedi.idPadre)+"</idPadre>";
        mensajeEnviado += "<terminoFecha>"+DatosD.contenedor.padre.terminoFecha!+"</terminoFecha></padre>";
        mensajeEnviado += "<valor>"+String(pedi.valor)+"</valor>";
        mensajeEnviado += "<metodo>"+pedi.metodo+"</metodo>";
        mensajeEnviado += "<cancelado>"+String(pedi.cancelado)+"</cancelado>";
        
        mensajeEnviado += "</pedido></enp:cancelaPedido></soapenv:Body></soapenv:Envelope>";
        
        print("envia Pedido: ", mensajeEnviado);
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
                if(self.ret != nil){
                    self.vista.fin(self.ret);
                }
            });
            
        })
        
        task.resume();
    }
    
    var ret:Bool!;
    var bret=false;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
            case "return":
                bret=true;
                break;
        default:
            break;
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bret){
            if(string == "true"){
                ret = true;
            }else{
                ret = false;
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            
        }
    }
    
}
