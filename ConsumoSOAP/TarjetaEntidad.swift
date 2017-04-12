//
//  TarjetaEntidad.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 23/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation

class TarjetaEntidad: NSObject{
    
    
    var referencia: String;
    var terminacion: String;
    var tipo: String;
    var expira: String;
    
    init(refe: String, termi: String, tipo: String, expira: String){
        self.referencia=refe;
        self.terminacion=termi;
        self.tipo=tipo;
        self.expira=expira;
    }
    
}
