//
//  ScrollNEntregadas.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ScrollNEntregadas: UIScrollView, UIScrollViewDelegate {

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
    
    func cargaPedidos(_ pedidos: [Pedido]){
        limpia();
        let alto = DatosC.contenedor.altoP*0.3;
        let ancho = DatosC.contenedor.anchoP;
        let OX = CGFloat(0);
        var p = CGFloat(0);
        let espacio = DatosC.contenedor.altoP*0.02;
        for ped in pedidos{
            let OY = (alto+espacio) * p;
            let frame = CGRect(x: OX, y: OY, width: ancho, height: alto);
            let vista = VistaPedido(frame: frame, pedido: ped);
            self.addSubview(vista);
            p += 1;
        }
        self.contentSize=CGSize(width: ancho, height: ((alto+espacio)*p));
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
