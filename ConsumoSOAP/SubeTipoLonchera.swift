//
//  SubeTipoLonchera.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 27/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class SubeTipoLonchera: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var tipo : [(Lonchera2, Int)]!;
    var sig = 0;
    var subeLista:SubeListaProds!;
    
    func subeListaTipos(_ tipo: [(Lonchera2, Int)], padre: Padre, pedido: Pedido){
        self.tipo=tipo;
        subeLista = SubeListaProds();
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv= 'http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp= 'http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ingresaTipoLonchera>";
        for lonTipo in tipo{
            mensajeEnviado += "<TipoLonchera>";
            mensajeEnviado += "<cantidad>"+String(lonTipo.1)+"</cantidad>";
            mensajeEnviado += "<idTipoLonchera>?</idTipoLonchera>";
            mensajeEnviado += "<nombreTipo>"+lonTipo.0.nombr!+"</nombreTipo>";
            mensajeEnviado += "<pedido>";
            mensajeEnviado += "<cantidad>"+String(pedido.cantidad)+"</cantidad>";
            mensajeEnviado += "<fechaEntrega>"+pedido.fechaEntrega+"</fechaEntrega>";
            mensajeEnviado += "<fechaPedido>"+pedido.fechaPedido+"</fechaPedido>";
            mensajeEnviado += "<horaEntrega>"+pedido.horaEntrega+"</horaEntrega>";
            mensajeEnviado += "<idPedido>"+String(pedido.id!)+"</idPedido>";
            mensajeEnviado += "<padre>";
            mensajeEnviado += "<contrasena>"+padre.pass!+"</contrasena>";
            mensajeEnviado += "<direccion>"+padre.direccion!+"</direccion>";
            mensajeEnviado += "<email>"+padre.direccion!+"</email>";
            //mensajeEnviado += "<genero>"+padre.+"</genero>";
            mensajeEnviado += "<idPadre>"+String(padre.id!)+"</idPadre>";
            mensajeEnviado += "<nombre>"+padre.nombre!+"</nombre>";
            mensajeEnviado += "<numeroconfirmacion>"+padre.numeroConfirmacion!+"</numeroconfirmacion>";
            mensajeEnviado += "<primeravez>"+String(describing: padre.primeraVez)+"</primeravez>";
            mensajeEnviado += "<telefono>"+padre.telefono!+"</telefono>";
            mensajeEnviado += "<termino>"+padre.telefono!+"</termino>";
            mensajeEnviado += "<terminoFecha>"+padre.terminoFecha!+"</terminoFecha>";
            mensajeEnviado += "<genero>"+padre.genero!+"</genero>";
            mensajeEnviado += "</padre>";
            mensajeEnviado += "<valor>"+String(pedido.valor)+"</valor>";
            mensajeEnviado += "</pedido></TipoLonchera>";
        }
        
        

        
        mensajeEnviado += "</enp:ingresaTipoLonchera></soapenv:Body></soapenv:Envelope>";
        
        print("envia TIPO: ", mensajeEnviado);
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
                print("Error: ", error!)
            }
            //print(self.resp)
            self.parser=XMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            DispatchQueue.main.async(execute: {
                //self.listaSiguiente();
                
                var p = 0;
                for lonTipo in tipo{
                    var prods = [Producto]();
                    for cas in lonTipo.0.casillas{
                        if(cas.elemeto != nil){
                            prods.append((cas.elemeto?.producto)!);
                            print("id: ",self.id[p],"Producto: ", cas.elemeto?.producto?.nombre);
                        }
                    }
                    self.subeLista.armaMensaje(prods, idTipo: self.id[p])
                    p += 1;
                }
                self.subeLista.subeLitsaProds(self);
                print("Tipo exito")
            });
            
        })
        
        task.resume();
    }
    
    var bid = false;
    var id=[Int]();
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqual(to: "listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case "return":
            bid=true;
            break;
        default:
            break;
        }
    }
    
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(bid){
            bid=false;
            self.id.append(Int(string)!);
            print("idTipo: ", string);
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            
            //print("idTipo: ", self.id);
        }
    }
    
 
}
