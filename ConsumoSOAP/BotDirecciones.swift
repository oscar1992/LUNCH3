//
//  BotDirecciones.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 20/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotDirecciones: UIButton {
    
    var direccion: Direcciones;
    
    init(frame: CGRect, dir: Direcciones){
        self.direccion=dir;
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
