//
//  CargaHoraEntrega.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 19/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaHoraEntrega: NSObject , NSURLConnectionDelegate, NSXMLParserDelegate{

    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()

    func cargaHorasEntrega(){
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaHora/></soapenv:Body></soapenv:Envelope>";
        //print("envia: ", mensajeEnviado);
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
                DatosB.cont.primeraVezCarrito=false;
                DatosB.cont.carrito.performSegueWithIdentifier("Datos", sender: nil);
                print("Carga HOras Envio OK");
                
            });
            
        })
        task.resume();
    }
    
    var bhoraf=false;
    var bhorai=false;
    var bidhora=false;
    var bidfecha=false;
    var horaf:String!;
    var horai:String!;
    var idHora:Int!;
    var idFecha:Int!;
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
            case "horaFinal":
                bhoraf=true;
            break;
            case "horaInicial":
                bhorai=true;
            break;
            case "idHora":
                bidhora=true;
            break;
            case "idFecha":
                bidfecha=true;
            break;
        default:
            break;
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bhoraf){
            bhoraf=false;
            horaf=string;
        }
        if(bhorai){
            bhorai=false;
            horai=string;
        }
        if(bidhora){
            bidhora=false;
            idHora=Int(string);
        }
        if(bidfecha){
            bidfecha=false;
            idFecha=Int(string);
            //print("idf: ", idFecha);
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            var fechaE : FechaEntrega!;
            //print("tama: ", DatosB.cont.FechasEntrega.count)
            for fechaENN in DatosB.cont.FechasEntrega{
                //print("idfe:",idFecha)
                //print("fechann",fechaENN.idFecha);
                if(idFecha==fechaENN.idFecha){
                    fechaE=fechaENN;
                }
            }
            //print("fech:", fechaE);
            let horaEnt=HoraEntrega(id: idHora, horaIni: horai, horaFin: horaf, fechaE: fechaE);
            DatosB.cont.HorasEntrega.append(horaEnt);
        }
    }
}
