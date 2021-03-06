//
//  LaBarra.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 17/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class LaBarra: UIView {

    func inicia(){
        //let frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, (UIScreen.mainScreen().bounds.height*0.049475));
        //print("frame barra: ", self.frame);
        self.frame = frame;
        setFondo2();
        self.superview?.sendSubview(toBack: self);
        self.isUserInteractionEnabled=false;
        //self.backgroundColor=UIColor.blueColor();
    }
    
    required init?(coder aDecoder: NSCoder) {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height*0.0922));
        super.init(frame: frame);
        self.inicia();
    }
    
    //Método que establece el fondo de desta vista
    func setFondo2(){
            let fondo = UIImage(named: "LaLonchera2");
        let ancho = self.frame.width*0.3;
        let OX = (self.frame.width/2)-(ancho/2);
            let backImg = UIImageView(frame: CGRect(x: OX,y: self.frame.height*0.1,width: ancho,height: (self.frame.height-self.frame.height*0.25)));
            backImg.contentMode = UIViewContentMode.scaleAspectFit;
            backImg.image = fondo;
            self.addSubview(backImg);
            self.sendSubview(toBack: backImg);
    }
    
}
