//
//  FacturaScroll.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 18/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class FacturaScroll: UIScrollView, UIScrollViewDelegate {
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        self.delegate=self;
        self.backgroundColor=UIColor.yellow;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pintaNinos(_ ninos: [BotonNino]){
        let borde = CGFloat(20);
        let espaciado = CGFloat(self.frame.width*0.05);
        var p = CGFloat(0);
        let alto = CGFloat(self.frame.height);
        let ancho = CGFloat(self.frame.width);
        var altoScroll=CGFloat(0)
        
        for nino in ninos{
            let vv = FacturaNino(frame: CGRect(x: borde, y: (borde+p*(alto+espaciado)), width: ancho-(2*borde), height: alto), nino: nino);
            vv.backgroundColor=UIColor.white;
            vv.Nombre!.text = nino.nombreNino;
            //vv.nino=nino;
            self.addSubview(vv);
            p += 1;
            altoScroll += vv.frame.height-CGFloat(20);
            print("alt2",vv.frame.height);
            print("alt", altoScroll);
        }
        self.contentSize=CGSize(width: self.frame.width, height: (borde*2+(CGFloat(ninos.count)*(altoScroll+espaciado))))
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
