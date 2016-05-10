//
//  Predeterminadas.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Predeterminadas: UIScrollView, UIScrollViewDelegate{
    
    var cajas = [CajaView]();
    let borde=CGFloat(20);
    var tamaño:CGFloat!;
    var espaciado:CGFloat!;


    override init(frame: CGRect) {
        super.init(frame: frame);
        self.delegate=self;
        tamaño=self.frame.height*0.8;
        espaciado=CGFloat(self.frame.height*0.05);
        
        for caja in DatosC.contenedor.cajas{
            let cajaBot=CajaView();
            cajaBot.caja=caja;
            cajaBot.backgroundColor=caja.Color;
            cajaBot.setTitle(caja.Nombre, forState: .Normal);
            cajas.append(cajaBot);
        }
        ordenaCajas();
        self.contentSize=CGSizeMake(((borde*2)+(CGFloat(cajas.count)*(tamaño+espaciado))), self.frame.height)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func ordenaCajas(){
        var p:CGFloat=0;
        for cc in cajas{
            cc.frame=CGRectMake(borde+((tamaño+espaciado)*p), self.frame.height*0.1, tamaño, tamaño);
            p+=1;
            self.addSubview(cc);
        }
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
