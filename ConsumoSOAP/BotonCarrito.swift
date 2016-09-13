//
//  BotonCarrito.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 1/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotonCarrito: UIButton {
    
    var cant:UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        iniciaContador();
        self.addTarget(self, action: #selector(BotonCarrito.pasaCarrito), forControlEvents: .TouchDown);
        //self.backgroundColor=UIColor.yellowColor();
        DatosB.cont.poneFondoTot(self, fondoStr: "Cart", framePers:nil, identi: nil, scala: true);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que inicia el contador del botón del carrito
    func iniciaContador(){
        let ancho = self.frame.width*0.4;
        let OX = self.frame.width-ancho;
        let frameCont = CGRectMake(OX, 0, ancho, ancho);
        let frameNum=CGRectMake(0, 0, ancho, ancho);
        cant=UILabel(frame: frameNum);
        cant.textColor=UIColor.whiteColor();
        cant.textAlignment=NSTextAlignment.Center;
        cant.font=UIFont(name: "SansBeam Head", size: cant.frame.height/2);
        let vista = UIView(frame: frameCont);
        vista.addSubview(cant);
        DatosB.cont.poneFondoTot(vista, fondoStr: "Contador", framePers: nil, identi: nil, scala: true);
        //vista.backgroundColor=UIColor.redColor();
        self.addSubview(vista);
    }
    
    func pasaCarrito(){
        
        DatosB.cont.home2.performSegueWithIdentifier("Carrito", sender: nil);
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
