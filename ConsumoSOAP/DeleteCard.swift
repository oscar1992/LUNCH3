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
        timeStamp = String(Int(Date().timeIntervalSince1970));
        
    }
    
    func trataEmail(_ email: String)->String{
        var retorna = email;
        for letra in email.characters{
            if(letra == "@"){
                retorna.replaceSubrange(retorna.range(of: "@")!, with: "%40");
            }
            
        }
        return retorna;
    }
    
    //Método que genera la cadena para ahcer el request del servicio de paymentez
    func borra(){
        let cadenaSHA = "application_code="+aplicationCode+"&card_reference="+tarjeta.referencia+"&uid="+uid+"&"+timeStamp+"&"+sesionId;
        let datos = cadenaSHA.data(using: String.Encoding.utf8);
        print("Pre SHA: ", cadenaSHA);
        envia += "https://ccapi-stg.paymentez.com/api/cc/delete?";
        envia += "card_reference="+tarjeta.referencia;
        envia += "&application_code="+aplicationCode;
        envia += "&uid="+uid;
        envia += "&auth_timestamp="+timeStamp;
        envia += "&auth_token="+String(sha256(datos!));

        let url = URL(string: envia);
        print("Envia: ", url!);
        let request = NSMutableURLRequest(url: url!);
        request.httpMethod = "POST";
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {(response, data, error) in
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding));
            let httpStatus = response as? HTTPURLResponse;
            if  httpStatus!.statusCode == 200{
                print("Borrado");
                self.vista.consultaTarjetas();
            }else{
                print("No borrado: ",  httpStatus!.statusCode);
            }
        }
    }
    
    //Método que hashea una cadena de texto introducido a travez del encriptado SHA256
    func sha256(_ data : Data) -> String {
        var res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))
        let mutableRaw = UnsafeMutableRawPointer(&res);
        let pointerOpa = OpaquePointer(mutableRaw);
        let contextPtr = UnsafeMutablePointer<UInt8>(pointerOpa)
        CC_SHA256((data as NSData).bytes, CC_LONG(data.count), contextPtr);
        return limpia(String(describing: res!));
    }
    
    //Método que quita espacios y simbolos del SHA generado
    func limpia(_ num: String)->String{
        var cambia = num;
        //var pos = [Range<String.Index>]();
        var p = 0;
        for letra in cambia.characters{
            if(letra == " "){
                //pos.append(cambia.rangeOfString(" ")!);
                cambia.replaceSubrange(cambia.range(of: " ")!, with: "");
                //print("Cambia: ", cambia);
            }
            if(letra == "<"){
                cambia.replaceSubrange(cambia.range(of: "<")!, with: "");
                //print("Cambia: ", cambia);
            }
            if(letra == ">"){
                cambia.replaceSubrange(cambia.range(of: ">")!, with: "");
                //print("Cambia: ", cambia);
            }
            p += 1;
        }
        return cambia;
    }
    
}
