//
//  Caja2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 6/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Caja2: UIButton {
    
    var id:Int!;
    var nombre: String!;
    var items = [Producto]();
    
    init(frame: CGRect, id: Int, nombre: String, items: [Producto]){
        super.init(frame: frame);
        self.id=id;
        self.nombre=nombre;
        self.items=items;
        self.addTarget(self, action: #selector(Caja2.llena), forControlEvents: .TouchDown);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que llena la lonchera con los items de la caja saludable
    func llena(){
        print("Llena: ", items.count);
        var p = 1;
        DatosB.cont.home2.lonchera.limpia();
        for item in items{
            //print("item: ", item.nombre);
            DatosB.cont.home2.lonchera.setCasilla(p, prod: item);
            p += 1;
        }
        DatosB.cont.home2.lonchera.nombr=self.nombre;
        DatosB.cont.home2.lonchera.actualizaContador();
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
