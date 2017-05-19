//
//  FacturaNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 19/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class FacturaNino: UIView {
    
    var Nombre: UILabel?;
    var Fecha:UILabel?;
    var yini=CGFloat(0);
    
    var dias : [Dia]?;
    
    
    required init(frame: CGRect, nino: BotonNino) {
        super.init(frame: frame);
        
        Nombre = UILabel(frame: CGRect(x: (self.frame.width/2-100), y: 0, width: CGFloat(100), height: 30));
        //print("sema: ",nino.nombreNino,"--" ,nino.panelNino.mesActual);
        _=0;
        _=CGFloat(10);
        _ = CGFloat(30);
        /*
        for sema in (nino.panelNino.mesActual?.semanas)!{
            
            for dia in sema.dias{
                //print("dia: ", dia.lonchera);
                
                if(dia.lonchera != nil){
                    let vistaDia = DiaNino();
                    print("DD: ",dia.lonchera!.fecha, " -- ", dia.numDia);
                    dia.lonchera?.cambiaFecha(dia.numDia!);
                    print("DD: ",dia.lonchera!.fecha, " -- ", dia.numDia);
                    vistaDia.lonchera=dia.lonchera;
                    vistaDia.facturaNino=self;
                    let alto = CGFloat(vistaDia.inicia(frame) * 50);
                    //print(alto);
                    vistaDia.frame=CGRectMake(0, (borde+(CGFloat(yini))), self.frame.width, CGFloat(alto));
                    //
                    self.addSubview(vistaDia);
                    yini += alto+espaciado;
                    p += 1;
                    
                    
                }
            }
            
        }
         */
        print(yini);
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: yini)
        self.addSubview(Nombre!);
        
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
