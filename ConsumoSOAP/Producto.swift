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
    
    convenience init(id: Int, nombre: String, precio : Int, imagen: UIImage?, imagenString: String?, tipo: Int, disponible: Bool, salud: Bool, categoria: Int) {
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
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        self.id = decoder.decodeObjectForKey("id") as! Int;
        self.nombre = decoder.decodeObjectForKey("nombre") as! String;
        self.precio = decoder.decodeObjectForKey("precio") as! Int;
        self.imagen = decoder.decodeObjectForKey("imagen") as? UIImage;
        self.imagenString = decoder.decodeObjectForKey("imagenString") as? String;
        self.tipo = decoder.decodeObjectForKey("tipo") as! Int;
        self.disponible = decoder.decodeObjectForKey("disponible") as! Bool;
        self.salud = decoder.decodeObjectForKey("salud") as! Bool;
        self.categoria = decoder.decodeObjectForKey("categoria") as! Int;
    }
    
    func encodeWithCoder(coder: NSCoder) {
        if let id = id { coder.encodeObject(id, forKey: "id") }
        if let nombre = nombre { coder.encodeObject(nombre, forKey: "nombre") }
        if let precio = precio { coder.encodeObject(precio, forKey: "precio") }
        if let imagen = imagen { coder.encodeObject(imagen, forKey: "imagen") }
        if let imagenString = imagenString { coder.encodeObject(imagenString, forKey: "imagenString") }
        if let tipo = tipo { coder.encodeObject(tipo, forKey: "tipo") }
        if let disponible = disponible { coder.encodeObject(disponible, forKey: "disponible") }
        if let salud = salud { coder.encodeObject(salud, forKey: "salud") }
        if let categoria = categoria { coder.encodeObject(categoria, forKey: "categoria") }
    }
    
    //MARK: Porpiedades
    
    struct PropertyKey{
        static let nombreKey="nombre";
        static let idKey="id";
        static let precio="precio"
        static let imagen="imagen";
    }
    
    
    
    
}