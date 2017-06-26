//
//  CargaProductoSalud.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaProductoSalud: NSObject ,NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var saluEnv:Saludable!
    var ultimo = false;
    var task: URLSessionDataTask!;
    var profundidad = 0;
    
   
    
    func cargaSaludables(_ cInicial: CargaInicial){
        msgInicia();
        print("Inicia Producto-Salud");
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaProductoSaludTodos/></soapenv:Body></soapenv:Envelope>";
        
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
        
        task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            var nulo = false;
            if(data == nil){
                nulo = true;
                print("NULOOOO en Prducto-Salud");
            }else{
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                
                //print("Body: \(strData)")
                
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
                DispatchQueue.main.async(execute: {
                    print("Fin Producto- Salud: ", nulo, "- ultimo: ",self.ultimo);
                    if(nulo && self.profundidad<2){
                        self.profundidad += 1;
                        self.task.cancel();
                        self.cargaSaludables(cInicial);
                    }else if(nulo && self.profundidad>=2){
                        self.msgDesconexion();
                    }else{
                        self.sumaBarra();
                            print("Carga ProductoSaludables OK");
                            let cargaI2 = CargaInicial2(cInicial: cInicial);
                            cargaI2.guarda(DatosB.cont.prodSaludables, tipo: ProductoSaludable.self);
                    }
                    
                    
                    lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
                });
            }
            
            
        })
        task.resume();
    }
    
    var bid=false;
    var bsalu=false;
    var bprodu=false;
    var bUltimaActualizacion=false;
    
    var id:Int!;
    var salu:Saludable!;
    var produ:Producto!;
    var ultimaActualizacion: Date!;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqual(to: "listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case "idProductosalud":
            bid=true;
            break;
        case "idProducto":
            bprodu=true;
            break;
        case "idSalud":
            bsalu=true;
            break;
        case "ultimaActualizacion":
            bUltimaActualizacion=true;
            break;
        default:
            break;
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(bid){
            id=Int(string);
            bid=false;
        }
        if(bprodu){
            let idp=Int(string);
            //print("Prod in saluWS: ", DatosC.contenedor.productos.count);
            for produ in DatosC.contenedor.productos{
                if(produ.id==idp){
                    print("produ: ", produ.nombre);
                    self.produ=produ;
                }
            }
            bprodu=false;
        }
        if(bsalu){
            let idS=Int(string);
            //print("Sau tama: ", DatosB.cont.saludables.count);
            for salu in DatosB.cont.saludables{
                //print("idS: ", idS, "item salu: ", salu.idSalud);
                if(salu.idSalud==idS){
                    self.salu=salu;
                }else{
                    //print("vacio: ", salu);
                }
            }
            bsalu=false;
        }
        if(bUltimaActualizacion){
            print("pre fecha: ", string);
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat="yyyy-MM-dd'T'hh:mm:ss.SSSZZ";
            ultimaActualizacion = dateFormatter.date(from: string);
            print("pre fecha2: ", ultimaActualizacion);
            bUltimaActualizacion = false;
        }
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            //print("saluWS: ", self.produ.nombre);
            print("fecha prsa: ", ultimaActualizacion);
            if(ultimaActualizacion == nil){
                ultimaActualizacion = NSDate() as Date!;
            }
            let prodSalud=ProductoSaludable(id: id, salu: salu, produ: produ, ultimaActualizacion: (ultimaActualizacion! as NSDate) as Date);
            //print("ProdSa: ", prodSalud.produ.nombre);
            DatosB.cont.prodSaludables.append(prodSalud);
        }
    }
    
    func msgInicia(){
        //print("carga tags");
        let vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            if(vista.vista==nil){
                vista.iniciamsg();
            }
            vista.texto?.text="Inicia Carga Producto-Saludable";
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
