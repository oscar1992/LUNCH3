//
//  CargaTInfo.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 6/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaTInfo: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    //MARK: Variables
    
    var objs=[Producto]();
    var mensajeEnviado:String="";
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var prod:Producto?;

    //MARK: Consulta
    
    func CargaTInfo(prody: Producto){
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/adminEndpoint"
        
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        let session = NSURLSession.sharedSession()
        let _: NSError?
        
        self.prod=prody;
        //print("ID: ",prody.id);
        let idd:Int=prody.id!;
        mensajeEnviado="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:infoPorProducto><idProducto>"+String(idd)+"</idProducto></enp:infoPorProducto></soapenv:Body></soapenv:Envelope>";
        
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = mensajeEnviado.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"listaProductoEntity\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            
            if(data == nil){
                print("NULOOOO en TInfo");
            }else{
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
                //print(self.resp)
                self.parser=NSXMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse()
            }
            
            dispatch_async(dispatch_get_main_queue(),{
                lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
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
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        
        element=elementName;
        
        
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
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
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
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqualToString("return"){
            let tInfo = TipoInfo(id: id!, tipo: tipoNombre!, valor: valor!, idProducto: idProducto!);
            prod!.listaDatos.append(tInfo);
            //print("----------------");
        }
    }
}