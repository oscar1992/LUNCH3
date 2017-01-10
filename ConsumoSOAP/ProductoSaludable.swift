//
//  ProductoSaludable.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ProductoSaludable: NSObject, NSCoding {
    var id:Int!;
    var salu:Saludable!;
    var produ:Producto!;
    var ultimaActualizacion: NSDate!;
    
    convenience init(id : Int, salu: Saludable, produ:Producto, ultimaActualizacion: NSDate){
        self.init();
        self.id=id;
        self.salu=salu;
        self.produ=produ;
        self.ultimaActualizacion = ultimaActualizacion;
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        self.id = decoder.decodeObjectForKey("id") as! Int;
        self.salu = decoder.decodeObjectForKey("salu") as! Saludable;
        self.produ = decoder.decodeObjectForKey("produ") as! Producto;
        self.ultimaActualizacion = decoder.decodeObjectForKey("ultimaActualizacion") as! NSDate;
    }
    
    func encodeWithCoder(coder: NSCoder) {
        if let id = id{coder.encodeObject(id, forKey: "id")};
        if let salu = salu{coder.encodeObject(salu, forKey: "salu")};
        if let produ = produ{coder.encodeObject(produ, forKey: "produ")};
        if let ultimaActualizacion = ultimaActualizacion{ coder.encodeObject(ultimaActualizacion, forKey:  "ultimaActualizacion")}
    }
}
