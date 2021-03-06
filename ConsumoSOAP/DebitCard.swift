//
//  DebitCard.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 28/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit


class DebitCard: NSObject , NSURLConnectionDelegate{
    
    var envia:String="";
    var aplicationCode : String!;
    var uid : String!;
    var email : String!;
    var sesionId : String!;
    var timeStamp : String!;
    var tarjeta: TarjetaEntidad!;
    var ip: String!;
    
    var cantidad:String!;
    var descripcion: String!;
    var referencia:String!;
    var vat:String!;
    
    init (tarjeta: TarjetaEntidad, cantidad: String, descripcion: String, referencia: String, vat: String){
        self.cantidad=cantidad;
        self.descripcion=descripcion;
        self.referencia=referencia;
        self.vat=vat;
        self.tarjeta=tarjeta;
        super.init();
        obtiene();
        aplicationCode = "LONCH";
        uid = String(DatosD.contenedor.padre.id!);
        email = String(trataEmail(DatosD.contenedor.padre.email!));
        sesionId = "9rDozxAmJ6nvK1LBNGms2786ol5CtO";
        //sesionId = "AwXytakRpysZKMW8PoWyB6F9FhYx6W";
        timeStamp = String(Int(Date().timeIntervalSince1970));
    }
    
    //Método que cambia el @ forzado a su equivalente en UTF8 Encoded
    func trataEmail(_ email: String)->String{
        var retorna = email;
        for letra in email.characters{
            if(letra == "@"){
                retorna.replaceSubrange(retorna.range(of: "@")!, with: "%40");
            }
            
        }
        return retorna;
    }
    

    
    func consulta(){
        print("IP fin: ", ip);
        var cadenaSHA = "application_code="+aplicationCode+"&card_reference="+tarjeta.referencia+"&dev_reference="+referencia;
        cadenaSHA += "&email="+email+"&ip_address="+ip+"&product_amount="+String(cantidad)+".00";
        cadenaSHA += "&product_description="+descripcion+"&session_id="+sesionId;
        cadenaSHA += "&uid="+uid+"&vat="+vat+"&"+timeStamp+"&"+sesionId;
        let datos = cadenaSHA.data(using: String.Encoding.utf8);
        //print("Pre SHA: ", cadenaSHA);
        envia += "https://ccapi.paymentez.com/api/cc/debit?";
        envia = envia.appending("application_code="+aplicationCode);
        envia += "&card_reference="+tarjeta.referencia;
        envia += "&dev_reference="+referencia;
        envia += "&email="+email;
        envia += "&ip_address="+ip;
        envia += "&product_amount="+String(cantidad)+".00";
        envia = envia.appending("&product_description="+descripcion);
        envia += "&vat="+vat;
        envia += "&session_id="+sesionId;
        envia += "&uid="+uid;
        envia += "&auth_timestamp="+timeStamp;
        envia += "&auth_token="+String(sha256(datos!));
 
        print("ENVIA: ", envia);
        let url = URL(string: envia);
        print("Envia: ", url!);
        let request = NSMutableURLRequest(url: url!);
        request.httpMethod = "POST";
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {(response, data, error) in
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding));
            if(data != nil){
                self.leeJSON(data!);
            }else{
                //No llegaron datos = no hubo internet
            }
            
        }
    }
    
    //Método que hashea una cadena de texto introducido a travez del encriptado SHA256
    func sha256(_ data : Data) -> String {
        var digestData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        print("count: ", data.count);
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            data.withUnsafeBytes {messageBytes in
                CC_SHA256(messageBytes, CC_LONG(data.count), digestBytes)
            }
        }
        return digestData.map{ String(format: "%02hhx", $0)}.joined();
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
    
    //Método que trae la ip externa del dispositivo
    func obtiene(){
        let getip = getIP(padre: self);
        getip.consulta();
        //
    }
    
    
    
    //Método que lee el JSON que llega
    func leeJSON(_ data: Data){
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary;
            var estado = "";
            for ele in json{
                //print("Ele: ", ele.key);
                //print("EleV: ", ele.value);
                //for sele in ele as! NSDictionary{
                    switch ele.key as! String{
                        case "status":
                            print("estado: ", ele.value);
                            estado = ele.value as! String;
                            cambiaEstado(true);
                            break;
                    default:
                        print("No exitoso");
                        cambiaEstado(false);
                        break;
                    }
                //}
            }
        }catch{
            print("Error leyendo JSON")
        }
    }
    
    //Método que cambia el estado del pedido a exitoso
    func cambiaEstado(_ estado: Bool){
        let pedido = DatosC.contenedor.pedido;
        let confirma = ConfirmaPedido();
        confirma.confirmaPedido(String(describing: pedido!.id), idPadre: DatosD.contenedor.padre, fechaPedido: pedido!.fechaPedido, fechaEntrega: pedido!.fechaEntrega, horaEntrega: pedido!.horaEntrega, valor: pedido!.valor, cantidad: pedido!.cantidad, metodo: pedido!.metodo, aprobado: estado);
    }
    
}
