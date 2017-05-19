//
//  EliminaFavoritos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 27/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class EliminaFavoritos: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var bot : UIButton?;
    var idCaja : Int!;
    
    func elimina(_ idCaja: Int){
        self.idCaja=idCaja;
        let idPadre=DatosD.contenedor.padre.id;
        self.bot?.isEnabled=false;
        
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:EliminaFavorito><idLonchera>"+String(idCaja)+"</idLonchera><idPadre>"+String(idPadre!)+"</idPadre></enp:EliminaFavorito></soapenv:Body></soapenv:Envelope>";
        print("MSG: ", mensajeEnviado);
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
                print("Error: " , error!)
            }
            //print(self.resp)
            self.parser=XMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            DispatchQueue.main.async(execute: {
                
                self.quitaDorada();
                
            });
            
        })
        
        task.resume();
    }
    
    var bRet = false;
    var eliminado = false;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element=elementName as NSString;
        
        if(elementName as NSString).isEqual(to: "loginResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
        case "return":
            bRet = true;
            break;
        default:
            break;
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(bRet){
            if(string == "true"){
                eliminado = true;
            }
            bRet = false;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    //Método que quita la estrella dorada si el borrado fue exitoso
    func quitaDorada(){
        //DatosB.cont.poneFondoTot(bot!, fondoStr: "BotonF", framePers: nil, identi: nil, scala: true);
        //DatosB.cont.favoritos.append(favorita);
        var p = 0;
        
        for favo in DatosB.cont.favoritos{
            if(favo.id == idCaja){
                DatosB.cont.favoritos.remove(at: p);
                /*
                var j = 0;
                for item in DatosB.cont.itemsFavo{
                    if(item.id == idCaja){
                        DatosB.cont.itemsFavo.removeAtIndex(j);
                        print("Remueve Item");
                    }
                    j += 1;
                }*/
                //favo.items.removeAll();
            }
            p += 1;
        }
        
        
        DatosB.cont.home2.lonchera.botfavo.isEnabled=true;
        DatosB.cont.home2.predeterminadas.cini=true;
        DatosB.cont.home2.predeterminadas.cargaSaludables();
        DatosB.cont.home2.lonchera.actualizaContador();

    }
}
