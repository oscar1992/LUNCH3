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
        self.id = decoder.decodeInteger(forKey: "id");
        self.tipo = decoder.decodeObject(forKey: "tipo") as! String;
        self.valor = decoder.decodeFloat(forKey: "valor") as! Float;
        self.idProducto = decoder.decodeInteger(forKey: "idProducto");
    }
    
    func encode(with coder: NSCoder) {
        if let id = id { coder.encode(id, forKey: "id") }
        if let tipo = tipo { coder.encode(tipo, forKey: "tipo")};
        if let valor = valor { coder.encode(valor, forKey: "valor")};
        if let idProducto = idProducto { coder.encode(idProducto, forKey: "idProducto")};
        
    }

}
