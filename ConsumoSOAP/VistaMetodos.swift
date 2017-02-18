//
//  VistaMetodos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 24/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaMetodos: UIView {

    init(opciones: [String]){
        let ancho = DatosC.contenedor.anchoP*0.8;
        let alto = DatosC.contenedor.altoP*0.4;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = (DatosC.contenedor.altoP/2)-(alto/2);
        let frameMens = CGRectMake(OX, OY, ancho, alto);
        super.init(frame: frameMens);
        iniciaOpciones(opciones);
        fondo();
        titulo();
        cierraBot();
    }
    
    func iniciaOpciones(opciones: [String]){
        let ancho = self.frame.width;
        let alto = self.frame.height/5;
        let OX = CGFloat(0);
        var p = CGFloat(0);
        for opc in opciones{
            let OY = alto*p+(self.frame.height/2)-((alto*CGFloat(opciones.count))/2);
            let frameBot = CGRectMake(OX, OY, ancho, alto);
            let bot=BotMetodoPago(frame: frameBot, texto: opc);
            self.addSubview(bot);
            p += 1;
        }
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
    
    
    func titulo(){
        let ancho = self.frame.width*0.9;
        let alto = self.frame.height/6;
        let OX = CGFloat(0);
        let OY = CGFloat(0);
        let frame = CGRectMake(OX, OY, ancho, alto);
        let titulo = UILabel(frame: frame);
        titulo.text="Selecciona tu método de pago:";
        titulo.font=UIFont(name: "SansBeam Head", size: titulo.frame.height);
        titulo.adjustsFontSizeToFitWidth=true;
        titulo.textAlignment=NSTextAlignment.Center;
        self.addSubview(titulo);
    }
    
    func cierraBot(){
        let ancho = self.frame.width*0.1;
        let OX = self.frame.width*0.9;
        let OY = CGFloat(0);
        let frame = CGRectMake(OX, OY, ancho, ancho);
        let botcer = UIButton(frame: frame);
        DatosB.cont.poneFondoTot(botcer, fondoStr: "BotonCerrar", framePers: nil, identi: nil, scala: true);
        botcer.addTarget(self, action: #selector(VistaMetodos.cierra), forControlEvents: .TouchDown);
        self.addSubview(botcer);
    }
    
    func cierra(){
        DatosB.cont.datosPadre.desbloqueador();
        self.removeFromSuperview();
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
