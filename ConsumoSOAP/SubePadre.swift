//
//  SubePadre.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//



import UIKit

class SubePadre: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    func subePadre(_ nombre: String, email: String, pass: String, genero: String, foto: Data?, padre:CreaUsuario){
        padre.bot.isEnabled=false;
        let time = tiempoActual();
        //print("TT: ", time);
        
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ingresaPadre><Padre><contrasena>"+pass+"</contrasena> <direccion>--</direccion><email>"+email+"</email><idPadre></idPadre> <nombre>"+nombre+"</nombre> <numeroconfirmacion></numeroconfirmacion><primeravez>true</primeravez><telefono>--</telefono><termino>true</termino><terminoFecha>"+time+"</terminoFecha>";
        if(foto != nil){
            var datosF = foto!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0));
            mensajeEnviado += "<imagen>"+datosF+"</imagen>";
        }
        
        mensajeEnviado += "<genero>"+genero+"</genero><termino>true</termino></Padre></enp:ingresaPadre></soapenv:Body></soapenv:Envelope>";
        
        //print("envia: ", mensajeEnviado);
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
                print("Error: ", error!)
            }
            //print(self.resp)
            self.parser=XMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            DispatchQueue.main.async(execute: {
                
                if(self.id != nil){
                    print("subida con éxito");
                    var gen:String;
                    if(genero=="M"){
                        gen="o";
                    }else{
                        gen="o";
                    }
                    padre.msgUsuarioExitoso("Bienvenid"+gen+" a La Lonchera !", adv: true);
                    
                }
                padre.bot.isEnabled=true;
            });
            
        })
        
        task.resume();
    }
    
    var bid = false;
    var id:String!;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqual(to: "listaSaludResponse"){
            estado=NSMutableString();
            estado="";
        }
        switch(elementName as NSString){
            case "idPadre":
                bid=true;
                break;
            default:
                break;
        }
    }
    
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(bid){
            bid=false;
            id=string;
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            print("id: ", self.id);
        }
    }
    
    func tiempoActual()->String{
        //let calendar = NSCalendar.currentCalendar();
        let date = Date();
        let formateador:DateFormatter=DateFormatter();
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="yyyy-MM-dd hh:mm:ss-";
        return  formateador.string(from: date)+"04";
    }
}
