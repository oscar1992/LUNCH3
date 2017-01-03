//
//  TItems.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class TItems: NSObject, NSCoding {
    
    var id:Int!;
    var productos : Producto!;
    //var favo : Favoritos!;
    
    convenience init(id: Int) {
        self.init();
        self.id=id;
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        self.id = decoder.decodeObjectForKey("id") as! Int;
        self.productos = decoder.decodeObjectForKey("productos") as! Producto;
    }
    
    func encodeWithCoder(coder: NSCoder) {
        if let id = id{coder.encodeObject(id, forKey: "id")};
        if let productos = productos{coder.encodeObject(productos, forKey: "productos")};
    }
}
