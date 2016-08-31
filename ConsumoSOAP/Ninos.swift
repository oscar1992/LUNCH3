//
//  Ninos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 26/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class Ninos: NSObject {
    
    var id: Int?;
    var nombre: String?;
    var fechaNacimiento: NSDate?;
    var padre : Int?;
    var genero:String?;
    var añoActual: AnoScroll?;
    
    init(id: Int, nombre: String, fechaN: NSDate, padre:Int, genero: String) {
        self.id=id;
        self.nombre=nombre;
        self.fechaNacimiento=fechaN;
        self.padre=padre;
        self.genero=genero;
    }
    
    override init(){
        
    }
}
