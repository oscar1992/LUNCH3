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
    var ultimaActualizacion: Date!;
    
    convenience init(id : Int, salu: Saludable, produ:Producto, ultimaActualizacion: Date){
        self.init();
        self.id=id;
        self.salu=salu;
        self.produ=produ;
        self.ultimaActualizacion = ultimaActualizacion;
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        self.id = decoder.decodeInteger(forKey: "id");
        self.salu = decoder.decodeObject(forKey: "salu") as! Saludable;
        self.produ = decoder.decodeObject(forKey: "produ") as! Producto;
        self.ultimaActualizacion = decoder.decodeObject(forKey: "ultimaActualizacion") as! Date;
    }
    
    func encode(with coder: NSCoder) {
        if let id = id{coder.encode(id, forKey: "id")};
        if let salu = salu{coder.encode(salu, forKey: "salu")};
        if let produ = produ{coder.encode(produ, forKey: "produ")};
        if let ultimaActualizacion = ultimaActualizacion{ coder.encode(ultimaActualizacion, forKey:  "ultimaActualizacion")}
    }
}
