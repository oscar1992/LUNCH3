//
//  ValidaPedido.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 21/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ValidaPedido: UIView {
    
    var corazon :UIView!;

    init(texto: String) {
        let ancho = DatosC.contenedor.anchoP*0.8;
        let alto = DatosC.contenedor.altoP*0.4;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = (DatosC.contenedor.altoP/2)-(alto/2);
        let frameMens = CGRectMake(OX, OY, ancho, alto);
        super.init(frame: frameMens);
        iniciaImagen();
        iniciaMensaje(texto);
        fondo();
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(MensajeCrea.cierra), userInfo: nil, repeats: false);
    }
    
    func iniciaImagen(){
        let altoIma = self.frame.width*0.2;
        let OXima = (self.frame.width/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRectMake(OXima, OYIma, altoIma, altoIma);
        corazon = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(corazon, fondoStr: "ICO Advertencia", framePers: nil, identi: "ico", scala: true);
        self.addSubview(corazon);
    }
    
    func iniciaMensaje(mensaje: String){
        let ancho = self.frame.width*0.8;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (corazon.frame.height + corazon.frame.origin.y);
        let texto = UILabel(frame: CGRectMake(OX, OY, ancho, self.frame.height*0.5));
        //print("msg: ", mensaje);
        texto.text = mensaje;
        texto.numberOfLines=5;
        texto.textColor=UIColor.lightGrayColor();
        texto.textAlignment=NSTextAlignment.Center;
        texto.adjustsFontSizeToFitWidth=true;
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height));
        self.addSubview(texto);
    }
    
    func fondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 2", framePers: nil, identi: nil, scala: false);
        let OX = -((DatosC.contenedor.anchoP)-(self.frame.width))/2;
        let OY = -((DatosC.contenedor.altoP)-(self.frame.height))/2;
        let frameB = CGRectMake(OX, OY, DatosC.contenedor.anchoP, DatosC.contenedor.altoP);
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light);
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame=frameB;
        //blurEffectView.layer.zPosition=5;
        self.addSubview(blurEffectView);
        self.sendSubviewToBack(blurEffectView);
    }
    
    func cierra(){
        print("cierra")
        self.removeFromSuperview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
