//
//  CargaTInfo.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 6/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaTInfo: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    //MARK: Variables
    
    
    var mensajeEnviado:String="";
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var prod:Producto?;

    //MARK: Consulta
    
    func CargaTInfo(_ prody: Producto, cini3: CargaInicial3){
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/adminEndpoint"
        
        let lobj_Request = NSMutableURLRequest(url: URL(string: is_URL)!)
        let session = URLSession.shared
        let _: NSError?
        
        self.prod=prody;
        //print("ID: ",prody.id);
        let idd:Int=prody.id!;
        mensajeEnviado="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:infoPorProducto><idProducto>"+String(idd)+"</idProducto></enp:infoPorProducto></soapenv:Body></soapenv:Envelope>";
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = mensajeEnviado.data(using: String.Encoding.utf8)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"listaProductoEntity\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            
            if(data == nil){
                print("NULOOOO en TInfo");
            }else{
                print("InfoItem nuevo: ", prody.nombre);
                
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                //print(self.resp)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse()
            }
            
            DispatchQueue.main.async(execute: {
                lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
                cini3.contadorHIlos += 1;
                print("Hilo Tinfo = ", cini3.contadorHIlos);
                if(cini3.contadorHIlos >= cini3.listaProductosSinImagen.count){
                    print("Iguales");
                    //cini3.guardaTInfo();
                }else{
                    print("Difiere HIlos: ", cini3.contadorHIlos," Llamados: ", cini3.listaProductosSinImagen.count);
                }
                //print("Carga Informacion de Productos");
            });
        })
        
        task.resume()
        //print("Carga TInfo: ",prod.nombre);
        
    }
    
    var flagid=false;
    var flagtipo=false;
    var flagValor=false;
    var flagIdproducto=false;
    
    var id:Int?;
    var idTinfo:Int?;
    var tipoNombre:String?;
    var valor:Float?;
    var idProducto:Int?;
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        
        element=elementName as NSString;
        
        
        switch (elementName as NSString){
            case "infoPorProductoResponse":
                estado=NSMutableString();
                estado="";
            break;
            
            case "tipoNombre":
                //print(element);
                flagtipo=true;
            break;
            
            case "idTinfo":
                //print(element);
                flagid=true;
            break;
            
            case "valor":
                flagValor=true;
            break;
            
            case "idProducto":
                flagIdproducto=true;
            break;
            
            case "":
            break;
            
            default:
            break;
        }

    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if(flagid){
            //print("Id: ",string);
            id=Int(string);
            flagid=false;
        }
        if(flagtipo){
            //print("Tipo: ",string);
            tipoNombre=string;
            flagtipo=false;
        }
        if(flagValor){
            //print("Valor: ",string);
            valor=Float(string);
            flagValor=false;
        }
        if(flagIdproducto){
            //print("IDProducto: ",string);
            idProducto=Int(string);
            flagIdproducto=false;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "return"){
            let tInfo = TipoInfo(id: id!, tipo: tipoNombre!, valor: valor!, idProducto: idProducto!);
            //prod!.listaDatos.append(tInfo);
            DatosB.cont.listaTInfoNuevos.append(tInfo);
            //print("----------------");
        }
    }
}
