//
//  Saludable.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Saludable: NSObject, NSCoding {
    var idSalud:Int!;
    var nombre:String!;
    var productos : [Producto]?;
    
    convenience init(idSalud: Int, nombre: String) {
        self.init();
        self.idSalud=idSalud;
        self.nombre=nombre;
        self.productos=[Producto]();
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        self.idSalud = decoder.decodeObjectForKey("idSalud") as! Int;
        self.nombre = decoder.decodeObjectForKey("nombre") as! String;
        self.productos = decoder.decodeObjectForKey("productos") as? [Producto];
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        if let idSalud = idSalud{coder.encodeObject(idSalud, forKey: "idSalud")};
        if let nombre = nombre{coder.encodeObject(nombre, forKey: "nombre")};
        //if let productos = [Producto]{coder.encodeObject(productos, forKey: "nombre")};
    }
}
