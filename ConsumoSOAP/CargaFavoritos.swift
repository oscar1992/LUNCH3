//
//  CargaFavoritos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 8/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaFavoritos: NSObject , NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var ids = [Int]();
    var pred: Predeterminadas!;
    var secus = [Secuencia]();
    let color = "AZUL";
    var caja = Caja();
    
    func consulta(_ idPadre: Int!, cInicial: CargaInicial){
        
        let idP = String(idPadre);
        //print("idp: ", idP);
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:listaFavoritasPorPadre><padre>"+idP+"</padre></enp:listaFavoritasPorPadre></soapenv:Body></soapenv:Envelope>";
        
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
            //print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
            
            //print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: ",  error!)
            }
            //print(self.resp)
            self.parser=XMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            DispatchQueue.main.async(execute: {
                print("Upd Favoritas OK");
                
                let cargaFav = CargaItemsFavoritos();
                cargaFav.carga(cInicial);
                //let cargaI2 = CargaInicial2(cInicial: cInicial);
                
                
                lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
            });
            
            })
        
        task.resume();
    }
    
    var BidNumero = false;
    var Bnombre = false;
    
    var idNumero : Int?;
    var nombre : String?;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName as NSString;
        
        if(elementName as NSString).isEqual(to: "loginResponse"){
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
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
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
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            //DatosB.cont.itemsFavo.removeAll();
            let favorito = Favoritos(id: idNumero!, nombre: nombre!);
            
            
            //favorito.items=cargaFav.productos;
            DatosB.cont.favoritos.append(favorito);
            print("llena: ", nombre);
            ids.append(idNumero!);
            
        }
    }
    
    //Método que agrega los items favoritos encontradosen la base de datos
    func pideItems(_ items: [TItems]){
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
        //pred.añadeFavoritas();
        
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
