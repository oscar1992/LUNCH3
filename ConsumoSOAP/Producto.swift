//
//  Producto.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 1/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit


class Producto: NSObject, NSCoding{
    //MARK: variables
    
    var id:Int!;
    var nombre:String!;
    var precio:Int!;
    var imagen:UIImage?;
    var imagenString: String?;
    var tipo:Int!;
    var disponible:Bool!;
    var salud:Bool!;
    var listaDatos=[TipoInfo]();
    var categoria: Int!;
    var ultimaActualizacion: Date!;
    
    convenience init(id: Int, nombre: String, precio : Int, imagen: UIImage?, imagenString: String?, tipo: Int, disponible: Bool, salud: Bool, categoria: Int, ultimaActualizacion: Date) {
        self.init();
        self.id=id;
        self.nombre=nombre;
        self.precio=precio;
        if(imagen == nil){
            self.imagen=UIImage(named: "ProductoVacio");
        }else{
            self.imagen=imagen;
        }
        self.imagenString=imagenString;
        self.tipo=tipo;
        self.disponible=disponible;
        self.salud=salud;
        self.categoria = categoria;
        self.ultimaActualizacion = ultimaActualizacion;
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        //print("decod: ", decoder.decodeObject(forKey: "nombre") as Any);
        self.id = decoder.decodeInteger(forKey: "idd");
        //self.id = decoder.decodeObject(forKey: "idd") as! Int;
        self.nombre = decoder.decodeObject(forKey: "nombre") as! String;
        self.precio = decoder.decodeInteger(forKey: "precio");
        self.imagen = decoder.decodeObject(forKey: "imagen") as? UIImage;
        self.imagenString = decoder.decodeObject(forKey: "imagenString") as? String;
        self.tipo = decoder.decodeInteger(forKey: "tipo");
        self.disponible = decoder.decodeBool(forKey: "disponible");
        self.salud = decoder.decodeBool(forKey: "salud");
        self.categoria = decoder.decodeInteger(forKey: "categoria");
        self.ultimaActualizacion = decoder.decodeObject(forKey: "ultimaActualizacion") as! Date;
    }
    
    func encode(with coder: NSCoder) {
        
        if let id = id { coder.encode(id, forKey: "idd"); print("qq: "); }
        //print("Guarda Prod: ", coder.decodeObject(forKey: "id"));
        if let nombre = nombre { coder.encode(nombre, forKey: "nombre") }
        if let precio = precio { coder.encode(precio, forKey: "precio") }
        if let imagen = imagen { coder.encode(imagen, forKey: "imagen") }
        if let imagenString = imagenString { coder.encode(imagenString, forKey: "imagenString") }
        if let tipo = tipo { coder.encode(tipo, forKey: "tipo") }
        if let disponible = disponible { coder.encode(disponible, forKey: "disponible") }
        if let salud = salud { coder.encode(salud, forKey: "salud") }
        if let categoria = categoria { coder.encode(categoria, forKey: "categoria") }
        if let ultimaActualizacion = ultimaActualizacion{ coder.encode(ultimaActualizacion, forKey:  "ultimaActualizacion")}
    }
    
    //MARK: Porpiedades
    
    struct PropertyKey{
        static let nombreKey="nombre";
        static let idKey="id";
        static let precio="precio"
        static let imagen="imagen";
    }
    
    
    
    
}
