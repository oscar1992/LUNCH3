//
//  MensajeChulo.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 24/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class MensajeChulo: UIView {

    var icono:UIView!;
    var texto: UILabel!
    
    init (){
        let ancho = DatosC.contenedor.anchoP*0.8
        let ox = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let oy = (DatosC.contenedor.altoP/2)-(ancho/2);
        let frameLet = CGRectMake(ox, oy, ancho, ancho);
        super.init(frame: frameLet);
        _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(MensajeChulo.cierraVista), userInfo: nil, repeats: false);
        iniciaFondo();
        iniciaImagen();
        iniciaMensaje();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func iniciaImagen(){
        let altoIma = self.frame.height*0.3;
        let OXima = (self.frame.height/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRectMake(OXima, OYIma, altoIma, altoIma);
        icono = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(icono, fondoStr: "ChuloVerdeMejor", framePers: nil, identi: nil, scala: true);
        self.addSubview(icono);
    }

    func iniciaMensaje(){
        let ancho = self.frame.width*0.6;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (icono.frame.height + icono.frame.origin.y);
        texto = UILabel(frame: CGRectMake(OX, OY, ancho, self.frame.height*0.25));
        texto.text = "¡Agregaste el producto a La Lonchera!";
        //texto.lineBreakMode=NSLineBreakMode.ByWordWrapping;
        //texto.numberOfLines=2;
        texto.adjustsFontSizeToFitWidth=true;
        texto.textColor=UIColor.lightGrayColor();
        texto.numberOfLines=0;
        texto.textAlignment=NSTextAlignment.Center;
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height/2));
        self.addSubview(texto);
    }
    
    func iniciaFondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 1", framePers: nil, identi: nil, scala: false);
    }
    
    func cierraVista(){
        self.removeFromSuperview();
    }

}
