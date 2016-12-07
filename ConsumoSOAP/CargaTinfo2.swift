//
//  CargaTinfo2.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 6/12/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaTinfo2: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var task: NSURLSessionDataTask!;
    
    func cargaInformacion(log: LoginView){
        print("Inicia Info: ");
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaInformacionNutricionalEntity/></soapenv:Body></soapenv:Envelope>";
        
        //print("Mensaje: ", mensajeEnviado);
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/adminEndpoint"
        
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        let session = NSURLSession.sharedSession()
        let _: NSError?
        
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = mensajeEnviado.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"tagsPorProducto\"", forHTTPHeaderField: "SOAPAction")
        task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            if(data == nil){
                print("NULOOOO en Carga Tipo Info");
                self.task.cancel();
                
            }else{
                
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
                //print("envia: ", mensajeEnviado);
                //print("Body: \(strData)")
                
                //print(self.resp)
                self.parser=NSXMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
            }
            dispatch_async(dispatch_get_main_queue(),{
                print("Carga Informacion Nutricional");
                self.añadeInfo();
                log.pasa2();
                log.vista.removeFromSuperview();
                
                //print("tama Prods?: ", DatosC.contenedor.productos.count);
                
            });
            
        });
        task.resume();
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
            DatosB.cont.listaTInfo.append(tInfo);
            //print("----------------");
        }
    }
    
    func añadeInfo(){
        for prod in DatosC.contenedor.productos{
            for tInfo in DatosB.cont.listaTInfo{
                if(prod.id==tInfo.idProducto){
                    prod.listaDatos.append(tInfo);
                }
            }
        }
    }
    
    func totalProductosComletos()->Int{
        var ret = 0;
        for prod in DatosC.contenedor.productos{
            if(prod.imagen != nil){
                ret += 1;
            }
        }
        return ret;
    }
}
