//
//  ConsultaNinos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 25/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class ConsultaNinos: NSObject , NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString();
    var task: URLSessionDataTask!;
    var profundidad = 0;
        
    func consulta(_ Plogin: LoginView, aprueba: Bool){
        let padre = DatosD.contenedor.padre;
        //print("pp:", padre.id);
        let mensajeEnviado:String
        var pasa = false;
        if(padre.id != nil){
            pasa=true;
            mensajeEnviado = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ninosPorPadre><padre><contrasena></contrasena><direccion></direccion><email></email><idPadre>"+String(padre.id!)+"</idPadre><nombre></nombre><numeroconfirmacion></numeroconfirmacion><primeravez></primeravez><telefono></telefono></padre></enp:ninosPorPadre></soapenv:Body></soapenv:Envelope>"
        }else{
            
            mensajeEnviado = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ninosPorPadre><padre><contrasena></contrasena><direccion></direccion><email></email><idPadre>0</idPadre><nombre></nombre><numeroconfirmacion></numeroconfirmacion><primeravez></primeravez><telefono></telefono></padre></enp:ninosPorPadre></soapenv:Body></soapenv:Envelope>"
        }
        
        
        
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
            var nulo = false;
            if(data == nil){
                print("NULOOOO en consulta Ninos");
                nulo = true;
            }else{
                //print(self.resp)
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
                self.consume(Plogin);
                //Plogin.desbloquea();
            }
            DispatchQueue.main.async(execute: {
                if(nulo && self.profundidad<2){
                    self.profundidad += 1;
                    self.task.cancel();
                    self.consulta(Plogin, aprueba: aprueba);
                }else if(self.profundidad>=2 && nulo){
                    self.msgDesconexion();
                }else{
                    
                }
                lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
            });
            
        })
        
        task.resume();
        
        //print("Consulta Hijos :",pasa);
        
        
    }
    
    //MARK: Delegados + Atributos Ninos
    
    var Bid=false;
    var Bnombre=false;
    var Bfecha=false;
    var Bpadre=false;
    var Bgenero=false;
    
    var id = 0;
    var nombre=String();
    var fechaNaci=Date()
    var padre=Int();
    var genero=String();
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName as NSString;
        //print("ETIQUETA: ",element);
        if(elementName as NSString).isEqual(to: "ninosPorPadreResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch (elementName){
            
            case "idNino":
                Bid=true;
                break;
            case "nombreNino":
                Bnombre=true;
                break;
            case "genero":
                Bgenero=true;
                break;
            case "id":
                Bpadre=true;
                break;
            case "fechaNacimineto":
                Bfecha=true;
                break;
            default:
                break;
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if(Bid){
            id=Int(string)!;
            Bid=false;
        }
        if(Bnombre){
            nombre=string;
            Bnombre=false;
        }
        if(Bgenero){
            genero=string;
            Bgenero=false;
        }
        if(Bpadre){
            padre = Int(string)!;
            Bpadre=false;
        }
        if(Bfecha){
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd";
            
            let ss=(string as NSString).substring(with: NSRange(location: 0, length: 10));
            //print("ff:", ss);
            let fecha=dateFormatter.date(from: ss);
            //print("fff", fecha);
            fechaNaci=fecha!;
            Bfecha=false;
        }
        //print("dat: ",string);
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            if(id != nil){
                //print("trae");
                let nino=Ninos(id: id, nombre: nombre, fechaN: fechaNaci, padre: padre, genero: genero);
                DatosD.contenedor.ninos.append(nino);
                
            }
        }
    }
    
    func consume(_ Plogin: LoginView){
        //let cargaI=ConsultaProductos();
        //let cargaII=CargaTItems();
        let cargaIII=CargaSecuencia();
        //let cargaIV=CargaCajas();
        let cargaV=ConsultaCatergorias();
        let cargaVI=CargaEnvio();
        
        
        
        //let cargaVI=CargaFavoritos();
        //print("cargs")
        //cargaI.consulta();
        //cargaII.CargaTItems();
        cargaIII.CargaSecuencia();
        //cargaIV.CargaCajas(Plogin);
        cargaV.consulta();
        cargaVI.cargaEnvio();
        
        
        //cargaVI.consulta(DatosD.contenedor.padre.id);
        
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
