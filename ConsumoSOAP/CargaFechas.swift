//
//  CargaFechas.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 07/10/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaFechas: NSObject, NSURLConnectionDelegate, UIWebViewDelegate{
    
    var url = "";
    var listaFechas = [FechasEntrega]();
    
    override init(){
        super.init();
        print("Fecghaas Manuales")
        url = "http://93.188.163.97:8084/fechas/listaTodos/";
        let url2 = URL(string: url);
        let request = URLRequest(url: url2!);
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            if(data != nil){
                print("No nulo");
                self.leeJSON(data!);
                DatosD.contenedor.fechas = self.listaFechas;
                print("Tama: ", DatosD.contenedor.fechas.count);
            }else{
                print("nulo?")
            }
        }
    }
    
    //Método que lee el JSON que llega
    func leeJSON(_ data: Data){
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []);
            var estado = "";
            //print("josn: ", json);
            for fecha in json as! NSArray{
                //print("fecha: ", fecha);
                var fechaEntrega = NSDate();
                var fechaLimite = NSDate();
                var valor = 0.0;
                var horas = [Int]();
                for fechaItem in fecha as! NSDictionary{
                    //print("item: ", fechaItem);
                    switch fechaItem.key as! String{
                    case "fechaEntrega":
                        let fechaT = String(describing: fechaItem.value);
                        fechaEntrega = fechaaDate(fecha: fechaT);
                        break;
                    case "fechaLimite":
                        let fechaL = String(describing: fechaItem.value);
                        fechaLimite = fechaaDate(fecha: fechaL);
                        break;
                    case "valorEntrega":
                        //print("valor: ", fechaItem.value);
                        valor = Double(String(describing: fechaItem.value))!;
                        break;
                    case "horas":
                        var ll = (fechaItem.value as! String)
                        //print("nn: ", ll);
                        horas = StringToArray(entrada: ll);
                        
                        break;
                    default:
                        break;
                    }
                }
                /*
                if(fechaLimite != nil && fechaEntrega != nil){
                    print("fe: ", fechaEntrega);
                    print("fL: ", fechaLimite);
                    print("va: ", valor);
                    for hora in horas{
                        print("hora: ", hora);
                    }
                }*/
                print("Añade");
                let nFecha = FechasEntrega(fEntrega: fechaEntrega, fLimite: fechaLimite, val: Int(valor), horas: horas);
                listaFechas.append(nFecha);
            }
            
            
            
            //
            //print("Ele: ", (ele as! NSDictionary));
        }catch{
            print("Error leyendo JSON")
        }
    }
    
    func fechaaDate(fecha: String)->NSDate{
        let indicefin = fecha.index(fecha.startIndex, offsetBy: 19);
        let ft = fecha.substring(to: indicefin);
        //print("ft: ", ft);
        var dateFormatter = DateFormatter();
        dateFormatter.locale = Locale.init(identifier: "es_CO");
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -7200);
        let aux = dateFormatter.date(from: String(ft));
        //print("aux: ", aux);
        return aux as! NSDate;
    }
    
    func StringToArray(entrada: String) -> [Int]{
        var p1 = entrada.replacingOccurrences(of: "{", with: "");
        var p2 = p1.replacingOccurrences(of: "}", with: "");
        var p3 = p2.replacingOccurrences(of: "'", with: "");
        var p4 = p3.replacingOccurrences(of: ",", with: "");
        var lista = p4.characters.split(separator: " ").map(String.init);
        //print("ent: ", p3, "tama: ", lista.count);
        var lista2 = [Int]();
        for n in 0..<lista.count{
            if(n%2 != 0){
                let indice = lista[n].index(lista[n].startIndex, offsetBy: 2);
                var parte = lista[n].substring(to: indice);
                var hora = Int(parte);
                lista2.append(hora!);
                print("hh: ", parte);
            }
        }
        return lista2;
    }
}
