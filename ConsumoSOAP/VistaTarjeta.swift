//
//  VistaTarjeta.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 24/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class VistaTarjeta: UIView {
    
    var tarjeta: TarjetaEntidad!;
    var elimina: UIButton!;
    var vista: VistaTarjetas?;

    init(frame: CGRect, tarjeta: TarjetaEntidad){
        self.tarjeta=tarjeta;
        super.init(frame: frame);
        self.backgroundColor=UIColor.whiteColor();
        iniciaNombre();
        iniciaNumero();
        botonElimina();
        
    }
    
    func iniciaNombre(){
        let ancho = self.frame.width*0.3;
        let alto = self.frame.height*0.3;
        let OX = self.frame.width*0.05;
        let OY = (self.frame.height/2)-(alto/2);
        let frame = CGRectMake(OX, OY, ancho, alto);
        let nombre = UILabel(frame: frame);
        nombre.text=tarjeta.tipo;
        nombre.font = UIFont(name: "Gotham Medium", size: alto);
        nombre.adjustsFontSizeToFitWidth=true;
        self.addSubview(nombre);
    }
    
    func iniciaNumero(){
        let ancho = self.frame.width*0.3;
        let alto = self.frame.height*0.3;
        let OX = self.frame.width*0.35;
        let OY = (self.frame.height/2)-(alto/2);
        let frame = CGRectMake(OX, OY, ancho, alto);
        let numero = UILabel(frame: frame);
        numero.text = "**** **** **** "+tarjeta.terminacion;
        numero.font = UIFont(name: "SansBeam Head", size: alto);
        numero.adjustsFontSizeToFitWidth=true;
        self.addSubview(numero);
    }
    
    func botonElimina(){
        let ancho = self.frame.width*0.07;
        //let alto = self.frame.height*0.3;
        let OX = self.frame.width*0.7;
        let OY = (self.frame.height/2)-(ancho/2);
        let frame = CGRectMake(OX, OY, ancho, ancho);
        elimina = UIButton(frame: frame);
        DatosB.cont.poneFondoTot(elimina, fondoStr: "BotonCerrar", framePers: nil, identi: nil, scala: true);
        elimina.addTarget(self, action: #selector(VistaTarjeta.mensajeAprueba), forControlEvents: .TouchDown);
        self.addSubview(elimina);
    }
    
    var botonA : UIButton!;
    var botonC : UIButton!;
    var msg : VistaMensaje!;
    
    func mensajeAprueba(){
        msg = VistaMensaje(msg: "¿Deseas eliminar la tarjeta registrada?");
        msg.timer.invalidate();
        let ancho = msg.frame.width * 0.4;
        let espacio = msg.frame.width * 0.05;
        let OX1 = (msg.frame.width-((ancho+espacio)*2))/2;
        let OX2 = OX1+ancho+espacio;
        let alto = msg.frame.height*0.1;
        let OY = msg.frame.height*0.75;
        let frame1 = CGRectMake(OX1, OY, ancho, alto);
        let frame2 = CGRectMake(OX2, OY, ancho, alto);
        botonA = UIButton(frame: frame1);
        botonC = UIButton(frame: frame2);
        botonA.addTarget(self, action: #selector(VistaTarjeta.eliminaTarjeta), forControlEvents: .TouchDown);
        botonC.addTarget(self, action: #selector(VistaTarjeta.cierraMsg), forControlEvents: .TouchDown);
        DatosB.cont.poneFondoTot(botonA, fondoStr: "Botón Aceptar", framePers: nil, identi: nil, scala: false);
        DatosB.cont.poneFondoTot(botonC, fondoStr: "Botón Cancelar", framePers: nil, identi: nil, scala: false);
        msg.addSubview(botonA);
        msg.addSubview(botonC);
        self.superview?.addSubview(msg);
    }
    
    func eliminaTarjeta(){
        //print("Elimina: ", tarjeta.terminacion);
        let delete = DeleteCard(tarjeta: tarjeta);
        delete.vista=self.vista;
        delete.borra();
        let msg = VistaMensaje(msg: "Tarjeta Eliminada");
        self.superview?.addSubview(msg);
        cierraMsg();
    }
    
    func cierraMsg(){
        msg.removeFromSuperview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
