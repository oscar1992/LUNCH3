//
//  TipoInfo.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 6/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class TipoInfo:NSObject, NSCoding{
    
    var id:Int!;
    var tipo:String!;
    var valor:Float!;
    var idProducto:Int!;
    
    convenience init(id: Int, tipo: String, valor: Float, idProducto: Int) {
        self.init();
        self.id=id;
        self.tipo=tipo;
        self.valor=valor;
        self.idProducto=idProducto;
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init();
        self.id = decoder.decodeObjectForKey("id") as! Int;
        self.tipo = decoder.decodeObjectForKey("tipo") as! String;
        self.valor = decoder.decodeObjectForKey("valor") as! Float;
        self.idProducto = decoder.decodeObjectForKey("idProducto") as! Int;
    }
    
    func encodeWithCoder(coder: NSCoder) {
        if let id = id { coder.encodeObject(id, forKey: "id") }
        if let tipo = tipo { coder.encodeObject(tipo, forKey: "tipo")};
        if let valor = valor { coder.encodeObject(valor, forKey: "valor")};
        if let idProducto = idProducto { coder.encodeObject(idProducto, forKey: "idProducto")};
        
    }

}
