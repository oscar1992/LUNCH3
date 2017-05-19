//
//  AddCard.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 10/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit


class AddCard: NSObject, NSURLConnectionDelegate{
    
    var envia:String="";
    var aplicationCode : String!;
    var uid : String!;
    var email : String!;
    var sesionId : String!;
    var timeStamp : String!;
    
    override init(){
        super.init();
        aplicationCode = "LONCH";
        uid = String(DatosD.contenedor.padre.id!);
        email = String(trataEmail(DatosD.contenedor.padre.email!));
        sesionId = "AwXytakRpysZKMW8PoWyB6F9FhYx6W";
        timeStamp = String(Int(Date().timeIntervalSince1970));
        
    }
    
    func add()->URLRequest{
        envia += "https://ccapi-stg.paymentez.com/api/cc/add?";
        envia += "application_code="+aplicationCode;
        envia += "&email="+email;
        envia += "&session_id="+sesionId;
        envia += "&uid="+uid;
        envia += "&auth_timestamp="+timeStamp;
        envia += "&"+sesionId;
        let cadenaSHA = "application_code="+aplicationCode+"&email="+email+"&session_id="+sesionId+"&uid="+uid+"&"+timeStamp+"&"+sesionId;
        //let cadenaSHA = "application_code=foo&email=awesome%40user.com&uid=1&1394829530&Th1sI5myK3Y";
        let datos = cadenaSHA.data(using: String.Encoding.utf8);
        print("Pre SHA: ", cadenaSHA);
        envia += "&auth_token="+String(sha256(datos!));
        //envia += "XXX"
        //envia = envia.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
        //envia = envia.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!;
        //print("Pre: ", envia);
        let url = URL(string: envia);
        print("Envia: ", url!);
        let request = URLRequest(url: url!);
        return request;
        //NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
        //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        //}
    }
    
    //Método que hashea una cadena de texto introducido a travez del encriptado SHA256
    func sha256(_ data : Data) -> String {
        var res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH));
        
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
    
    func trataEmail(_ email: String)->String{
        var retorna = email;
        for letra in email.characters{
            if(letra == "@"){
                retorna.replaceSubrange(retorna.range(of: "@")!, with: "%40");
            }
            
        }
        return retorna;
    }
    
}
