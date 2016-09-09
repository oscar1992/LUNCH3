//
//  CargaFavoritos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 8/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaFavoritos: NSObject , NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var ids = [Int]();
    var pred: Predeterminadas!;
    var secus = [Secuencia]();
    let color = "AZUL";
    var caja = Caja();
    
    func consulta(idPadre: Int!){
        
        let idP = String(idPadre);
        //print("idp: ", idP);
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaFavoritasPorPadre><!--Optional:--><padre>"+idP+"</padre></enp:listaFavoritasPorPadre></soapenv:Body></soapenv:Envelope>";
        
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
                print("Upd Favoritas OK");
                
                
                
            });
            
            })
        
        task.resume();
    }
    
    var BidNumero = false;
    var Bnombre = false;
    
    var idNumero : Int?;
    var nombre : String?;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName;
        
        if(elementName as NSString).isEqualToString("loginResponse"){
            estado=NSMutableString();
            estado="";
        }
        
        switch(elementName as NSString){
            case "idNumeroLonchera":
                BidNumero = true;
                break;
            case "nombreNumero":
                Bnombre = true;
                break;
            
            default:
                break;
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(BidNumero){
            idNumero = Int(string);
            //print(idNumero);
            BidNumero = false;
        }
        if(Bnombre){
            nombre = string;
            Bnombre = false;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            DatosB.cont.itemsFavo.removeAll();
            let favorito = Favoritos(id: idNumero!, nombre: nombre!);
            let cargaFav = CargaItemsFavoritos(favo: favorito);
            cargaFav.carg=self;
            cargaFav.carga(DatosD.contenedor.padre.id);
            cargaFav.favo=favorito;
            //favorito.items=cargaFav.productos;
            DatosB.cont.favoritos.append(favorito);
            //print("llena: ", nombre);
            ids.append(idNumero!);
            
        }
    }
    
    //Método que agrega los items favoritos encontradosen la base de datos
    func pideItems(items: [TItems]){
        var i = 0;
        //print("secu: ", secus.count);
        for secu in secus{
            for item in items{
                if(secu.id == item.id){
                    //print("itt: ",item.productos?.nombre, "itt: ", item.id," in: ", secu.id);
                    secu.lista!.append(item);
                }
                
            }
            
        }
        if(secus.count == 0){
            //print("vacio");
            
        }else{
            //print("nuevo");
            let (nueva, cajaN) = (cajaNueva());
            
            if(nueva){
                //print("secu: ", secus.count);
                //print("Si en DatosC");
                caja = cajaN;
                caja.secuencia = secus;
                DatosD.contenedor.favOk = true;
            }else{
                DatosD.contenedor.favOk = false;
                //print("No en DatosC");
                caja = Caja(id: -2, nombre: "FAVORITAS", color: color, secuencia: secus);
            }

            
            
            
            DatosD.contenedor.favoritas = caja;
            i += 1;
        }
        //print("Llena");
        pred.añadeFavoritas();
        
    }
    
    //Método que evalua si no tiene caja de favoritas
    func cajaNueva()-> (Bool, Caja){
        var tiene = false;
        var cajaret = Caja();
        for caja in DatosC.contenedor.cajas{
            if (caja.id == -2){
                cajaret = caja;
                tiene = true;
            }else{
                
            }
        }
        return (tiene, cajaret);
    }
    
    
}
