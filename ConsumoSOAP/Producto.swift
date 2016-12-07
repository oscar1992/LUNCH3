//
//  Producto.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 1/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit


class Producto: NSObject{
    //MARK: variables
    
    var id:Int?;
    var nombre:String?;
    var precio:Int!;
    var imagen:UIImage?;
    var imagenString: String?;
    var tipo:Int?;
    var disponible:Bool?;
    var salud:Bool?;
    var listaDatos=[TipoInfo]();
    var categoria: Int?;
    
    init?(id: Int, nombre: String, precio : Int, imagen: UIImage?, imagenString: String?, tipo: Int, disponible: Bool, salud: Bool, categoria: Int) {
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
    
    //MARK: Porpiedades
    
    struct PropertyKey{
        static let nombreKey="nombre";
        static let idKey="id";
        static let precio="precio"
        static let imagen="imagen";
    }
    
    
    
    
}