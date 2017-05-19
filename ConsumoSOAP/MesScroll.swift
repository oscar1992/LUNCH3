//
//  MesScroll.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 10/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class MesScroll: UIScrollView, UIScrollViewDelegate {
    
    var años = [An_o]();
    
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        self.delegate=self;
        //qself.alpha=0.5;
        self.backgroundColor=UIColor.yellow;
        //ordenaAño();
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ordenaAño(){
        let borde = CGFloat(20);
        let espaciado = CGFloat(self.frame.width*0.05);
        var p:CGFloat=0;
        let alto = CGFloat(años[0].frame.height);
        let ancho = CGFloat(self.frame.width);
        for año in años{
            //mes.frame=CGRectMake(borde, borde+((alto+espaciado)*p), alto, ancho);
            p += 1;
            self.addSubview(año);
        }
        //print("años :", años.count);
        self.contentSize=CGSize(width: self.frame.width, height: (((borde*2)+(alto+espaciado))));
    }
    
}
