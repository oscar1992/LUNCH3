//
//  DeleteCard.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 28/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class DeleteCard: NSObject, NSURLConnectionDelegate{
    
    var envia:String="";
    var aplicationCode : String!;
    var uid : String!;
    var email : String!;
    var sesionId : String!;
    var timeStamp : String!;
    var tarjeta: TarjetaEntidad!;
    var vista: VistaTarjetas!;
    
    init(tarjeta: TarjetaEntidad){
        self.tarjeta=tarjeta;
        super.init();
        aplicationCode = "LONCH";
        uid = String(DatosD.contenedor.padre.id!);
        email = String(trataEmail(DatosD.contenedor.padre.email!));
        sesionId = "AwXytakRpysZKMW8PoWyB6F9FhYx6W";
        timeStamp = String(Int(NSDate().timeIntervalSince1970));
        
    }
    
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
    func borra(){
        let cadenaSHA = "application_code="+aplicationCode+"&card_reference="+tarjeta.referencia+"&uid="+uid+"&"+timeStamp+"&"+sesionId;
        let datos = cadenaSHA.dataUsingEncoding(NSUTF8StringEncoding);
        print("Pre SHA: ", cadenaSHA);
        envia += "https://ccapi-stg.paymentez.com/api/cc/delete?";
        envia += "card_reference="+tarjeta.referencia;
        envia += "&application_code="+aplicationCode;
        envia += "&uid="+uid;
        envia += "&auth_timestamp="+timeStamp;
        envia += "&auth_token="+String(sha256(datos!));

        let url = NSURL(string: envia);
        print("Envia: ", url!);
        let request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST";
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding));
            let httpStatus = response as? NSHTTPURLResponse;
            if  httpStatus!.statusCode == 200{
                print("Borrado");
                self.vista.consultaTarjetas();
            }else{
                print("No borrado: ",  httpStatus!.statusCode);
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
    
}
