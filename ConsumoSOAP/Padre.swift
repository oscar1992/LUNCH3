//
//  Padre.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 25/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit
class Padre: NSObject {
    
    var id:Int?;
    var nombre:String?;
    var telefono:String?;
    var direccion:String?;
    var email:String?
    var pass:String?
    var primeraVez:Bool?;
    var numeroConfirmacion:String?;
    
    init(id: Int, nombre: String, telefono: String, direccion: String, email: String, pass: String, primeraVez: Bool, numeroConf: String) {
        self.id=id;
        self.nombre=nombre;
        self.telefono=telefono;
        self.direccion=direccion;
        self.email=email;
        self.pass=pass;
        self.primeraVez=primeraVez;
        self.numeroConfirmacion=numeroConf;
    }
    
    override init() {
        
    }
    
}