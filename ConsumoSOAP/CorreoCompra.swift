//
//  CorreoCompra.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 06/22/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CorreoCompra: NSObject, NSURLConnectionDelegate{
    
    var nombre:String;
    var correo:String;
    var valor:String;
    var detalle:String;
    var fechaPedido: String;
    var fechaEntrega: String;
    var direccion: String;
    
    
    init(valor: String, detalle: String, fechaPedido: String, fechaEntrga: String){
        nombre = DatosD.contenedor.padre.nombre!;
        correo = DatosD.contenedor.padre.email!;
        direccion = DatosD.contenedor.padre.direccion!+" "+DatosD.contenedor.padre.adicional!+" "+DatosD.contenedor.padre.barrio!;
        self.valor = valor;
        self.detalle = detalle;
        self.fechaPedido = fechaPedido;
        self.fechaEntrega=fechaEntrga;
        super.init();
        enviaCorreo();
    }
    
    func enviaCorreo(){
        if(nombre != "" && correo != "" && valor != "" && detalle != "" && fechaPedido != "" && fechaEntrega != "" ){
            let link = "http://93.188.163.97:8081/?user="+limpiaEspacios(entrada: nombre)+"&email="+correo+"&valor="+valor+"&dir="+limpiaEspacios(entrada: direccion)+"&fp="+limpiaEspacios(entrada: fechaPedido)+"&fe="+limpiaEspacios(entrada: fechaEntrega)+"&data="+limpiaEspacios(entrada: detalle)+"&envia="+String(DatosB.cont.envia);
            let url = URL(string: link);
            print("url correo: ", link);
            var request = URLRequest(url: url!);
            request.httpMethod="POST";
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
                if(data != nil){
                    print("data: ", NSString(data: data!, encoding: String.Encoding.utf8.rawValue));
                }else{
                    print("Error creando correo factura")
                }
                
                //print("resp: ", response);
                //print("resp: ", request);
            }
        }else{
            print("Valores Vacios");
        }
    }
    
    func limpiaEspacios(entrada: String)->String{
        var maneja = entrada.replacingOccurrences(of: "#", with: "%23");
        maneja = maneja.replacingOccurrences(of: " ", with: "%20");
        maneja = maneja.replacingOccurrences(of: ";", with: "%3B");
        maneja = maneja.replacingOccurrences(of: ":", with: "%3A");
        maneja = maneja.replacingOccurrences(of: ",", with: "%20");
        return maneja;
    }
    
}
