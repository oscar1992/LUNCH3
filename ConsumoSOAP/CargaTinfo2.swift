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
    var profundidad = 0;
    
    func cargaInformacion(log: LoginView, cInicial: CargaInicial){
        msgInicia();
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
            self.task.priority=1.0;
            var nulo = false;
            if(data == nil){
                print("NULOOOO en Carga Tipo Info: ", self.profundidad);
                
                nulo = true;
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
                if(nulo && self.profundidad<2){
                    self.task.cancel();
                    self.profundidad += 1;
                    self.cargaInformacion(log, cInicial: cInicial);
                }else if(nulo && self.profundidad>=2){
                    self.msgDesconexion();
                }else{
                    self.sumaBarra();
                    print("Carga Informacion Nutricional");
                    let cargaI2 = CargaInicial2(cInicial: cInicial);
                    cargaI2.guarda(DatosB.cont.listaTInfo, tipo: TipoInfo.self);
                    self.añadeInfo();
                    //log.pasa2();
                    //log.vista.removeFromSuperview();
                }
                
                
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
            //print("---------------- tipoinfo: ", DatosB.cont.listaTInfo.count);
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
    
    func msgInicia(){
        let vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            if(vista.vista==nil){
                vista.iniciamsg();
            }
            vista.texto?.text="Inicia Carga Info";
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
        let frameMensaje = CGRectMake(OX, OY, ancho, alto);
        let mensaje = MensajeConexion(frame: frameMensaje, msg: nil);
        vista.view.addSubview(mensaje);
        mensaje.layer.zPosition=5;
        vista.view.bringSubviewToFront(mensaje);
    }
}
