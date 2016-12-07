//
//  LetreroFavorita.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 22/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class LetreroFavorita: UIView {
    
    var corazon: UIView!
    var texto:UILabel!;
    var nomb:UITextField!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 1", framePers: nil, identi: nil, scala: false);
        iniciaImagen();
        iniciaMensaje();
        iniciaTextField();
        iniciaBotones();
        hideKeyboardWhenTappedAround();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func iniciaImagen(){
        let altoIma = self.frame.height*0.3;
        let OXima = (self.frame.height/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRectMake(OXima, OYIma, altoIma, altoIma);
        corazon = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(corazon, fondoStr: "ICO Corazón", framePers: nil, identi: nil, scala: true);
        self.addSubview(corazon);
    }
    
    func iniciaMensaje(){
        let ancho = self.frame.width*0.6;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (corazon.frame.height + corazon.frame.origin.y);
        texto = UILabel(frame: CGRectMake(OX, OY, ancho, self.frame.height*0.25));
        texto.text = "¡Ahora ponle nombre a tu Lonchera favorita!";
        texto.numberOfLines=2;
        texto.textColor=UIColor.lightGrayColor();
        texto.textAlignment=NSTextAlignment.Center;
        texto.adjustsFontSizeToFitWidth=true;
        
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height));
        self.addSubview(texto);
    }
    
    func iniciaTextField(){
        let ancho = self.frame.width*0.8;
        let alto = self.frame.height*0.1;
        let OX = (self.frame.width/2)-(ancho/2);
        let OY = (texto.frame.origin.y + texto.frame.height);
        let frameNomb = CGRectMake(OX, OY, ancho, alto);
        nomb = UITextField(frame: frameNomb);
        nomb.placeholder = "Favorita";
        let frameLinea = CGRectMake(0, nomb.frame.height/2-5, nomb.frame.width, nomb.frame.height);
        DatosB.cont.poneFondoTot(nomb, fondoStr: "Línea división", framePers: frameLinea, identi: nil, scala: true);
        self.addSubview(nomb);
    }
    
    func iniciaBotones(){
        let ancho = self.frame.width*0.4;
        let alto = self.frame.height*0.1;
        let OX = (self.frame.width/2)-((ancho))
        let OY = nomb.frame.origin.y+nomb.frame.height;
        let frame1 = CGRectMake(OX, OY, ancho, alto);
        let frame2 = CGRectMake((OX+frame1.width+5), OY, ancho, alto);
        let bot1 = UIButton(frame: frame1);
        let bot2 = UIButton(frame: frame2);
        self.addSubview(bot1);
        self.addSubview(bot2);
        DatosB.cont.poneFondoTot(bot1, fondoStr: "Botón Aceptar", framePers: nil, identi: nil, scala: true);
        DatosB.cont.poneFondoTot(bot2, fondoStr: "Botón Cancelar", framePers: nil, identi: nil, scala: true);
        bot1.addTarget(self, action: #selector(LetreroFavorita.subeFavorita), forControlEvents: .TouchDown);
        bot2.addTarget(self, action: #selector(LetreroFavorita.cierraVista), forControlEvents: .TouchDown);
    }
    
    func subeFavorita(){
        if(nomb.text == ""){
            DatosB.cont.home2.lonchera.nombr="Favorita";
        }else{
            DatosB.cont.home2.lonchera.nombr=nomb.text;
        }
        
        DatosB.cont.home2.lonchera.subeFavorita();
    }
    
    func cierraVista(){
        DatosB.cont.home2.lonchera.botfavo.enabled=true;
        self.removeFromSuperview();
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.addGestureRecognizer(tap);
    }
    
    func dismissKeyboard() {
        self.endEditing(true)
    }
}
