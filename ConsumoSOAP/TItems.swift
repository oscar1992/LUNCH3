//
//  TItems.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class TItems: NSObject {
    
    var id:Int;
    var productos : Producto?;
    //var favo : Favoritos!;
    
    init(id: Int) {
        self.id=id;
        
    }
}
