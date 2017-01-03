//
//  ScrollEEntregadas.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ScrollEEntregadas: UIScrollView, UIScrollViewDelegate {

    override init(frame: CGRect){
        super.init(frame: frame);
        self.delegate=self;
        //self.backgroundColor=UIColor.yellowColor();
    }
    
    func limpia(){
        for vistas in self.subviews{
            vistas.removeFromSuperview();
        }
    }
    
    func cargaPedidos(pedidos: [Pedido]){
        limpia();
        let alto = DatosC.contenedor.altoP*0.3;
        let ancho = DatosC.contenedor.anchoP;
        let OX = CGFloat(0);
        var p = CGFloat(0);
        var espacio = DatosC.contenedor.altoP*0.02;
        for ped in pedidos{
            let OY = (alto+espacio) * p;
            let frame = CGRectMake(OX, OY, ancho, alto);
            let vista = VistaEntregado(frame: frame, pedido: ped);
            self.addSubview(vista);
            p += 1;
        }
        self.contentSize=CGSizeMake(ancho, ((alto+espacio)*p));
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
