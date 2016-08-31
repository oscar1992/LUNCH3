//
//  Categoria.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 7/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class Categoria: NSObject {
    
    var id: Int!;
    var nombre: String!;
    var tipo: Int!;
    
    init(id: Int, nombre: String, tipo: Int) {
        self.id = id;
        self.nombre = nombre;
        self.tipo = tipo;
    }
    
    
}
