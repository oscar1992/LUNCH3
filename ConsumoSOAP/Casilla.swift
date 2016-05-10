//
//  Casilla.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 4/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Casilla: UIButton {
    
    
    var tipo:Int?;
    var lonchera:LoncheraO!;
    var activo:Bool?;
    var elemeto:ProductoView?;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor=UIColor.magentaColor();
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("fin tocado");
    }

}
