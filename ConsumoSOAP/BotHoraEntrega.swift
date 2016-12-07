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
        let frameLab = CGRectMake(0, 0, frame.width, frame.height);
        let label = UILabel(frame:frameLab);
        label.text=texto;
        label.textAlignment=NSTextAlignment.Center;
        label.font=UIFont(name: "SansBeam Head", size: label.frame.height);
        self.addTarget(self, action: #selector(BotHoraEntrega.poneMetodoTimer(_:)), forControlEvents: .TouchDown);
        label.userInteractionEnabled=false;
        label.adjustsFontSizeToFitWidth=true;
        self.backgroundColor=UIColor.whiteColor();
        self.addSubview(label);
    }
    
    func poneMetodoTimer(seneder: UIButton){
        self.backgroundColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(BotHoraEntrega.poneMetodo), userInfo: nil, repeats: false);
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
