//
//  ProductoSaludable.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ProductoSaludable: NSObject {
    let id:Int!;
    let salu:Saludable!;
    let produ:Producto!;
    
    init(id : Int, salu: Saludable, produ:Producto){
        self.id=id;
        self.salu=salu;
        self.produ=produ;
    }
}
