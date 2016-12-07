//
//  BotMetodoPago.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 21/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotMetodoPago: UIButton {
    
    var texto: String;
    
    init(frame: CGRect, texto: String) {
        self.texto=texto;
        super.init(frame: frame);
        let frameLab = CGRectMake(0, 0, frame.width, frame.height);
        let label = UILabel(frame:frameLab);
        label.text=texto;
        label.textAlignment=NSTextAlignment.Center;
        label.font=UIFont(name: "SansBeam Head", size: label.frame.height);
        self.addTarget(self, action: #selector(BotMetodoPago.poneMetodoTimer(_:)), forControlEvents: .TouchDown);
        label.userInteractionEnabled=false;
        self.backgroundColor=UIColor.whiteColor();
        self.addSubview(label);
    }
    
    func poneMetodoTimer(seneder: UIButton){
        self.backgroundColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(BotMetodoPago.poneMetodo), userInfo: nil, repeats: false);
    }
    
    func poneMetodo(){
        DatosB.cont.datosPadre.desbloqueador();
        DatosB.cont.datosPadre.metodo.text=self.texto;
        DatosB.cont.datosPadre.metodoV=self.texto;
        self.superview?.removeFromSuperview();
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
