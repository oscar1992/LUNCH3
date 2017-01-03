//
//  MensajeCierra.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 24/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class MensajeCierra: UIView {

    var icono:UIView!;
    var texto: UILabel!
    
    init (){
        let ancho = DatosC.contenedor.anchoP*0.8
        let ox = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let oy = (DatosC.contenedor.altoP/2)-(ancho/2);
        let frameLet = CGRectMake(ox, oy, ancho, ancho);
        super.init(frame: frameLet);
        //_ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MensajeChulo.cierraVista), userInfo: nil, repeats: false);
        iniciaFondo();
        iniciaImagen();
        iniciaMensaje();
        iniciaBotones();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func iniciaImagen(){
        let altoIma = self.frame.height*0.3;
        let OXima = (self.frame.height/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRectMake(OXima, OYIma, altoIma, altoIma);
        icono = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(icono, fondoStr: "ICO Triste", framePers: nil, identi: nil, scala: true);
        self.addSubview(icono);
        
    }
    
    func iniciaMensaje(){
        let ancho = self.frame.width*0.6;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (icono.frame.height + icono.frame.origin.y);
        texto = UILabel(frame: CGRectMake(OX, OY, ancho, self.frame.height*0.25));
        texto.text = "¿De verdad quieres salir :( ? Te estaremos esperando!";
        //texto.lineBreakMode=NSLineBreakMode.ByWordWrapping;
        //texto.numberOfLines=2;
        texto.adjustsFontSizeToFitWidth=true;
        texto.textColor=UIColor.lightGrayColor();
        texto.numberOfLines=0;
        texto.textAlignment=NSTextAlignment.Center;
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height/2));
        self.addSubview(texto);
    }
    
    func iniciaBotones(){
        let ancho = self.frame.width*0.4;
        let alto = self.frame.height*0.1;
        let OX = (self.frame.width/2)-((ancho))
        let OY = texto.frame.origin.y+texto.frame.height;
        let frame1 = CGRectMake(OX, OY, ancho, alto);
        let frame2 = CGRectMake((OX+frame1.width+5), OY, ancho, alto);
        let bot1 = UIButton(frame: frame1);
        let bot2 = UIButton(frame: frame2);
        self.addSubview(bot1);
        self.addSubview(bot2);
        DatosB.cont.poneFondoTot(bot1, fondoStr: "Botón Aceptar", framePers: nil, identi: nil, scala: true);
        DatosB.cont.poneFondoTot(bot2, fondoStr: "Botón Cancelar", framePers: nil, identi: nil, scala: true);
        bot1.addTarget(self, action: #selector(MensajeCierra.cierra), forControlEvents: .TouchDown);
        bot2.addTarget(self, action: #selector(MensajeCierra.cierraVista), forControlEvents: .TouchDown);
    }
    
    func cierra(){
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "user");
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "pass");
        DatosB.cont.home2.dismissViewControllerAnimated(false, completion: nil);
    
        DatosB.cont.cargaProductos=true;
        if(DatosC.contenedor.pantallaSV.contenedor != nil){
            DatosC.contenedor.pantallaSV.contenedor.removeFromSuperview();
        }
        DatosB.cont.favoritos=[Favoritos]();
        DatosB.cont.saludables=[Saludable]();
        DatosD.contenedor.categorias.removeAll();
        DatosC();
        DatosD();
    }
    
    func iniciaFondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 1", framePers: nil, identi: nil, scala: false);
    }
    
    func cierraVista(){
        self.removeFromSuperview();
    }

}