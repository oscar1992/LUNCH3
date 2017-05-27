//
//  MensajeCiudad.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 05/26/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class MensajeCiudad: UIView {
    
    var icono:UIView!;
    var texto: UILabel!;
    var padre: Carrito;
    
    init(frame: CGRect, carr: Carrito){
        self.padre=carr;
        super.init(frame:frame);
        print("ciudad");
        iniciaImagen();
        iniciaMensaje();
        iniciaBotones();
        //enviaLonchera(lonchera);
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 1", framePers: nil, identi: nil, scala: false);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func iniciaImagen(){
        let altoIma = self.frame.height*0.3;
        let OXima = (self.frame.height/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRect(x: OXima, y: OYIma, width: altoIma, height: altoIma);
        icono = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(icono, fondoStr: "ICO Triste", framePers: nil, identi: nil, scala: true);
        self.addSubview(icono);
        
    }
    
    func iniciaMensaje(){
        let ancho = self.frame.width*0.6;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (icono.frame.height*1.2 + icono.frame.origin.y);
        texto = UILabel(frame: CGRect(x: OX, y: OY, width: ancho, height: self.frame.height*0.3));
        texto.text = "¿Sólo entregamos en la ciudad de bogotá?";
        //texto.lineBreakMode=NSLineBreakMode.ByWordWrapping;
        //texto.numberOfLines=2;
        texto.adjustsFontSizeToFitWidth=true;
        
        texto.textColor=UIColor.lightGray;
        texto.numberOfLines=0;
        texto.textAlignment=NSTextAlignment.center;
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height/2));
        self.addSubview(texto);
    }
    
    func iniciaBotones(){
        let ancho = self.frame.width*0.4;
        let alto = self.frame.height*0.1;
        let OX = (self.frame.width/2)-((ancho))
        let OY = texto.frame.origin.y+texto.frame.height;
        let frame1 = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let frame2 = CGRect(x: (OX+frame1.width+5), y: OY, width: ancho, height: alto);
        let bot1 = UIButton(frame: frame1);
        let bot2 = UIButton(frame: frame2);
        self.addSubview(bot1);
        self.addSubview(bot2);
        DatosB.cont.poneFondoTot(bot1, fondoStr: "Botón Aceptar", framePers: nil, identi: nil, scala: true);
        DatosB.cont.poneFondoTot(bot2, fondoStr: "Botón Cancelar", framePers: nil, identi: nil, scala: true);
        bot1.addTarget(self, action: #selector(MensajeCiudad.siguiente), for: .touchDown);
        bot2.addTarget(self, action: #selector(MensajeCiudad.atras), for: .touchDown);
    }
    
    func siguiente(){
        padre.performSegue(withIdentifier: "Datos", sender: nil);
    }
    
    func atras(){
        padre.dismiss(animated: true, completion: nil);
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
