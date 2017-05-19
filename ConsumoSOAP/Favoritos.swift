
//
//  Favoritos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 6/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Favoritos: NSObject, NSCoding{
    var id : Int!;
    var nombre: String!;
    var items=[Producto]();
    
    convenience init(id :Int, nombre: String) {
        self.init();
        self.id=id;
        self.nombre=nombre;
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        self.id = decoder.decodeInteger(forKey: "id");
        self.nombre = decoder.decodeObject(forKey: "nombre") as! String;
        //self.items = decoder.decodeObjectForKey("id") as! Int;
    }
    
    func encode(with coder: NSCoder) {
        if let id = id{coder.encode(id, forKey: "id")};
        if let nombre = nombre{coder.encode(nombre, forKey: "nombre")};
    }
}
