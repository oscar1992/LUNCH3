//
//  CargaItemsFavoritos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 8/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaItemsFavoritos: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate {
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var items = [TItems]();
    var productos = [Producto]();
    
    
    
    
    
    
    func carga(cInicial: CargaInicial){
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaItemsFavoritos/></soapenv:Body></soapenv:Envelope>";
        //print("Envia: ", mensajeEnviado);
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint"
        
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
            
            //print("ItemF: \(strData)")
            
            if error != nil
            {
                print("Error: " + error!.description)
            }
            //print(self.resp)
            self.parser=NSXMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            dispatch_async(dispatch_get_main_queue(),{
                //self.carg!.pideItems(self.items);
                //DatosB.cont.home2.predeterminadas.cargaSaludables();//XXXXXXXXXXX Iniciar en otro lado
                print("Carga Items Favo");
                let cargaI2 = CargaInicial2(cInicial: cInicial);
                //cargaI2.guarda(DatosB.cont.favoritos, tipo: Favoritos.self);
                //cargaI2.guarda(DatosB.cont.itemsFavo, tipo: TItems.self);
                lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
            });
        })
        
        task.resume();

        
    }
    
    
    var bId = false;
    var bpadre = false;
    var bproducto = false;
    
    var id : Int?;
    var padre : Int?;
    var producto : Int?;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element=elementName;
        
        if(elementName as NSString).isEqualToString("loginResponse"){
            estado=NSMutableString();
            estado="";
        }
        
        switch (elementName as NSString) {
            case "idNumeroLonchera":
                bId = true;
                break;
            case "idPadre":
                bpadre = true;
                break;
            case "idProducto":
                bproducto = true;
                break;
            default:
                break;
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bId){
            id = Int(string);
            //print("idLon: ",id);
            bId = false;
        }
        if(bpadre){
            padre = Int(string);
            bpadre = false;
        }
        if(bproducto){
            producto = Int(string);
            bproducto = false;
        }
    }
    
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            
            //print("UUU: ", DatosC.contenedor.productos.count);
            for prod in DatosC.contenedor.productos{
                //print("prod.id: ", prod.id, "producto: ", producto);
                if(prod.id == producto){
                    let item = TItems(id: id!);
                    item.productos = prod;
                    productos.append(prod);
                    items.append(item);
                    //print("añade item favorito");
                    DatosB.cont.itemsFavo.append(item);
                    
                    
                    
                }
            }
        }
    }
}
