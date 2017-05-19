//
//  VistaDirecciones.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 14/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaDirecciones: UIView {
    
    var direc = [Direcciones]();
    
    init(frame : CGRect, direc: [Direcciones]){
        self.direc=direc;
        super.init(frame: frame);
        print("dir: ", self.direc.count);
        iniciaFondo();
        iniciaLista();
        iniciaBotonCerrar();
    }
    
    func iniciaFondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 1", framePers: nil, identi: nil, scala: false);
    }
    
    func iniciaLista(){
        let ancho = self.frame.width-(self.frame.width*0.07);
        let alto = DatosC.contenedor.altoP*0.05;
        let OX = self.frame.width*0.07;
        var p = CGFloat(0);
        for dir in direc{
            let OY = alto*p;
            let frameBot = CGRect(x: OX, y: OY, width: ancho, height: alto);
            print("frame: ", frameBot);
            iniciaBoton(frameBot, dir: dir);
            p += 1;
        }
    }
    
    func iniciaBoton(_ frame: CGRect, dir: Direcciones){
        let bot = BotDirecciones(frame: frame, dir: dir);
        let frameDir = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
        let labdir = UILabel(frame: frameDir);
        labdir.text=dir.direccion;
        bot.addSubview(labdir);
        bot.addTarget(self, action: #selector(VistaDirecciones.dir(_:)), for: .touchDown);
        self.addSubview(bot);
        bot.backgroundColor=UIColor.green;
    }
    
    func dir(_ bot: BotDirecciones){
        DatosB.cont.nodos.cercania(bot.direccion);
    }
    
    func iniciaBotonCerrar(){
        let ancho = self.frame.width*0.1;
        let OX = self.frame.width-ancho;
        let OY = CGFloat(0);
        let frameBot = CGRect(x: OX, y: OY, width: ancho, height: ancho);
        let bot = UIButton(frame: frameBot);
        bot.addTarget(self, action: #selector(VistaDirecciones.cerrarVista), for: .touchDown);
        self.addSubview(bot);
        DatosB.cont.poneFondoTot(bot, fondoStr: "BotonCerrar", framePers: nil, identi: nil, scala: true);
    }
    
    
    
    func cerrarVista(){
        self.removeFromSuperview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
