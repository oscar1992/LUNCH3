//
//  CargaProductoSalud.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaProductoSalud: NSObject ,NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var saluEnv:Saludable!
    var ultimo = false;
    var task: NSURLSessionDataTask!;
    var profundidad = 0;
    
   
    
    func cargaSaludables(cInicial: CargaInicial){
        //msgInicia();
        print("Inicia Producto-Salud");
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaProductoSaludTodos/></soapenv:Body></soapenv:Envelope>";
        
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
                print("NULOOOO en Prducto-Salud");
            }else{
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                //print("Body: \(strData)")
                
                self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
                self.parser=NSXMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
                dispatch_async(dispatch_get_main_queue(),{
                    print("Fin Producto- Salud: ", nulo, "- ultimo: ",self.ultimo);
                    if(nulo && self.profundidad<2){
                        self.profundidad += 1;
                        self.task.cancel();
                        self.cargaSaludables(cInicial);
                    }else if(nulo && self.profundidad>=2){
                        self.msgDesconexion();
                    }else{
                        
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
            //print("Prod in saluWS: ", DatosC.contenedor.productos.count);
            for produ in DatosC.contenedor.productos{
                if(produ.id==idp){
                    //print("produ: ", produ.nombre);
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
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat="yyyy-MM-dd HH:mm:ss.SSS";
            ultimaActualizacion = NSDate();
        }
        
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            //print("saluWS: ", self.produ.nombre);
            let prodSalud=ProductoSaludable(id: id, salu: salu, produ: produ, ultimaActualizacion: ultimaActualizacion);
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
            //vista.texto?.text="Inicia Carga Producto-Saludable";
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
