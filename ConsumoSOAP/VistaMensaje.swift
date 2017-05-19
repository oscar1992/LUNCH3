//
//  VistaMensaje.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 9/03/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class VistaMensaje: UIView {
    
    var timer: Timer!;
    
    init(msg: String){
        let ancho = DatosC.contenedor.anchoP*0.8;
        let alto = DatosC.contenedor.altoP*0.4;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = (DatosC.contenedor.altoP/2)-(alto/2);
        let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
        super.init(frame: frameMens);
        fondo();
        mensaje(msg);
        autoDestruccion();
    }
    
    func fondo(){
        DatosB.cont.poneFondoTot(self , fondoStr: "Base 2", framePers: nil, identi: nil, scala: true);
    }
    
    func mensaje(_ mensaje: String){
        let ancho = self.frame.width*0.8;
        let alto = self.frame.height*0.4;
        let OX = (self.frame.width/2)-(ancho/2);
        let OY = (self.frame.height/2)-(alto/2);
        let frameMSG = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let msg = UILabel(frame: frameMSG);
        msg.text = mensaje;
        msg.textAlignment=NSTextAlignment.center;
        msg.font=UIFont(name: "SansBeam Head", size: msg.frame.height);
        msg.adjustsFontSizeToFitWidth=true;
        self.addSubview(msg);
    }
    
    func autoDestruccion(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(VistaMensaje.destruye), userInfo: nil, repeats: false);
    }
    
    func destruye(){
        self.isHidden=true;
        self.removeFromSuperview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
