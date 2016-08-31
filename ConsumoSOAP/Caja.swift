//
//  Caja.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class Caja: NSObject{
    
    var id:Int!;
    var Nombre:String!;
    //var Color: UIColor!;
    var Color: String!;
    var secuencia = [Secuencia]();
    
    init(id: Int, nombre: String, color: String, secuencia: [Secuencia]) {
        self.id=id;
        self.Nombre=nombre;
        self.Color=color;
        self.secuencia=secuencia;
    }
    
    override init() {
        
    }
    
}