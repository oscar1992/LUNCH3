//
//  CargaSalud.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaSalud: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    func cargaSaludables(_ carga: CargaInicial){
        msgInicia();
        print("Inicia Carga Saludables");
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaSalud/></soapenv:Body></soapenv:Envelope>";
        
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
        lobj_Request.addValue("\"bool\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            if(data == nil){
                print("NULOOOO en saludables");
            }else{
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                
                //print("Body: \(strData)")
                
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
                DispatchQueue.main.async(execute: {
                    carga.cargaImagenes();
                    self.sumaBarra();
                    print("Carga Saludables OK");
                    //let cargaIt = CargaProductoSalud();
                    //cargaIt.cargaSaludables();
                    //Plogin.pasa2();
                    let cargaI2 = CargaInicial2(cInicial: carga);
                    cargaI2.guarda(DatosB.cont.saludables, tipo: Saludable.self);
                    if(DatosB.cont.loginView.aprueba==true){
                        //DatosB.cont.loginView.pasa2();
                    }else{
                        DatosB.cont.cargaProductos = true;
                    }
                    
                    
                    lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
                });
            }
            
            
        })
        task.resume();
    }
    
    var bidSalud = false;
    var bnombre = false;
    
    var idSalud:Int!;
    var nombre:String!;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqual(to: "listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        //print("prle: ", elementName);
        switch(elementName as NSString){
        case "idSalud":
            bidSalud=true;
            break;
        case "nombreSalud":
            bnombre=true;
            break;
        default:
            break;
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(bidSalud){
            idSalud = Int(string);
            bidSalud=false;
        }
        if(bnombre){
            nombre=string;
            bnombre=false;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("ele: ", elementName);
        if(elementName == "return"){
            //print("carga uno: ",idSalud);
            let salu = Saludable(idSalud: idSalud, nombre: nombre);
            DatosB.cont.saludables.append(salu);
            
            
        }
    }
    
    func msgInicia(){
        //print("carga tags");
        let vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            if(vista.vista==nil){
                vista.iniciamsg();
            }
            vista.texto?.text="Inicia Carga Cajas Saludables";
        }
    }
    
    func sumaBarra(){
        let vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            vista.barra.progress = vista.barra.progress + 0.02;
        }
    }
}
