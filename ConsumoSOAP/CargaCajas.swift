//
//  CargaInicial.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaCajas: NSObject ,NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var objs=[Caja]();
    var mensajeEnviado:String="<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaCajaPredeterminadaEntity/></soapenv:Body></soapenv:Envelope>";
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    func CargaCajas(Plogin: LoginView){
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
        lobj_Request.addValue("\"listaCajasEntity\"", forHTTPHeaderField: "SOAPAction")
        
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
            self.parser.parse()
            
            dispatch_async(dispatch_get_main_queue(),{
                print("Consumo Cajas");
                //print("aprueba: ");
                
                Plogin.pasa();
                
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
    
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element=elementName;
        if(elementName as NSString).isEqualToString("listaCajaPredeterminadaEntityResponse"){
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
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
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
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("cierra: ", elementName)
        if(elementName == "nombre"){
            flagNombre=false;
            
        }
        if(elementName as NSString).isEqualToString("return"){
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
            //print("añade caja: ",caja.Nombre);
            Nombre = "";
        }
    }
}