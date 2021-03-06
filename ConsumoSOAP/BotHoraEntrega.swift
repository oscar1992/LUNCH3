//
//  BotHoraEntrega.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 25/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotHoraEntrega: UIButton {

    var texto: String;
    init(frame: CGRect, texto: String) {
        self.texto=texto;
        super.init(frame: frame);
        let frameLab = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
        let label = UILabel(frame:frameLab);
        label.text=texto;
        label.textAlignment=NSTextAlignment.center;
        label.font=UIFont(name: "SansBeam Head", size: label.frame.height);
        self.addTarget(self, action: #selector(BotHoraEntrega.poneMetodoTimer(_:)), for: .touchDown);
        label.isUserInteractionEnabled=false;
        label.adjustsFontSizeToFitWidth=true;
        self.backgroundColor=UIColor.white;
        self.addSubview(label);
    }
    
    func poneMetodoTimer(_ seneder: UIButton){
        self.backgroundColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BotHoraEntrega.poneMetodo), userInfo: nil, repeats: false);
    }
    
    func poneMetodo(){
        DatosB.cont.datosPadre.desbloqueador();
        DatosB.cont.datosPadre.texto2.text=self.texto;
        DatosB.cont.datosPadre.hora=self.texto;
        self.superview?.removeFromSuperview();
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
