//
//  Secuencia.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class Secuencia: NSObject {
    
    var id:Int!;
    var lista : [TItems]!;
    var caja : Int?;
    var nombre:String?;
    
    init(id: Int) {
        self.id=id;
        lista = [TItems]();
    }
    
}
