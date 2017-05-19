//
//  RespuestaFavorita.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 22/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class RespuestaFavorita: UIView {
    

    var cajita:UIView!;
    
    init(frame: CGRect, sub: Int) {
        super.init(frame:frame);
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 1", framePers: nil, identi: nil, scala: false);
        iniciaImagen()
        poneMensaje(sub);
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(RespuestaFavorita.cierraLetrero), userInfo: nil, repeats: false);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cierraLetrero(){
        self.removeFromSuperview();
    }
    
    func iniciaImagen(){
        let altoIma = self.frame.height*0.3;
        let OXima = (self.frame.height/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRect(x: OXima, y: OYIma, width: altoIma, height: altoIma);
        cajita = UIView(frame: imagenFrame);
        self.addSubview(cajita);
        
    }
    
    func poneMensaje(_ sub: Int){
        let ancho = self.frame.width*0.6;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (cajita.frame.height*1.2 + cajita.frame.origin.y);
        let msg = UILabel(frame: CGRect(x: OX, y: OY, width: ancho, height: self.frame.height*0.25));
        msg.textColor=UIColor.lightGray;
        msg.numberOfLines=0;
        msg.textAlignment=NSTextAlignment.center;
        msg.font=UIFont(name: "SansBeam Head", size: (msg.frame.height/2));
        msg.adjustsFontSizeToFitWidth=true;
        switch  sub {
        case 1:
            DatosB.cont.poneFondoTot(cajita, fondoStr: "ICO Feliz", framePers: nil, identi: nil, scala: true);
            msg.text="¡Creaste una Lonchera favorita!";
            self.addSubview(msg);
            break;
        case 0:
            DatosB.cont.poneFondoTot(cajita, fondoStr: "ICO Triste", framePers: nil, identi: nil, scala: true);
            msg.text="Eliminaste una Lonchera favorita";
            self.addSubview(msg);
            break;
        case 2:
            DatosB.cont.poneFondoTot(cajita, fondoStr: "ICO Triste", framePers: nil, identi: nil, scala: true);
            msg.text="No hay más espacio";
            self.addSubview(msg);
            break;
        default:
            break;
        }
    }

}
