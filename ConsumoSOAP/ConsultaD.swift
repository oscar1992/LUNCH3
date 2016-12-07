//
//  ConsultaD.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 13/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ConsultaD: NSObject{
    
    var direcciones = [Direcciones]();
    
    func consulta(direcc: String, padre: DatosPadre){
        
        let requestURL: NSURL = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address="+cambiaEspacios(direcc)+"&region=co&key=AIzaSyBggWRu3CeBU_bQGS-up8C8RIYN6aj8R9g")!;
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments);
                    
                    if let results = json["results"] as? [[String: AnyObject]]{
                        var direccion:String?;
                        var ciudadS: String?;
                        var latitud: String?;
                        var longitud: String?;
                            //print("comp: ", results);
                        for geometry in results{
                            //print("ele: ", geometry);
                                for geo in geometry{
                                    //print("geometria: ", geo);
                                    if let compo = geometry["address_components"] as? [[String: AnyObject]]{
                                        for compodir in compo{
                                            for n1 in compodir{
                                                var ciudad = false;
                                                //print("compodir: ", n1.0, " valor: ", n1.1);
                                                if(n1.0 == "types"){
                                                    
                                                    for n2 in (n1.1 as! [AnyObject]){
                                                        if(n2 as! String == "administrative_area_level_1"){
                                                            //print("nivel admon: ", n1.1);
                                                            ciudad = true;
                                                        }
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                if(ciudad){
                                                    for n1 in compodir{
                                                        //print("n1: ", n1.0);
                                                        if(n1.0 == "long_name"){
                                                            print("nomb: ", n1.0,"n1: ", n1.1);
                                                            ciudadS = n1.1 as! String;
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            //print("------------------------------------------")
                                        }
                                    }
                                    if geo.0=="formatted_address"{
                                        print("ADRR: ", geo.1)
                                        direccion = geo.1 as! String;
                                    }
                                    if geo.0=="geometry"{
                                        //print("Geo11: ", geo.1);
                                        for ele in (geo.1 as! [String: AnyObject]){
                                            if(ele.0 as! String == "location"){
                                                //print("ele1: ", ele.1);
                                                for pos in ele.1 as! [String: AnyObject]{
                                                    if(pos.0 == "lat"){
                                                        latitud = String(pos.1)
                                                    }
                                                    if(pos.0 == "lng"){
                                                        longitud = String(pos.1);
                                                    }
                                                    print("pos: ", pos.0, "-", pos.1);
                                                }
                                            }
                                            //
                                        }
                                    }
                                }
                        }
                        
                        
                        let dir = Direcciones(dir: direccion!, ciu: ciudadS!, lat: Double(latitud!)!, lon: Double(longitud!)!);
                        self.direcciones.append(dir);
                        
                    }
                    dispatch_async(dispatch_get_main_queue(),{
                        padre.iniciaMensaje(self.direcciones);
                        }
                    );
                    
                    
                    
                //print("JSON??: ", json);
                }catch{
                        
                }
                //print("Everyone is fine, file downloaded successfully.")
            }
        }
        
        task.resume()
        
    }
    
    func cambiaEspacios(texto:String)->String{
        var texto2 = texto;
        var pasa = true;
        var p = 0;
        while (pasa) {
            let indice = texto2.startIndex.advancedBy(p);
            //print("cara: ", texto2[indice]);
            if(texto2[indice]==" "){
                texto2.replaceRange(Range.init(start: texto2.startIndex.advancedBy(p), end: texto2.startIndex.advancedBy(p+1)), with: "+");
            }
            p += 1;
            if(p >= texto.characters.count){
                pasa = false;
            }
        }
        print("texto: ", texto2);
        return texto2+"+Bogota";
    }
    
    
}
