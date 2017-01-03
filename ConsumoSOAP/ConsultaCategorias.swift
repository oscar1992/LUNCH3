//
//  ConsultaCategorias.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 7/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class ConsultaCatergorias: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate {
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var profundidad = 0;
    var task : NSURLSessionDataTask!;
    
    func consulta(){
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaCategoriaEntity/></soapenv:Body></soapenv:Envelope>"
        
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
        
        task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in
            var nulo = false;
            if(data == nil){
                nulo = true;
                print("Nulo en Categorias");
            }else{
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
                self.parser=NSXMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
            }
            dispatch_async(dispatch_get_main_queue(),{
                if(nulo) && self.profundidad<2{
                    self.profundidad += 1;
                    self.task.cancel();
                    self.consulta();
                }else if(nulo && self.profundidad>=2){
                    self.msgDesconexion();
                }
                print("Carga Categorias");
                lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
            });
        })
        
        task.resume();
    }
    
    var idCategoria = false;
    var nombreCategoria = false;
    var bTipo = false;
    
    var categoria : Int?;
    var nombre : String?;
    var tipo : Int = -1;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("listaCategoriaEntityResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
            case "idCategoria":
                idCategoria = true;
                break;
            case "nombreCategoria":
                nombreCategoria = true;
                break;
            case "tipo":
                bTipo = true;
                break;
        default:
            break;
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(idCategoria){
            categoria = Int(string);
            idCategoria = false;
        }
        if(nombreCategoria){
            nombre = string;
            nombreCategoria = false;
        }
        if(bTipo){
            //print("nn: ", string);
            tipo = Int(string)!;
            bTipo = false;
        }
        
        //print("dd: ",string);
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if(elementName == "return"){
            /*
            print("----------------");
            print("Cat", categoria);
            print("Cat", nombre);
            print("tipo", tipo);
            print("----------------");
            */
            let cat = Categoria(id: categoria!, nombre: nombre!, tipo: tipo);
            DatosD.contenedor.categorias.append(cat);
            
        }
    }
    
    func msgDesconexion(){
        let vista = DatosB.cont.loginView;
        let ancho = vista.view.frame.width*0.8;
        let alto = vista.view.frame.height*0.4;
        let OX = (vista.view.frame.width/2)-(ancho/2);
        let OY = (vista.view.frame.height/2)-(alto/2);
        let frameMensaje = CGRectMake(OX, OY, ancho, alto);
        let mensaje = MensajeConexion(frame: frameMensaje, msg: nil);
        vista.view.addSubview(mensaje);
        mensaje.layer.zPosition=5;
        vista.view.bringSubviewToFront(mensaje);
    }
}
