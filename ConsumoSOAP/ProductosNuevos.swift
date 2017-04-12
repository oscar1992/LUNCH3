//
//  ProductosNuevos.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 11/01/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//
import Foundation
import UIKit

class ProductosNuevos: NSObject, NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var mensajeEnviado:String!;
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()
    var task: NSURLSessionDataTask!;
    var profundidad = 0;
    var productosNuevos = [Producto]();
    var cIni:CargaInicial3!;
    
    init(ids: [Int], fechas: [NSDate], cInicial: CargaInicial3){
        mensajeEnviado = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:productosNuevos>";
        var p = 0;
        for id in ids{
            print("ProdNNNNN: ", id);
            mensajeEnviado.appendContentsOf("<ids>"+String(id)+"</ids>");
            mensajeEnviado.appendContentsOf("<fecha>"+String(fechas[p])+"</fecha>");
            p += 1;
        }
        
        mensajeEnviado.appendContentsOf("</enp:productosNuevos></soapenv:Body></soapenv:Envelope>");
        
        super.init();
        self.consulta();
        self.cIni=cInicial;
    }
    
    func consulta(){
        
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint"
        
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        let session = NSURLSession.sharedSession()
        let _: NSError?
        
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = mensajeEnviado!.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"listaProductoEntity\"", forHTTPHeaderField: "SOAPAction")
        
        task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in //Inicio del Subproceso
            //print("Response: \(response)")
            self.task.priority=1.0;
            var nulo = false;
            if(data == nil){
                print("tama: ", self.task.countOfBytesReceived, "Estado Previo: ", self.task.state.rawValue);
                self.task.cancel();
                print("NULOOOO en productosNuevos: ", self.profundidad, "Estado: ", self.task.state.rawValue);
                nulo = true;
            }else{
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
                self.parser=NSXMLParser(data: self.resp)
                self.parser.delegate=self
                self.parser.parse();
            }
           
            dispatch_async(dispatch_get_main_queue(),{
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
        var ultimaActualizacion: NSDate!;
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element=elementName;
        //print("elementos: ", element);
        if(elementName as NSString).isEqualToString("listaProductoEntityResponse"){
            estado=NSMutableString();
            estado="";
        }
        if(elementName as NSString).isEqualToString("idProducto"){
            flagid=true;
        }
        if(elementName as NSString).isEqualToString("nombre"){
            flagnombre=true;
        }
        if(elementName as NSString).isEqualToString("nombreImagen"){
            flagnombreimagen=true;
        }
        if(elementName as NSString).isEqualToString("precio"){
            flagprecio=true;
        }
        if(elementName as NSString).isEqualToString("tipo"){
            flagtipo=true;
        }
        if(elementName as NSString).isEqualToString("disponible"){
            flagdisponible=true;
        }
        if(elementName as NSString).isEqualToString("salud"){
            flagsalud=true;
        }
        if(elementName as NSString).isEqualToString("idCategoria"){
            flagcategoria=true;
        }
        if(elementName as NSString).isEqualToString("ultimaActualizacion"){
            flagUltimaActualizacion = true;
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
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
            
            let dateFormatter = NSDateFormatter()
            let cadena : NSString;
            cadena = string;
            dateFormatter.dateFormat="yyyy-MM-dd'T'hh:mm:ss.SSSZZ";
            dateFormatter.locale = NSLocale.init(localeIdentifier: "es_CO");
            dateFormatter.timeZone = NSTimeZone.localTimeZone();
            //let corta = string.substringWithRange(Range<String.Index>(start: string.startIndex, end: string.startIndex.advancedBy(23)));
            
            ultimaActualizacion = dateFormatter.dateFromString(cadena as String);
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
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //Añade Objs
        if(elementName as NSString).isEqualToString("return"){
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
            let prod = Producto(id: id!, nombre: nombre!, precio: precio!, imagen: imagen, imagenString: imagenString, tipo: tipo!, disponible: disponible!, salud: salud!, categoria: categoria!, ultimaActualizacion: self.ultimaActualizacion);
            productosNuevos.append(prod);
        }
    }
    
    //Método que recoje el string de la fecha, lo parte y la rearma por componentes
    func armaFecha(fecha: String)->NSDate{
        let comp = NSDateComponents();
        let añoS = fecha.substringWithRange(Range<String.Index>(start: fecha.startIndex, end: fecha.startIndex.advancedBy(4)));
        let mesS = fecha.substringWithRange(Range<String.Index>(start: fecha.startIndex.advancedBy(6), end: fecha.startIndex.advancedBy(7)));
        let diaS = fecha.substringWithRange(Range<String.Index>(start: fecha.startIndex.advancedBy(8), end: fecha.startIndex.advancedBy(10)));
        let horaS = fecha.substringWithRange(Range<String.Index>(start: fecha.startIndex.advancedBy(11), end: fecha.startIndex.advancedBy(13)));
        let minS = fecha.substringWithRange(Range<String.Index>(start: fecha.startIndex.advancedBy(14), end: fecha.startIndex.advancedBy(16)));
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
        let cal = NSCalendar.currentCalendar();
        return cal.dateFromComponents(comp)!;
        
        //print("Seg: ", segS);
    }
}
