//
//  Circulo.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 28/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Circulo: UIButton {
    
    var dia: Dia!;
    var Activo = false;
    
    override init(frame: CGRect){
        super.init(frame: frame);
        Fondo(Activo);
        self.accessibilityValue = "Circulo";
        self.addTarget(self, action: #selector(Circulo.activa(_:)), for: .touchDown);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que pone el Fondo del círculo
    func Fondo(_ activo: Bool){
        for vista in self.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        var imagen : UIImage;
        if(activo){
            imagen = UIImage(named: "CirculoS")!;
        }else{
            imagen = UIImage(named: "CirculoN")!;
        }
        
        let frameBack = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        let backImg = UIImageView (frame: frameBack);
        backImg.image=imagen;
        backImg.contentMode=UIViewContentMode.scaleAspectFit;
        self.addSubview(backImg);
        self.sendSubview(toBack: backImg);
    }
    
    //Método que selecciona el día para ser copiado
    func activa(_ sender: UIButton){
        print("Activa?: ", Activo);
        if(Activo){
            var p = 0;
            for diaA in DatosD.contenedor.diasCopia{
                if(dia == diaA){
                    break;
                }
                p += 1;
            }
            DatosD.contenedor.diasCopia.remove(at: p);
            Fondo(false);
            Activo = false;
        }else{
            DatosD.contenedor.diasCopia.append(dia);
            Fondo(true);
            Activo = true;
        }
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
