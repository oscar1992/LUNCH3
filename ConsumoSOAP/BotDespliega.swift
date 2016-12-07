//
//  BotDespliega.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 21/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotDespliega: UIButton {
    
    var fecha: FechaEntrega?;
    var hora: HoraEntrega?;
    
    init(frame: CGRect, fecha: FechaEntrega?, hora: HoraEntrega?){
        self.fecha=fecha;
        self.hora=hora;
        super.init(frame: frame);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
