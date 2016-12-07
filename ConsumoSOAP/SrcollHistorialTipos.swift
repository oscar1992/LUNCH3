//
//  SrcollHistorialTipos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class SrcollHistorialTipos: UIScrollView, UIScrollViewDelegate {

    override init(frame: CGRect){
        super.init(frame: frame);
        self.delegate=self;
        //self.backgroundColor=UIColor.yellowColor();
    }
    
    func cargaTipos(tipos: [((String, Int, Int), [Producto])]){
        let alto = DatosC.contenedor.altoP*0.3;
        let ancho = DatosC.contenedor.anchoP;
        let OX = CGFloat(0);
        var p = CGFloat(0);
        for tipo in tipos{
            let OY = p * alto;
            let frameTipo = CGRectMake(OX, OY, ancho, alto);
            p += 1;
            let vista = VistaScrollTipo(frame: frameTipo, tipo: tipo, id: Int(p));
            self.addSubview(vista);
            print("tipos: ", tipo.0.0);
            
        }
        self.contentSize=CGSizeMake(self.frame.width, (alto*p));
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
