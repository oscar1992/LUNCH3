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
    var padre:Int!
    //var favo : Favoritos!;
    
    convenience init(id: Int) {
        self.init();
        self.id=id;
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        self.id = decoder.decodeInteger(forKey: "id");
        self.padre = decoder.decodeInteger(forKey: "padre");
        self.productos = decoder.decodeObject(forKey: "productos") as! Producto;
    }
    
    func encode(with coder: NSCoder) {
        if let id = id{coder.encode(id, forKey: "id")};
        if let padre = padre{coder.encode(padre, forKey: "padre")};
        if let productos = productos{coder.encode(productos, forKey: "productos")};
    }
}
