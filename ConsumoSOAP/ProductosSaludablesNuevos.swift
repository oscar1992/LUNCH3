//
//  ProductosSaludablesNuevos.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 12/01/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class ProductosSaludablesNuevos: NSObject ,NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var mensajeEnviado:String!;
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var task: NSURLSessionDataTask!;
    var profundidad = 0;
    var productosSaludNuevos = [ProductoSaludable]();
    var cIni:CargaInicial3!;
    
    init(ids: [Int], fechas: [NSDate], cInicial: CargaInicial3){
        mensajeEnviado = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:productosSNuevos>";
        var p = 0;
        for id in ids{
            mensajeEnviado.appendContentsOf("<ids>"+String(id)+"</ids>");
            mensajeEnviado.appendContentsOf("<fecha>"+String(fechas[p])+"</fecha>");
            p += 1;
        }
        
        mensajeEnviado.appendContentsOf("</enp:productosSNuevos></soapenv:Body></soapenv:Envelope>");
        //print("Mensaje Enviado: ", mensajeEnviado);
        super.init();
        self.consulta();
        self.cIni=cInicial;
    }
    
    func consulta(){
        //msgInicia();
        print("Inicia Producto-Salud");
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint";
        
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
                print("NULOOOO en Producto-SaludNuevo");
            }else{
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                //print("Body: \(strData)")
                
                self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
                self.parser=NSXMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
                dispatch_async(dispatch_get_main_queue(),{
                    if(nulo && self.profundidad<2){
                        lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
                        self.profundidad += 1;
                        self.consulta();
                    }else if(nulo && self.profundidad>=2){
                        //Se murio
                    }else{
                        //Fin OK
                        print("CantidadProductos Nuevos: ", self.productosSaludNuevos.count);
                        self.cIni.cambiaProductosSaludablesNuevos(self.productosSaludNuevos);
                    }
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
    var ultimaActualizacion: NSDate!;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("listaSaludResponse"){
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
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bid){
            id=Int(string);
            bid=false;
        }
        if(bprodu){
            let idp=Int(string);
            print("Prod in saluWS: ", DatosC.contenedor.productos.count);
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
            print("Salu tama: ", DatosB.cont.saludables.count);
            for salu in DatosB.cont.saludables{
                print("idS: ", idS, "item salu: ", salu.idSalud);
                if(salu.idSalud==idS){
                    self.salu=salu;
                }else{
                    print("vacio: ", salu);
                }
            }
            bsalu=false;
        }
        if(bUltimaActualizacion){
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat="yyyy-MM-dd'T'hh:mm:ss.SSSZZ";
            ultimaActualizacion = dateFormatter.dateFromString(string);
        }
        
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            print("saluWS: ", self.produ.nombre);
            //print("ultima: ", ultimaActualizacion);
            let prodSalud=ProductoSaludable(id: id, salu: salu, produ: produ, ultimaActualizacion: ultimaActualizacion);
            //print("ProdSa: ", prodSalud.produ.nombre);
            productosSaludNuevos.append(prodSalud);
        }
    }
    
   
}
