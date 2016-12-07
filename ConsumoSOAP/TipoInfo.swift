//
//  TipoInfo.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 6/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class TipoInfo:NSObject{
    
    var id:Int = 0;
    var tipo:String = "";
    var valor:Float = 0.0;
    var idProducto:Int;
    
    init(id: Int, tipo: String, valor: Float, idProducto: Int) {
        self.id=id;
        self.tipo=tipo;
        self.valor=valor;
        self.idProducto=idProducto;
    }
    
    
}
