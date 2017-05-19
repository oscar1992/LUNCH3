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
        self.idSalud = decoder.decodeInteger(forKey: "idSalud");
        self.nombre = decoder.decodeObject(forKey: "nombre") as! String;
        self.productos = decoder.decodeObject(forKey: "productos") as? [Producto];
    }
    
    func encode(with coder: NSCoder) {
        
        if let idSalud = idSalud{coder.encode(idSalud, forKey: "idSalud")};
        if let nombre = nombre{coder.encode(nombre, forKey: "nombre")};
        //if let productos = [Producto]{coder.encodeObject(productos, forKey: "nombre")};
    }
}
