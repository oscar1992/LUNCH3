//
//  Tag.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 15/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class Tag: NSObject {
    
    var idTag:Int?;
    var nombreTag:String?;
    var idProducto:Int?;
    
    init(id: Int, nombreTag: String, idProducto: Int) {
        self.idTag=id;
        self.nombreTag=nombreTag;
        self.idProducto=idProducto;
    }
    
    }