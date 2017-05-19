//
//  CargaTags2.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 5/12/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaTags2: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var task: URLSessionDataTask!;
    var profundidad = 0;
    
    func consulta(_ cInicial: CargaInicial){
        msgInicia();
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaTags/></soapenv:Body></soapenv:Envelope>";
        
        //print("Mensaje: ", mensajeEnviado);
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/adminEndpoint"
        
        let lobj_Request = NSMutableURLRequest(url: URL(string: is_URL)!)
        let session = URLSession.shared
        let _: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = mensajeEnviado.data(using: String.Encoding.utf8)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"tagsPorProducto\"", forHTTPHeaderField: "SOAPAction")
        task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            self.task.priority=1.0;
            //print("Response: \(response)")
            var nulo = false;
            if(data == nil){
                print("NULOOOO en Tags Completos");
                self.task.cancel();
                nulo = true;
            }else{
                //print("Inicia Tags: ", self.produndidad);
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                //print("envia: ", mensajeEnviado);
                //print("Body: \(strData)")
                
                //print(self.resp)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
            }
            DispatchQueue.main.async(execute: {
                if(nulo && self.profundidad<2){
                    print("Err tags: Profundidad: ", self.profundidad)
                    self.profundidad += 1;
                    self.consulta(cInicial);
                }else if(nulo && self.profundidad>=2){
                    self.msgDesconexion();
                }else{
                    self.sumaBarra();
                    print("Carga Tags Completos");
                    let cargaI2 = CargaInicial2(cInicial: cInicial);
                    cargaI2.guarda(DatosD.contenedor.tags, tipo: Tag.self);
                }
                
                //print("tama Prods?: ", DatosC.contenedor.productos.count);
                
            });
            
        });
        task.resume();
    }
    
    var idTag=false;
    var nombreTag=false;
    var idProducto=false;
    
    var idt:Int?;
    var nombre:String?;
    var producto:Int?;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if(elementName as NSString).isEqual(to: "listaTagsResponse"){
            estado=NSMutableString();
            estado="";
        }
        //print("estado: ", estado);
        switch(elementName as NSString){
        case "idTag":
            idTag=true;
            break;
        case "nombreTag":
            nombreTag=true;
            break;
        case "idProducto":
            idProducto=true;
            break;
        default:
            break;
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(idTag){
            idt=Int(string);
            idTag=false;
        }
        if(nombreTag){
            //print("nombre", string);
            nombre=string;
            nombreTag=false;
        }
        if(idProducto){
            producto=Int(string);
            idProducto=false;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print(" r. ",elementName);
        if(elementName == "nombreTag"){
            
        }
        if(elementName == "return"){
            
            if(idt != nil){
                //print("nn tag: ", nombre);
                //print("idt:", idt)
                let tag = Tag(id: idt!, nombreTag: nombre!, idProducto: producto!);
                DatosD.contenedor.tags.append(tag);
                
                
            }
            
        }
    }
    
    func msgInicia(){
        let vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            vista.iniciamsg();
            vista.texto?.text="Inicia Carga Etiquetas";
        }
    }
    
    func sumaBarra(){
        let vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            vista.barra.progress = vista.barra.progress + 0.02;
        }
    }
    
    func msgDesconexion(){
        let vista = DatosB.cont.loginView;
        
        let ancho = vista.view.frame.width*0.8;
        let alto = vista.view.frame.height*0.4;
        let OX = (vista.view.frame.width/2)-(ancho/2);
        let OY = (vista.view.frame.height/2)-(alto/2);
        let frameMensaje = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let mensaje = MensajeConexion(frame: frameMensaje, msg: nil);
        vista.view.addSubview(mensaje);
        mensaje.layer.zPosition=5;
        vista.view.bringSubview(toFront: mensaje);
    }
}
