//
//  ProductosNuevos.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 11/01/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//
import Foundation
import UIKit

class ProductosNuevos: NSObject, NSURLConnectionDelegate, XMLParserDelegate{
    
    var mensajeEnviado:String!;
    var resp: Data! = nil
    var estado:NSMutableString!
    var parser=XMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var task: URLSessionDataTask!;
    var profundidad = 0;
    var productosNuevos = [Producto]();
    var cIni:CargaInicial3!;
    
    init(ids: [Int], fechas: [Date], cInicial: CargaInicial3){
        mensajeEnviado = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:productosNuevos>";
        var p = 0;
        for id in ids{
            //print("ProdNNNNN: ", id);
            mensajeEnviado.append("<ids>"+String(id)+"</ids>");
            mensajeEnviado.append("<fecha>"+String(describing: fechas[p])+"</fecha>");
            p += 1;
        }
        
        mensajeEnviado.append("</enp:productosNuevos></soapenv:Body></soapenv:Envelope>");
        
        super.init();
        self.consulta();
        self.cIni=cInicial;
    }
    
    func consulta(){
        
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint"
        
        let lobj_Request = NSMutableURLRequest(url: URL(string: is_URL)!)
        let session = URLSession.shared
        let _: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = mensajeEnviado!.data(using: String.Encoding.utf8)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"listaProductoEntity\"", forHTTPHeaderField: "SOAPAction")
        
        task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in //Inicio del Subproceso
            //print("Response: \(response)")
            self.task.priority=1.0;
            var nulo = false;
            if(data == nil){
                //print("tama: ", self.task.countOfBytesReceived, "Estado Previo: ", self.task.state.rawValue);
                self.task.cancel();
                print("NULOOOO en productosNuevos: ", self.profundidad, "Estado: ", self.task.state.rawValue);
                nulo = true;
            }else{
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                self.resp=strData?.data(using: String.Encoding.utf8.rawValue)
                self.parser=XMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
            }
           
            DispatchQueue.main.async(execute: {
                if(nulo && self.profundidad<2){
                    lobj_Request.setValue("Connection", forHTTPHeaderField: "close");
                    self.profundidad += 1;
                     self.consulta();
                }else if(nulo && self.profundidad>=2){
                    //Se murio
                }else{
                    //Fin OK
                    print("CantidadProductos Nuevos: ", self.productosNuevos.count);
                    self.cIni.cambiaProductosNuevos(self.productosNuevos);
                    //self.cIni.iniciaEvaluacion();
                }
            });
        })
        
        task.resume();
    }
    
        //MARK: Parsers Delegates
        
        var flagid=false;
        var flagnombre=false;
        var flagnombreimagen=false;
        var flagprecio=false;
        var flagtipo=false;
        var flagdisponible=false;
        var flagsalud=false;
        var flagcategoria = false;
        var flagUltimaActualizacion = false;
        
        var id:Int?;
        var nombre:String?;
        var precio:Int?;
        var imagen:UIImage?;
        var imagenString: String?;
        var tipo:Int?;
        var disponible:Bool?;
        var salud:Bool?;
        var categoria: Int?;
        var ultimaActualizacion: Date!;
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element=elementName as NSString;
        //print("elementos: ", element);
        if(elementName as NSString).isEqual(to: "listaProductoEntityResponse"){
            estado=NSMutableString();
            estado="";
        }
        if(elementName as NSString).isEqual(to: "idProducto"){
            flagid=true;
        }
        if(elementName as NSString).isEqual(to: "nombre"){
            flagnombre=true;
        }
        if(elementName as NSString).isEqual(to: "nombreImagen"){
            flagnombreimagen=true;
        }
        if(elementName as NSString).isEqual(to: "precio"){
            flagprecio=true;
        }
        if(elementName as NSString).isEqual(to: "tipo"){
            flagtipo=true;
        }
        if(elementName as NSString).isEqual(to: "disponible"){
            flagdisponible=true;
        }
        if(elementName as NSString).isEqual(to: "salud"){
            flagsalud=true;
        }
        if(elementName as NSString).isEqual(to: "idCategoria"){
            flagcategoria=true;
        }
        if(elementName as NSString).isEqual(to: "ultimaActualizacion"){
            flagUltimaActualizacion = true;
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if(flagprecio){
            //print("PRECIO: ",string);
            precio = Int(string)!;
            flagprecio=false;
        }
        if(flagid){
            
            //print("ID: ",string);
            id = Int(string)!
            flagid=false;
        }
        if(flagnombre){
            //print("NOMBRE: ",string);
            nombre=string;
            flagnombre=false;
        }
        if(flagtipo){
            //print("TIPO: ",string);
            tipo=Int(string);
            flagtipo=false;
        }
        if(flagnombreimagen){
            //print("IMAGEN: ",string);
            //let rutaf="http://93.188.163.97:8080/Lunch2/files/"+string;
            let rutaf=string;
            //let url = NSURL(string: rutaf)!
            //let data = NSData(contentsOfURL : url);
            //let imagenD=UIImage(data: data!);
            imagenString=rutaf;
            //imagen=imagenD;
            flagnombreimagen=false;
        }
        if(flagdisponible){
            disponible=NSString(string: string).boolValue;
            flagdisponible=false;
        }
        if(flagsalud){
            salud=NSString(string: string).boolValue;
            flagsalud=false;
        }
        if(flagcategoria){
            categoria = Int(string);
            //print("Caregoria: ",categoria);
            flagcategoria = false;
        }
        if(flagUltimaActualizacion){
            armaFecha(string);
            
            let dateFormatter = DateFormatter()
            let cadena : NSString;
            cadena = string as NSString;
            dateFormatter.dateFormat="yyyy-MM-dd'T'hh:mm:ss.SSSZZ";
            dateFormatter.locale = Locale.init(identifier: "es_CO");
            dateFormatter.timeZone = TimeZone.autoupdatingCurrent;
            //let corta = string.substringWithRange(Range<String.Index>(start: string.startIndex, end: string.startIndex.advancedBy(23)));
            
            ultimaActualizacion = dateFormatter.date(from: cadena as String);
            if(ultimaActualizacion == nil){
                ultimaActualizacion = armaFecha(string);
            }
            //print("----------------");
            //print("Zona: ", NSTimeZone.localTimeZone());
            //print("PRE String: ", cadena);
            //print("STRING: ", dateFormatter.dateFromString(cadena as String));
            //print("PROD ULTM: ", ultimaActualizacion);
            //print("----------------");
            flagUltimaActualizacion = false;
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //Añade Objs
        if(elementName as NSString).isEqual(to: "return"){
            /*
            print("------Producto Nuevo------");
            print("id: ", id);
            print("tipo: ", tipo);
            print("disponible: ", disponible);
            print("salud: ", salud);
            print("Categ: ", categoria);
            print("fecha: ", ultimaActualizacion);
            print("------FinProducto Nuevo------");
            */
            let prod = Producto(id: id!, nombre: nombre!, precio: precio!, imagen: imagen, imagenString: imagenString, tipo: tipo!, disponible: disponible!, salud: salud!, categoria: categoria!, ultimaActualizacion: (self.ultimaActualizacion as! NSDate) as Date);
            productosNuevos.append(prod);
        }
    }
    
    //Método que recoje el string de la fecha, lo parte y la rearma por componentes
    func armaFecha(_ fecha: String)->Date{
        var comp = DateComponents();
        let añoS = fecha.substring(with: (fecha.startIndex ..< fecha.characters.index(fecha.startIndex, offsetBy: 4)));
        let mesS = fecha.substring(with: (fecha.characters.index(fecha.startIndex, offsetBy: 6) ..< fecha.characters.index(fecha.startIndex, offsetBy: 7)));
        let diaS = fecha.substring(with: (fecha.characters.index(fecha.startIndex, offsetBy: 8) ..< fecha.characters.index(fecha.startIndex, offsetBy: 10)));
        let horaS = fecha.substring(with: (fecha.characters.index(fecha.startIndex, offsetBy: 11) ..< fecha.characters.index(fecha.startIndex, offsetBy: 13)));
        let minS = fecha.substring(with: (fecha.characters.index(fecha.startIndex, offsetBy: 14) ..< fecha.characters.index(fecha.startIndex, offsetBy: 16)));
        //let segS = fecha.substringWithRange(Range<String.Index>(start: fecha.startIndex.advancedBy(16), end: fecha.startIndex.advancedBy(16)));
        comp.year = Int(añoS)!;
        comp.month = Int(mesS)!;
        comp.day = Int(diaS)!;
        comp.hour = Int(horaS)!;
        comp.minute = Int(minS)!;
        //comp.second = Int(segS)!;
        //print("Año: ",añoS);
        //print("Mes: ", mesS);
        //print("Dia: ", diaS);
        //print("Hora: ", horaS);
        //print("Min: ", minS);
        let cal = Calendar.current;
        return cal.date(from: comp)!;
        
        //print("Seg: ", segS);
    }
}
