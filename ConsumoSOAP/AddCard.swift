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
    
    func add(){
        
        envia = "https://ccapi-stg.paymentez.com/api/cc/add/";
        envia += "application_code=LONCH";
        envia += "&uid="+String(DatosD.contenedor.padre.id!);
        envia += "&email="+String(DatosD.contenedor.padre.email!);
        envia += "&session_id=AwXytakRpysZKMW8PoWyB6F9FhYx6W";
        envia += "&auth_timestamp="+String(Int(NSDate().timeIntervalSince1970));
        let cadenaSHA = "application_code=LONCH&email="+String(DatosD.contenedor.padre.email!)+"&uid="+String(DatosD.contenedor.padre.id!);
        let datos = cadenaSHA.dataUsingEncoding(NSUTF8StringEncoding);
        envia += "&auth_token="+String(sha256(datos!));
        print("Pre: ", envia);
        let url = NSURL(string: envia);
        print("Envia: ", url!);
        let request = NSURLRequest(URL: url!);
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
    }
    
    func sha256(data : NSData) -> String {
        let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(data.bytes, CC_LONG(data.length), UnsafeMutablePointer(res!.mutableBytes))
        return limpia(String(res!));
    }
    
    func limpia(num: String)->String{
        var cambia = num;
        var pos = [Range<String.Index>]();
        var p = 0;
        for letra in cambia.characters{
            if(letra == " "){
                //pos.append(cambia.rangeOfString(" ")!);
                cambia.replaceRange(cambia.rangeOfString(" ")!, with: "");
                 print("Cambia: ", cambia);
            }
            p += 1;
        }

       
        return cambia;
    }
    
}
