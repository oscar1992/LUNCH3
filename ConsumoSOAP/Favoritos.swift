//
//  Favoritos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 6/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Favoritos: NSObject {
    var id : Int!;
    var nombre: String!;
    var items=[Producto]();
    
    init(id :Int, nombre: String) {
        self.id=id;
        self.nombre=nombre;
    }
}
