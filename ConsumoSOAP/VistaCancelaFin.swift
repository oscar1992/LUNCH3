//
//  VistaCancelaFin.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 4/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaCancelaFin: UIView {

    var mensaje:String;
    var corazon :UIView!;
    
    init (mensaje: String, valido: Bool){
        self.mensaje=mensaje;
        let ancho = DatosC.contenedor.anchoP*0.8;
        let alto = DatosC.contenedor.altoP*0.4;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = (DatosC.contenedor.altoP/2)-(alto/2);
        let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
        super.init(frame: frameMens);
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 2", framePers: nil, identi: nil, scala: false);
        iniciaImagen(valido);
        iniciaMensaje();
        fondo();
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(VistaCancelaFin.cierra), userInfo: nil, repeats: false);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func iniciaImagen(_ valido: Bool){
        let altoIma = self.frame.width*0.2;
        let OXima = (self.frame.width/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRect(x: OXima, y: OYIma, width: altoIma, height: altoIma);
        corazon = UIView(frame: imagenFrame);
        if(valido){
            DatosB.cont.poneFondoTot(corazon, fondoStr: "ICO Triste", framePers: nil, identi: "ico", scala: true);
        }else{
            DatosB.cont.poneFondoTot(corazon, fondoStr: "ICO Triste", framePers: nil, identi: "ico", scala: true);
        }
        
        self.addSubview(corazon);
    }
    
    func iniciaMensaje(){
        let ancho = self.frame.width*0.8;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (corazon.frame.height + corazon.frame.origin.y);
        let texto = UILabel(frame: CGRect(x: OX, y: OY, width: ancho, height: self.frame.height*0.5));
        //print("msg: ", mensaje);
        texto.text = mensaje;
        texto.numberOfLines=5;
        texto.textColor=UIColor.lightGray;
        texto.textAlignment=NSTextAlignment.center;
        texto.adjustsFontSizeToFitWidth=true;
        
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height));
        self.addSubview(texto);
    }
    
    func fondo(){
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
    
    func cierra(){
        self.removeFromSuperview();
    }
    
}
