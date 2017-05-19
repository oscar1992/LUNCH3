//
//  VIstaDeseaCancelar.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 4/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VIstaDeseaCancelar: UIView {
    
    var mensaje:String;
    var corazon :UIView!;
    var pedido: Pedido;
    
    init (pedido: Pedido){
        self.pedido=pedido;
        self.mensaje="¿De verdad quieres cancelar tu pedido :( ?";
        let ancho = DatosC.contenedor.anchoP*0.8;
        let alto = DatosC.contenedor.altoP*0.6;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = (DatosC.contenedor.altoP/2)-(alto/2);
        let frameMens = CGRect(x: OX, y: OY, width: ancho, height: alto);
        super.init(frame: frameMens);
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 2", framePers: nil, identi: nil, scala: false);
        iniciaImagen();
        iniciaMensaje();
        iniciaBotones();
        fondo();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func iniciaImagen(){
        let altoIma = self.frame.width*0.2;
        let OXima = (self.frame.width/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRect(x: OXima, y: OYIma, width: altoIma, height: altoIma);
        corazon = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(corazon, fondoStr: "ICO Triste", framePers: nil, identi: "ico", scala: true);
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
    
    func iniciaBotones(){
        let ancho = self.frame.width*0.4;
        let alto = self.frame.height*0.1;
        let OX = (self.frame.width/2)-((ancho))
        let OY = (corazon.frame.height + corazon.frame.origin.y + self.frame.height*0.5);
        let frame1 = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let frame2 = CGRect(x: (OX+frame1.width+5), y: OY, width: ancho, height: alto);
        let bot1 = UIButton(frame: frame1);
        let bot2 = UIButton(frame: frame2);
        self.addSubview(bot1);
        self.addSubview(bot2);
        DatosB.cont.poneFondoTot(bot1, fondoStr: "Botón Aceptar", framePers: nil, identi: nil, scala: false);
        DatosB.cont.poneFondoTot(bot2, fondoStr: "Botón Cancelar", framePers: nil, identi: nil, scala: false);
        bot2.addTarget(self, action: #selector(VIstaDeseaCancelar.cierraVista), for: .touchDown);
        bot1.addTarget(self, action: #selector(VIstaDeseaCancelar.cancelaPedido), for: .touchDown);
    }
    
    func cierraVista(){
        self.removeFromSuperview();
    }
    
    func cancelaPedido(){
        let cancelaWS = CancelaPedido(vista: self);
        cancelaWS.cancelaPedido(pedido);
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
    
    func fin(_ valida: Bool){
        if(valida){
            let vista2 = VistaCancelaFin(mensaje: "¡Cancelamos tu pedido!", valido: valida);
            DatosB.cont.historial.view.addSubview(vista2);
            DatosB.cont.historial.cargas();
        }else{
            let vista2 = VistaCancelaFin(mensaje: "Error en la cancelación del pedido", valido: valida);
            DatosB.cont.historial.view.addSubview(vista2);
        }
        cierraVista();
    }
}
