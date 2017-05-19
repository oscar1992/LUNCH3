//
//  ScrollTipos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 14/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ScrollTipos: UIScrollView, UIScrollViewDelegate {
    
    var vistas = [VistaTipo]();
    
    override init(frame: CGRect){
        super.init(frame: frame);
        //self.backgroundColor=UIColor.blueColor();
        self.delegate=self;
        cargaTipos();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cargaTipos(){
        let alto = DatosC.contenedor.altoP*0.2;
        var p = 0;
        for vistaV in self.subviews{
            if vistaV is VistaTipo{
                vistaV.removeFromSuperview();
            }
        }
        for tipo in DatosB.cont.listaLoncheras{
            
            let frameVista = CGRect(x: 0, y: alto*CGFloat(p), width: self.frame.width, height: alto);
            let vv = VistaTipo(frame: frameVista, lonc: tipo.0, cant: tipo.1, indi: p);
            self.addSubview(vv);
            p += 1;
        }
        self.contentSize=CGSize(width: self.frame.width, height: alto*CGFloat(p));
    }
    
}
