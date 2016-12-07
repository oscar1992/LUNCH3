//
//  Cabecera.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 31/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Cabecera: UIView {

    override init(frame: CGRect){
        super.init(frame: frame);
        nombre();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nombre(){
        let ancho = self.frame.width;
        let alto = self.frame.height*0.3;
        let OX = CGFloat(0);
        let OY = self.frame.height*0.7;
        let frame = CGRectMake(OX, OY, ancho, alto);
        let nombre = UILabel(frame: frame);
        nombre.text = DatosD.contenedor.padre.nombre;
        nombre.textAlignment=NSTextAlignment.Center;
        nombre.font = UIFont(name: "Gotham Medium", size: alto/2);
        nombre.textColor=UIColor.whiteColor();
        self.addSubview(nombre);
    }

}
