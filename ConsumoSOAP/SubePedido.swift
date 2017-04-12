//
//  SubePedido.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 25/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class SubePedido: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var idReferencia:Int!;
    
    func subePedido(idPadre: Padre, fechaPedido: String, fechaEntrega: String, horaEntrega: String, valor: Double, cantidad: Int, metodo: String, aprobado: Bool){
        
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ingresaPedido><Pedido>";
        
        mensajeEnviado += "<aprobado>"+String(aprobado)+"</aprobado>";
        mensajeEnviado += "<cantidad>"+String(cantidad)+"</cantidad>";
        mensajeEnviado += "<fechaEntrega>"+fechaEntrega+"</fechaEntrega>";
        mensajeEnviado += "<fechaPedido>"+fechaPedido+"</fechaPedido>";
        mensajeEnviado += "<horaEntrega>"+horaEntrega+"</horaEntrega>";
        mensajeEnviado += "<idPedido>?</idPedido>";
        mensajeEnviado += "<padre><idPadre>"+String(idPadre.id!)+"</idPadre>";
        mensajeEnviado += "<terminoFecha>"+idPadre.terminoFecha!+"</terminoFecha></padre>";
        mensajeEnviado += "<valor>"+String(valor)+"</valor>";
        mensajeEnviado += "<metodo>"+metodo+"</metodo>";
        
        mensajeEnviado += "</Pedido></enp:ingresaPedido></soapenv:Body></soapenv:Envelope>";
        
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
                print("ID: ", self.id);
                print("idPadre: ", idPadre.id);
                print("fecha pedido: ", fechaPedido);
                print("fecha entrega: ", fechaEntrega);
                print("hora entrega: ", horaEntrega);
                print("valor: ", valor);
                print("cantidad: ", cantidad);
                print("método: ", metodo);
                let pedido = Pedido(id: Int(self.id), idPadre: idPadre.id!, fechaPedido: fechaPedido, fechaEntrega: fechaEntrega, horaEntrega: horaEntrega, valor: valor, cantidad: cantidad, metodo: metodo, entregado: false, cancelado: false);
                print("idpedido: ", pedido.id);
                
                let subeTipo = SubeTipoLonchera();
                subeTipo.subeListaTipos(DatosB.cont.listaLoncheras, padre: idPadre, pedido: pedido);
                DatosB.cont.datosPadre.boton.enabled=true;
                DatosB.cont.datosPadre.idReferencia = self.idReferencia;
                DatosB.cont.datosPadre.debita2();
                DatosC.contenedor.pedido = pedido;
            });
            
        })
        
        task.resume();
    }
    
    var bid = false;
    var id:String!;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("listaSaludResponse"){
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
    
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bid){
            bid=false;
            id=string;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            idReferencia = Int(id);
            //print("idPedido: ", self.id);
        }
    }
    
    
}
