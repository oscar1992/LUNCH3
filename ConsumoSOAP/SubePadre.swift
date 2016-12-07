//
//  SubePadre.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//



import UIKit

class SubePadre: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    
    func subePadre(nombre: String, email: String, pass: String, genero: String, foto: NSData?, padre:CreaUsuario){
        padre.bot.enabled=false;
        let time = tiempoActual();
        //print("TT: ", time);
        
        var mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ingresaPadre><Padre><contrasena>"+pass+"</contrasena> <direccion>--</direccion><email>"+email+"</email><idPadre></idPadre> <nombre>"+nombre+"</nombre> <numeroconfirmacion></numeroconfirmacion><primeravez>false</primeravez><telefono>--</telefono><termino>true</termino><terminoFecha>"+time+"</terminoFecha>";
        if(foto != nil){
            var datosF = foto!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0));
            mensajeEnviado += "<imagen>"+datosF+"</imagen>";
        }
        
        mensajeEnviado += "<genero>"+genero+"</genero><termino>true</termino></Padre></enp:ingresaPadre></soapenv:Body></soapenv:Envelope>";
        
        //print("envia: ", mensajeEnviado);
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
                
                if(self.id != nil){
                    print("subida con éxito");
                    var gen:String;
                    if(genero=="M"){
                        gen="o";
                    }else{
                        gen="a";
                    }
                    padre.msgUsuarioExitoso("Bienvenid"+gen+" a La Lonchera !", adv: true);
                    
                }
                padre.bot.enabled=true;
            });
            
        })
        
        task.resume();
    }
    
    var bid = false;
    var id:String!;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("listaSaludResponse"){
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
    
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bid){
            bid=false;
            id=string;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            print("id: ", self.id);
        }
    }
    
    func tiempoActual()->String{
        //let calendar = NSCalendar.currentCalendar();
        let date = NSDate();
        let formateador:NSDateFormatter=NSDateFormatter();
        formateador.locale = NSLocale.init(localeIdentifier: "es_CO");
        formateador.dateFormat="yyyy-MM-dd hh:mm:ss-";
        return  formateador.stringFromDate(date)+"04";
    }
}