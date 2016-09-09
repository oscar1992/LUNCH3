//
//  Saludable.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Saludable: NSObject {
    var idSalud:Int!;
    var nombre:String!;
    var productos = [Producto]();
    
    init(idSalud: Int, nombre: String) {
        self.idSalud=idSalud;
        self.nombre=nombre;
    }
    
    
}
