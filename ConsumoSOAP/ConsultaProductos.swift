//
//  ConsultaProductos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 1/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class ConsultaProductos: NSObject , NSURLConnectionDelegate, NSXMLParserDelegate{
    //MARK: Variables
    
    var objs=[Producto]();
    var mensajeEnviado:String = "<?xml version='1.0' encoding='UTF-8'?><S:Envelope xmlns:S='http://schemas.xmlsoap.org/soap/envelope/' xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/'><SOAP-ENV:Header/><S:Body><ns2:listaProductoEntity xmlns:ns2='http://enpoint.lunch.com.co/'/></S:Body></S:Envelope>"
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    var element=NSString()

    //MARK: Consulta
    
    func consulta(){
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/adminEndpoint"
        
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        let session = NSURLSession.sharedSession()
        let _: NSError?
        
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = mensajeEnviado.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"listaProductoEntity\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
            
            //print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " + error!.description)
            }
            //print(self.resp)
            self.parser=NSXMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse()
            dispatch_async(dispatch_get_main_queue(),{
                let cargaS = CargaSalud();
                cargaS.cargaSaludables();
                let cargaF = CargaFavoritos();
                cargaF.consulta(DatosD.contenedor.padre.id);
                
                //let cargaF = CargaFavoritos();
                //cargaF.consulta(DatosD.contenedor.padre.id);
                print("Carga Productos");
            });
        })
        
        task.resume()
        
        
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
    
    var id:Int?;
    var nombre:String?;
    var precio:Int?;
    var imagen:UIImage?;
    var tipo:Int?;
    var disponible:Bool?;
    var salud:Bool?;
    var categoria: Int?;
    
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
            let rutaf="http://93.188.163.97:8080/Lunch2/files/"+string;
            
            let url = NSURL(string: rutaf)!
            let data = NSData(contentsOfURL : url);
            let imagenD=UIImage(data: data!);
            imagen=imagenD;
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
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //Añade Objs
        if(elementName as NSString).isEqualToString("return"){
            let prod = Producto(id: id!, nombre: nombre!, precio: precio!, imagen: imagen!, tipo: tipo!, disponible: disponible!, salud: salud!, categoria: categoria!)!;
            let cargaTinfo = CargaTInfo();
            
            cargaTinfo.CargaTInfo(prod);

            DatosC.contenedor.productos.append(prod);
            objs.append(prod);
            let ctags = CargaTags();
            ctags.consulta(prod);
            //print("pasa parser:", prod.categoria);
        }
    }
}
