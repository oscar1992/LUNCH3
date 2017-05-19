//
//  BusquedaProductos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 14/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BusquedaProductos: UIView {
    
    var barraInput: UIView!;
    var espacioResultadi: UIView!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        inciaBarraInput();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inciaBarraInput(){
        let OX = CGFloat(0);
        let OY = CGFloat(0);
        let ancho = CGFloat(0);
        let alto = CGFloat(0);
        let frameInput = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let barra=UIView(frame: frameInput);
        let texto = UITextField(frame: CGRect(x: 0, y: 0, width: ancho, height: alto));
        barra.addSubview(texto);
        self.addSubview(barra);
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
