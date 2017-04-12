//
//  CargaPedidos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaPedidos: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString();
    var padre: Padre!;
    var pedidosN=[Pedido]();
    var pedidosE=[Pedido]();
    
    func cargaPedidos(padre: Padre){
        self.padre=padre;
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:pedidosPorPadre>";
        
        mensajeEnviado += "<idPadre>"+String(padre.id!)+"</idPadre>";
        
        mensajeEnviado += "</enp:pedidosPorPadre></soapenv:Body></soapenv:Envelope>";
        
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
        
        //print("mensg: ", mensajeEnviado);
        
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
                print("cargaPedidos");
                if(!self.pedidosE.isEmpty){
                    DatosB.cont.historial.actuaScroll2(self.pedidosE);
                }
                if(!self.pedidosN.isEmpty){
                    DatosB.cont.historial.actuaScroll1(self.pedidosN);
                }
                
                
            });
            
        })
        
        task.resume();
    }
    
    var id: Int!;
    var idPadre:Int!;
    var fechaPedido:String!;
    var fechaEntrega:String!;
    var horaEntrega:String!;
    var valor:Double!;
    var cantidad:Int!;
    var metodo: String!;
    var entregado: Bool!;
    var cancelado: Bool!;
    
    var bid = false;
    var bidPadre = false;
    var bfechaPedido = false;
    var bfechaEntrega = false;
    var bhoraEntrega = false;
    var bvalor = false;
    var bcantidad = false;
    var bmetodo = false;
    var bentregado = false;
    var bcancelado = false;
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case "cantidad":
            bcantidad = true;
            break;
        case "entregado":
            bentregado=true;
            break;
        case "fechaEntrega":
            bfechaEntrega=true;
            break;
        case "fechaPedido":
            bfechaPedido=true;
            break;
        case "horaEntrega":
            bhoraEntrega=true;
            break;
        case "idPedido":
            bid=true;
            break;
        case "valor":
            bvalor=true;
            break;
        case "metodo":
            bmetodo=true;
            break;
        case "cancelado":
            bcancelado=true;
            break;
        default:
            break;
        }
    }
    
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bcantidad){
            cantidad = Int(string);
            bcantidad = false;
        }
        if(bentregado){
            if(string == "true"){
                entregado=true;
            }else{
                entregado=false;
            }
            bentregado = false;
        }
        if(bfechaEntrega){
            fechaEntrega=string;
            bfechaEntrega = false;
        }
        if(bfechaPedido){
            fechaPedido=string;
            bfechaPedido = false;
        }
        if(bhoraEntrega){
            horaEntrega=string;
            bhoraEntrega = false;
        }
        if(bid){
            id=Int(string);
            //print("IDPED: ", id);
            bid = false;
        }
        if(bvalor){
            valor=Double(string);
            bvalor = false;
        }
        if(bmetodo){
            metodo=string;
            bmetodo = false;
        }
        if(bcancelado){
            if(string == "true"){
                cancelado=true;
            }else{
                cancelado=false;
            }
            bcancelado=false;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            let pedido = Pedido(id: id, idPadre: self.padre.id!, fechaPedido: fechaPedido, fechaEntrega: fechaEntrega, horaEntrega: horaEntrega, valor: valor, cantidad: cantidad, metodo: metodo, entregado: entregado, cancelado: cancelado);
            print("ent: ", pedido.entregado);
            if(pedido.entregado==true){
                pedidosE.append(pedido);
            }else{
                pedidosN.append(pedido);
            }
            
        }
    }
}
