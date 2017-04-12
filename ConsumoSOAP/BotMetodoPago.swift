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
        if(texto == "Crédito"){
            self.addTarget(self, action: #selector(BotMetodoPago.muestraTarjetas(_:)), forControlEvents: .TouchDown);
        }else{
            self.addTarget(self, action: #selector(BotMetodoPago.poneMetodoTimer(_:)), forControlEvents: .TouchDown);
        }
        
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
        DatosB.cont.datosPadre.tarjeta = nil;
        self.superview?.removeFromSuperview();
    }
    
    var vistaTarjetas: VistaWeb2!;
    
    func muestraTarjetas(sender: UIButton){
        DatosB.cont.datosPadre.desbloqueador();
        let ancho = DatosC.contenedor.anchoP*1;
        let alto = DatosC.contenedor.altoP*1;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = (DatosC.contenedor.altoP/2)-(alto/2)
        let frame = CGRectMake(OX, OY, ancho, alto);
        if(vistaTarjetas == nil){
            vistaTarjetas = VistaWeb2(frame: frame);
            
        }
        
        fondo(vistaTarjetas);
        self.superview?.superview?.addSubview(vistaTarjetas);
        
        let list = ListCard(vistaBase: vistaTarjetas);
        list.boton=true;
        list.boton2 = self;
        list.lista();
        
        self.superview?.hidden=true;
        //self.superview?.removeFromSuperview();
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fondo(vista: UIView){
        DatosB.cont.poneFondoTot(vista, fondoStr: "Base 2", framePers: nil, identi: nil, scala: false);
        let frameB = CGRectMake(-DatosC.contenedor.anchoP*0, -DatosC.contenedor.altoP*0, DatosC.contenedor.anchoP, DatosC.contenedor.altoP);
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark);
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame=frameB;
        //blurEffectView.layer.zPosition=5;
        vista.addSubview(blurEffectView);
        vista.sendSubviewToBack(blurEffectView);
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
