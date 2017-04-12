//
//  ListCard.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 22/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class ListCard: NSObject, NSURLConnectionDelegate, UIWebViewDelegate{
    
    var vistaWeb: UIWebView!;
    
    var envia:String="";
    var aplicationCode : String!;
    var uid : String!;
    var email : String!;
    var sesionId : String!;
    var timeStamp : String!;
    var tarjetas = [TarjetaEntidad]();
    var vistaBase: UIView!;
    var boton = false;
    var boton2 : UIButton!;
    var vistaT: VistaTarjetas?;
    
    init(vistaBase: UIView){
        self.vistaBase=vistaBase;
        super.init();
        aplicationCode = "LONCH";
        uid = String(DatosD.contenedor.padre.id!);
        email = String(trataEmail(DatosD.contenedor.padre.email!));
        sesionId = "AwXytakRpysZKMW8PoWyB6F9FhYx6W";
        timeStamp = String(Int(NSDate().timeIntervalSince1970));
    
    }
    
    //Método que cambia el @ forzado a su equivalente en UTF8 Encoded
    func trataEmail(email: String)->String{
        var retorna = email;
        for letra in email.characters{
            if(letra == "@"){
                retorna.replaceRange(retorna.rangeOfString("@")!, with: "%40");
            }
            
        }
        return retorna;
    }
    
    //Método que genera la cadena para ahcer el request del servicio de paymentez
    func lista(){
        let cadenaSHA = "application_code="+aplicationCode+"&uid="+uid+"&"+timeStamp+"&"+sesionId;
        let datos = cadenaSHA.dataUsingEncoding(NSUTF8StringEncoding);
        print("Pre SHA: ", cadenaSHA);
        envia += "https://ccapi-stg.paymentez.com/api/cc/list?";
        envia += "application_code="+aplicationCode;
        envia += "&uid="+uid;
        envia += "&auth_timestamp="+timeStamp;
        envia += "&auth_token="+String(sha256(datos!));
        //envia += "&"+timeStamp;
        //envia += "&"+sesionId;
        let url = NSURL(string: envia);
        print("Envia: ", url!);
        let request = NSURLRequest(URL: url!);
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding));
            if(data != nil){
                print("No nulo");
                self.leeJSON(data!);
            }else{
                print("nulo?")
            }
        }
    }
    
    //Método que hashea una cadena de texto introducido a travez del encriptado SHA256
    func sha256(data : NSData) -> String {
        let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(data.bytes, CC_LONG(data.length), UnsafeMutablePointer(res!.mutableBytes))
        return limpia(String(res!));
    }
    
    //Método que quita espacios y simbolos del SHA generado
    func limpia(num: String)->String{
        var cambia = num;
        //var pos = [Range<String.Index>]();
        var p = 0;
        for letra in cambia.characters{
            if(letra == " "){
                //pos.append(cambia.rangeOfString(" ")!);
                cambia.replaceRange(cambia.rangeOfString(" ")!, with: "");
                //print("Cambia: ", cambia);
            }
            if(letra == "<"){
                cambia.replaceRange(cambia.rangeOfString("<")!, with: "");
                //print("Cambia: ", cambia);
            }
            if(letra == ">"){
                cambia.replaceRange(cambia.rangeOfString(">")!, with: "");
                //print("Cambia: ", cambia);
            }
            p += 1;
        }
        return cambia;
    }
    
    //Método que lee los datos del JSON
    func leeJSON(data: NSData){
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray;
            //print("json: ", json);
            for ele in json{
                //print(ele);
                var refe = "";
                var termi = "";
                var tipo = "";
                var expi = "";
                for sele in ele as! NSDictionary{
                    switch sele.key as! String{
                    case "card_reference":
                        refe = sele.value as! String;
                        break;
                    case "termination":
                        termi = sele.value as! String;
                        break;
                    case "type":
                        switch sele.value as! String{
                        case "vi":
                            tipo = "Visa";
                            break;
                        case "mc":
                            tipo = "Mastercard";
                            break;
                        case "di":
                            tipo = "Dinners";
                            break;
                        default:
                            break;
                        }
                        
                        break;
                    case "expiry_year":
                        expi = sele.value as! String;
                        break;
                    default:
                        break;
                    }
                }
                let tarjeta = TarjetaEntidad(refe: refe, termi: termi, tipo: tipo, expira: expi);
                tarjetas.append(tarjeta);
            }
            
        }catch{
            print("No se pudo leer JSON")
        }
        if(boton){
            pintaDebita();
        }else{
            pinta();
        }
        
        
    }
    
    //método que pinta las tarjetas disponibles
    func pinta(){
        //print("Pinta");
        let ancho = vistaBase.frame.width;
        let alto = vistaBase.frame.height*0.1;
        let OX = CGFloat(0);
        let OY = vistaBase.frame.width * 0.2;
        var P = CGFloat(0);
        for vista in vistaBase.subviews{
            if(vista is VistaTarjeta){
                vista.removeFromSuperview();
                
            }
        }
        for tarjeta in tarjetas{
            let frame = CGRectMake(OX, (OY+(alto*P)), ancho, alto);
            let tarjetaV = VistaTarjeta(frame: frame, tarjeta: tarjeta);
            tarjetaV.vista = vistaT;
            vistaBase.addSubview(tarjetaV);
            print("TARJ: ", tarjeta.terminacion);
            P += 1;
        }
    }
    
    
    
    func pintaDebita(){
        print("Pinta");
        let ancho = vistaBase.frame.width;
        let alto = vistaBase.frame.height*0.1;
        let OX = CGFloat(0);
        let OY = vistaBase.frame.width * 0.1;
        var P = CGFloat(0);
        if(tarjetas.count == 0){
            vista();
            
        }else{
            for vista in vistaBase.subviews{
                if(vista.accessibilityIdentifier == "gif"){
                    vista.removeFromSuperview();
                    
                }
            }
            for tarjeta in tarjetas{
                let frame = CGRectMake(0, 0, ancho, alto);
                let frameB = CGRectMake(OX, (OY+(alto*P)), ancho, alto);
                let tarjetaV = VistaTarjeta(frame: frame, tarjeta: tarjeta);
                tarjetaV.elimina.removeFromSuperview();
                let bot = BotDebita(frame: frameB, vista: tarjetaV);
                //bot.backgroundColor=UIColor.yellowColor();
                bot.addSubview(tarjetaV);
                vistaBase.addSubview(bot);
                
                //print("TARJ: ", tarjeta.terminacion);
                P += 1;
            }
        }
        if(self.tarjetas.count == 0){
            (vistaBase as! VistaWeb2).texto = "Ingresa una tarjeta nueva";
            (vistaBase as! VistaWeb2).refrescaTexto();
        }else{
            (vistaBase as! VistaWeb2).texto = "Selecciona la tarjeta de crédito con la que deseas pagar la orden";
            (vistaBase as! VistaWeb2).refrescaTexto();
        }
    }
    
    
    func vista(){
        let OY = vistaBase.frame.width * 0.2;
        let ancho = vistaBase.frame.width;
        let OX = CGFloat(0);
        let alto = vistaBase.frame.height;
        let frameWeb = CGRectMake(OX, OY, ancho, alto);
        let add = AddCard();
        if(vistaWeb != nil){
            vistaWeb.removeFromSuperview();
        }
        vistaWeb = SubVista2(frame: frameWeb, list: self);
        //vistaWeb.delegate=self;
        vistaBase.addSubview(vistaWeb);
        vistaWeb.loadRequest(add.add());
        
        //for vv in vistaBase.subviews{
            //print("hijo: ", vv)
        //}
        //print("Base: ", vistaBase);
        //vistaBase.userInteractionEnabled = true;
    }
    
    
    
    func cerrarVista(){
        print("boton");
        vistaWeb.removeFromSuperview();
        //vistaBase.superview?.removeFromSuperview();
        vistaBase.removeFromSuperview();
        //boton2.superview?.hidden=true;
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
    }
    
    
}
