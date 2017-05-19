//
//  BotonDias.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 24/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotonDias: UIButton {
    
    var Activo = false;
    var letra : UILabel!;
    var id: Int?
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame);
        
        
        //self.backgroundColor=UIColor.blackColor();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    //Método que Cambia el fondo del botón
    func cambiaFondo(){
        for vista in self.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        var imagen: UIImage;
        if(Activo){
            letra.textColor = UIColor.white;
            imagen = UIImage(named: "DiaS")!;
            //print("Activo");
        }else{
            letra.textColor = UIColor.black;
            imagen = UIImage(named: "DiaN")!;
            //print("No Activo");
        }
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        let backImg = UIImageView(frame: frame);
        backImg.contentMode = UIViewContentMode.scaleAspectFit;
        backImg.image = imagen;
        self.addSubview(backImg);
        self.sendSubview(toBack: backImg);
        
    }
    
    // Método que ponen la letra dependiendo del número asigando
    func poneLetra(_ id: Int){
        self.id=id;
        let letraFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        letra = UILabel(frame: letraFrame);
        letra.font = UIFont(name: "SansBeamHead-Bold", size: 20);
        letra.textAlignment = NSTextAlignment.center;
        //letra.toggleBoldface(nil);
        switch id{
        case 0:
            letra.text = "D";
            break;
        case 1:
            letra.text = "L";
            break;
        case 2:
            letra.text = "M";
            break;
        case 3:
            letra.text = "M";
            break;
        case 4:
            letra.text = "J";
            break;
        case 5:
            letra.text = "V";
            break;
        case 6:
            letra.text = "S";
            break;
        default:
            break;
        }
        self.addSubview(letra);
    }
}
