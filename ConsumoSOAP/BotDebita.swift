//
//  BotDebita.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 1/03/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class BotDebita: UIButton {
    
    var vista: VistaTarjeta!;

    init(frame: CGRect, vista: VistaTarjeta) {
        self.vista=vista;
        vista.isUserInteractionEnabled=false;
        super.init(frame: frame);
        self.addTarget(self, action: #selector(BotDebita.deb), for: .touchDown);
    }
    
    func deb(){
        self.backgroundColor = UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        for vista in self.self.subviews{
            if vista is VistaTarjeta{
                vista.backgroundColor = UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
            }
        }
        DatosB.cont.datosPadre.desbloqueador();
        DatosB.cont.datosPadre.metodo.text=vista.tarjeta.tipo;
        DatosB.cont.datosPadre.metodoV=vista.tarjeta.tipo
        DatosB.cont.datosPadre.tarjeta=vista.tarjeta;
        print("QQdeb: ", vista.tarjeta.terminacion);
        //print("Padre: ", self.superview);
        //print("Abuelo: ", self.superview?.superview);
        //(self.superview?.superview as! VistaMetodos).cierra();
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(BotDebita.autoDestruccion), userInfo: nil, repeats: false);
    }
    
    func autoDestruccion(){
        self.superview?.removeFromSuperview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
