//
//  Tag.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 15/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class Tag: NSObject, NSCoding{
    
    var idTag:Int!;
    var nombreTag:String!;
    var idProducto:Int!;
    
    convenience init(id: Int, nombreTag: String, idProducto: Int) {
        self.init();
        self.idTag=id;
        self.nombreTag=nombreTag;
        self.idProducto=idProducto;
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        self.idTag = decoder.decodeInteger(forKey: "idTag");
        self.nombreTag = decoder.decodeObject(forKey: "nombreTag") as! String;
        self.idProducto = decoder.decodeInteger(forKey: "idProducto");
    }
    
    func encode(with coder: NSCoder) {
        if let idTag = idTag {coder.encode(idTag, forKey: "idTag")};
        if let nombreTag = nombreTag {coder.encode(nombreTag, forKey: "nombreTag")};
        if let idProducto = idProducto {coder.encode(idProducto, forKey: "idProducto")};
    }
}
