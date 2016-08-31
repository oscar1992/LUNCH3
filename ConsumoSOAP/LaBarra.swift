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
    }
    
    required init?(coder aDecoder: NSCoder) {
        let frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, (UIScreen.mainScreen().bounds.height*0.049475));
        super.init(frame: frame);
        self.inicia();
    }
    
    //Método que establece el fondo de desta vista
    func setFondo2(){
            let fondo = UIImage(named: "LaLonchera");
            let backImg = UIImageView(frame: CGRectMake(0,self.frame.height*0.1,self.frame.width,(self.frame.height-self.frame.height*0.2)));
            backImg.contentMode = UIViewContentMode.ScaleAspectFit;
            backImg.image = fondo;
            self.addSubview(backImg);
            self.sendSubviewToBack(backImg);
    }
    
}
