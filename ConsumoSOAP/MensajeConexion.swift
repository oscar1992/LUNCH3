//
//  MensajeConexión.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 30/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class MensajeConexion: UIView {
    
    var msg:String!
    var itera = 0;
    var nombresImgs = [String]();
    var icono: UIView!;
    
    init(frame: CGRect, msg: String?){
        self.msg=msg;
        super.init(frame: frame);
        iniciaFondo();
        subVista();

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func iniciaFondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 2", framePers: nil, identi: nil, scala: false);
        let ancho = self.frame.width*0.2;
        let alto = ancho;
        let OX = (self.frame.width/2)-(ancho/2);
        let OY = self.frame.height*0.1;
        let frameIco = CGRect(x: OX, y: OY, width: ancho, height: alto);
        icono = UIView(frame: frameIco);
        self.addSubview(icono);
        DatosB.cont.poneFondoTot(icono, fondoStr: "ICO Triste", framePers: nil, identi: nil, scala: true);
        let anchoT = self.frame.width*0.8;
        let altoT = self.frame.height*0.3;
        let OXT = (self.frame.width/2)-(anchoT/2);
        let OYT = OY + alto + (self.frame.height*0.1);
        let frameT = CGRect(x: OXT, y: OYT, width: anchoT, height: altoT);
        let mensaje = UILabel(frame: frameT);
        if(msg == nil){
            mensaje.text="Revisa tu conexión a internet";
        }else{
            mensaje.text=msg;
        }
        
        mensaje.numberOfLines=2;
        mensaje.font=UIFont(name: "Gotham Bold", size: mensaje.frame.height);
        mensaje.adjustsFontSizeToFitWidth=true;
        self.addSubview(mensaje);
        //
    }
    
    func iniciaTimer(){
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MensajeConexion.cierra), userInfo: nil, repeats: false);
    }
    
    func cierra(){
        self.removeFromSuperview();
    }
    
    func cancelaCredenciales(){
        UserDefaults.standard.object(forKey: "user")==nil;
        UserDefaults.standard.object(forKey: "pass")==nil;
    }
    

    
    func subVista(){
        let OX = -((DatosC.contenedor.anchoP-self.frame.width)/2)
        let OY = -((DatosC.contenedor.altoP-self.frame.height)/2)
        let frameVista = CGRect(x: OX, y: OY, width: (DatosC.contenedor.anchoP), height: (DatosC.contenedor.altoP));
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light);
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame=frameVista;
        //let vistaFondo = UIView(frame: frameVista);
        //vistaFondo.backgroundColor=UIColor.yellowColor();
        self.addSubview(blurEffectView);
        self.sendSubview(toBack: blurEffectView);
    }
}
