//
//  BotFechaEntrega.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 25/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotFechaEntrega: UIButton {


    var texto: String;
    var text2: String;
    var id: Int;
    
    init(frame: CGRect, texto: String, texto2: String, id: Int) {
        self.text2=texto2;
        self.texto=texto;
        self.id=id;
        super.init(frame: frame);
        let frameLab = CGRectMake(0, 0, frame.width, frame.height);
        let label = UILabel(frame:frameLab);
        label.text=texto;
        label.textAlignment=NSTextAlignment.Center;
        label.font=UIFont(name: "SansBeam Head", size: label.frame.height);
        self.addTarget(self, action: #selector(BotFechaEntrega.poneMetodoTimer(_:)), forControlEvents: .TouchDown);
        label.userInteractionEnabled=false;
        label.adjustsFontSizeToFitWidth=true;
        self.backgroundColor=UIColor.whiteColor();
        self.addSubview(label);
    }
    
    func poneMetodoTimer(seneder: UIButton){
        self.backgroundColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
         _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(BotFechaEntrega.poneMetodo), userInfo: nil, repeats: false);
    }
    
    func poneMetodo(){
        DatosB.cont.datosPadre.texto.text=self.texto;
        DatosB.cont.datosPadre.fecha=self.text2;
        DatosB.cont.datosPadre.idFecha=self.id;
        self.superview?.removeFromSuperview();
        DatosB.cont.datosPadre.desbloqueador();
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
