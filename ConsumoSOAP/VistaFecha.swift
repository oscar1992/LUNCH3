//
//  VistaFecha.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 25/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaFecha: UIView {

    init(opciones: [(String, String, Int)]){
        let ancho = DatosC.contenedor.anchoP*0.8;
        let alto = DatosC.contenedor.altoP*0.4;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = (DatosC.contenedor.altoP/2)-(alto/2);
        let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
        super.init(frame: frameMens);
        iniciaOpciones(opciones);
        fondo();
        titulo();
        cierraBot();
    }
    
    func iniciaOpciones(_ opciones: [(String, String, Int)]){
        let ancho = self.frame.width;
        let alto = self.frame.height/6;
        let OX = CGFloat(0);
        var p = CGFloat(0);
        for opc in opciones{
            let OY = alto*p+(self.frame.height/2)-((alto*CGFloat(opciones.count))/2);
            let frameBot = CGRect(x: OX, y: OY, width: ancho, height: alto);
            let bot=BotFechaEntrega(frame: frameBot, texto: opc.0, texto2: opc.1, id: opc.2);
            self.addSubview(bot);
            p += 1;
        }
    }
    
    func fondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 2", framePers: nil, identi: nil, scala: false);
        let OX = -((DatosC.contenedor.anchoP)-(self.frame.width))/2;
        let OY = -((DatosC.contenedor.altoP)-(self.frame.height))/2;
        let frameB = CGRect(x: OX, y: OY, width: DatosC.contenedor.anchoP, height: DatosC.contenedor.altoP);
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light);
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame=frameB;
        //blurEffectView.layer.zPosition=5;
        self.addSubview(blurEffectView);
        self.sendSubview(toBack: blurEffectView);
    }
    
    func titulo(){
        let ancho = self.frame.width*0.85;
        let alto = self.frame.height/6;
        let OX = CGFloat(0);
        let OY = CGFloat(0);
        let frame = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let titulo = UILabel(frame: frame);
        titulo.text="Selecciona la fecha de entrega de tus loncheras:";
        titulo.font=UIFont(name: "SansBeam Head", size: titulo.frame.height);
        titulo.adjustsFontSizeToFitWidth=true;
        titulo.textAlignment=NSTextAlignment.center;
        self.addSubview(titulo);
    }
    
    func cierraBot(){
        let ancho = self.frame.width*0.1;
        let OX = self.frame.width*0.9;
        let OY = CGFloat(0);
        let frame = CGRect(x: OX, y: OY, width: ancho, height: ancho);
        let botcer = UIButton(frame: frame);
        DatosB.cont.poneFondoTot(botcer, fondoStr: "BotonCerrar", framePers: nil, identi: nil, scala: true);
        botcer.addTarget(self, action: #selector(VistaFecha.cierra), for: .touchDown);
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
