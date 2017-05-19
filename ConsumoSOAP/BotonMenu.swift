//
//  BotonMenu.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 31/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotonMenu: UIButton {
    
    
    
    init(ima: String, texto: String, frame: CGRect){
        super.init(frame: frame);
        //self.backgroundColor=UIColor.yellowColor();
        let icoFrame = CGRect(x: self.frame.width*0.1, y: self.frame.height*0.25, width: self.frame.width*0.3, height: self.frame.height*0.5);
        let ico = UIView(frame: icoFrame);
        self.addSubview(ico);
        DatosB.cont.poneFondoTot(ico, fondoStr: ima, framePers: nil, identi: nil, scala: true);
        let frameTexto = CGRect(x: icoFrame.width+(self.frame.width*0.2), y: 0, width: self.frame.width*0.4, height: self.frame.height);
        let textoL = UILabel(frame: frameTexto);
        self.addSubview(textoL);
        textoL.text=texto;
        textoL.textColor=UIColor.white;
        textoL.textAlignment=NSTextAlignment.center;
        textoL.font=UIFont(name: "Gotham Medium", size: self.frame.height/3);
        textoL.adjustsFontSizeToFitWidth=true;
        textoL.numberOfLines=0;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
