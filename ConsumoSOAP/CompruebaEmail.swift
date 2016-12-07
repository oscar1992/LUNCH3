//
//  CompruebaEmail.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 4/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CompruebaEmail: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate {
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    //var msg:UIView!;
    
    func Comprueba(email: String, padre: CreaUsuario?, restaura: PideRestauracion?) {
        if(padre != nil){
            
            padre!.bot.enabled=false;
        }
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:validaEmail><email>"+email+"</email></enp:validaEmail></soapenv:Body></soapenv:Envelope>";
        print("Mensaje Enviado: ", mensajeEnviado);
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
            if(response == nil){
                    let ancho = DatosB.cont.loginView .view.frame.width*0.8;
                    let alto = DatosB.cont.loginView.view.frame.height*0.4;
                    let OX = (DatosB.cont.loginView.view.frame.width/2)-(ancho/2);
                    let OY = (DatosB.cont.loginView.view.frame.height/2)-(alto/2);
                    let frameMens = CGRectMake(OX, OY, ancho, alto);
                    let msg = MensajeCrea(frame: frameMens, msg: "Error de conexión");
                    DatosB.cont.olvida1.view.addSubview(msg);
                    msg.iniciaTimer();
                    //_ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(CompruebaEmail.cierra), userInfo: nil, repeats: false);
                    print("agrega?");
                
            }else{
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
                
                print("Body: \(strData)")
                
                if error != nil
                {
                    print("Error: " + error!.description)
                }
                //print(self.resp)
                
                self.parser=NSXMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
                dispatch_async(dispatch_get_main_queue(),{
                    if(self.valida=="true"){
                        print("Existe");
                        if(padre != nil){
                            padre!.msgUsuarioExitoso("Este usuario ya se encuentra creado", adv: false);
                            padre!.emailExistente=true;
                            padre!.bot.enabled=true;
                        }
                        if(restaura != nil){
                            restaura!.activa(email);
                        }
                    }else{
                        if(padre != nil){
                            padre!.emailExistente=false;
                            padre!.emailValido=true;
                            padre!.bot.enabled=true;
                            padre?.sube();
                        }
                        
                        print("Correo Ok");
                        
                    }
                });
            }
            
            
            
        })
        
        task.resume();
    }
    
    
    var bpp = true;
    var valida:String!;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName as NSString).isEqualToString("validaEmailResponse"){
            estado=NSMutableString();
            estado="";
        }
        print("ele: ", elementName);
        switch(elementName as NSString){
        case "return":
            bpp=true;
            break;
        default:
            break;
        }
    }
    
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if(bpp){
            bpp=false;
            valida=string;
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName == "return"){
            print("id: ", self.valida);
        }
    }
  
}