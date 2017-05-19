//
//  CargaInicial.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaCajas: NSObject ,NSURLConnectionDelegate, XMLParserDelegate{
    
    var objs=[Caja]();
    var mensajeEnviado:String="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaCajaPredeterminadaEntity/></soapenv:Body></soapenv:Envelope>";
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    func CargaCajas(_ Plogin: LoginView){
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
        lobj_Request.addValue("\"listaCajasEntity\"", forHTTPHeaderField: "SOAPAction")
        
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
            self.parser.parse()
            
            DispatchQueue.main.async(execute: {
                print("Consumo Cajas");
                //print("aprueba: ");
                
                Plogin.pasa2();
                lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
                }
            );
            //sender.enabled=true;
        })
        
        task.resume()
        
    }
    
    var id:Int?;
    var Nombre="";
    var Color: String?;
    
    var flagID=false;
    var flagNombre=false;
    var flagColor=false;
    
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element=elementName as NSString;
        if(elementName as NSString).isEqual(to: "listaCajaPredeterminadaEntityResponse"){
            estado=NSMutableString();
            estado="";
        }
        
        switch (elementName as String) {
            case "idCaja":
                flagID=true;
                break;
            case "color":
                flagColor=true;
                break;
            case "nombre":
                
                flagNombre=true;
                break;
            default:
                break;
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //print("etiqueta: ", element);
        //print("texto:: ", string);
        if(flagID){
            id=Int(string)!;
            flagID=false;
        }
        if(flagColor){
            /*
            let RGB=string.componentsSeparatedByString(",");
            let rojo:Float=(1/255)*Float(RGB[0])!;
            let verde:Float=(1/255)*Float(RGB[1])!;
            let azul:Float=(1/255)*Float(RGB[2])!;
            Color=UIColor.init(colorLiteralRed: rojo, green: verde, blue: azul, alpha: 1);
            flagColor=false;
            */
            //print("Color: ", string);
            Color=string;
            flagColor=false;
        }
        if(flagNombre){
            Nombre+=string;
            //print("NOmbre Caja: ", string);
            //flagNombre=false;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("cierra: ", elementName)
        if(elementName == "nombre"){
            flagNombre=false;
            
        }
        if(elementName as NSString).isEqual(to: "return"){
                        var listaSecu = [Secuencia]();
            for secu in DatosC.contenedor.secuencia{
                if(secu.caja==id){
                    listaSecu.append(secu);
                }
            }
            let caja=Caja(id: id!, nombre: Nombre, color: Color!, secuencia: listaSecu);
            objs.append(caja);
            DatosC.contenedor.cajas.append(caja);
            //print("añade caja: ",caja.Color);
            print("añade caja: ",caja.Nombre);
            Nombre = "";
        }
    }
}
