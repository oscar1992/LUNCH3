//
//  MensajeCrea.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class MensajeCrea: UIView {
    
    var mensaje:String;
    var corazon :UIView!;
    var corazon2 : UIImageView!;
    var timer: Timer!;
    var itera = 0;
    var nombresImgs = [UIImage]();
    var timer2 : Timer!;
    var timer3 : Timer!;
    var texto : UILabel!;
    var gif: Bool!;

    
    init (frame: CGRect, msg: String, gif: Bool){
        self.mensaje=msg;
        self.gif=gif;
        super.init(frame: frame);
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 2", framePers: nil, identi: nil, scala: false);
        iniciaImagen();
        iniciaMensaje();
        self.accessibilityIdentifier="msg";
        fondo();
        //cambiaImagen();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func iniciaImagen(){
        let altoIma = self.frame.height;
        let OXima = (self.frame.width/2)-(altoIma/2);
        let OYIma = CGFloat(0);
        let imagenFrame = CGRect(x: OXima, y: OYIma, width: altoIma, height: altoIma);
        corazon=UIView();
        corazon.frame=imagenFrame;
        if(gif == true){
            let imaGif = UIImage.gifImageWithName("LoncheraP3");
            corazon2 = UIImageView();
            corazon2.image = imaGif;
            corazon2.contentMode = UIViewContentMode.scaleAspectFit;
            corazon2.frame=imagenFrame;
            print("Frame: ", corazon2.frame);
            self.addSubview(corazon2);
        }else{
            self.addSubview(corazon);
            DatosB.cont.poneFondoTot(corazon, fondoStr: "LoncheraP1", framePers: nil, identi: "ico", scala: true);
        }
        
        
 
        //
        nombresImagenes();
        
    }
    
    func iniciaMensaje(){
        let ancho = self.frame.width*0.8;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (corazon.frame.height + corazon.frame.origin.y);
        texto = UILabel(frame: CGRect(x: OX, y: OY, width: ancho, height: self.frame.height*0.5));
        print("msg: ", mensaje);
        texto.text = mensaje;
        texto.numberOfLines=5;
        texto.textColor=UIColor.lightGray;
        texto.textAlignment=NSTextAlignment.center;
        texto.adjustsFontSizeToFitWidth=true;
        
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height));
        self.addSubview(texto);
    }
    
    func iniciaImagen2(){
        corazon.removeFromSuperview();
        let altoIma = self.frame.width*0.2;
        let OXima = (self.frame.width/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRect(x: OXima, y: OYIma, width: altoIma, height: altoIma);
        corazon = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(corazon, fondoStr: "ICO Advertencia", framePers: nil, identi: "ico", scala: true);
        self.addSubview(corazon);
    }
    
    func iniciaImagen3(){
        corazon.removeFromSuperview();
        let altoIma = self.frame.width*0.2;
        let OXima = (self.frame.width/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRect(x: OXima, y: OYIma, width: altoIma, height: altoIma);
        corazon = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(corazon, fondoStr: "ICO Feliz", framePers: nil, identi: "ico", scala: true);
        self.addSubview(corazon);
        texto.removeFromSuperview();
        iniciaMensaje();
    }
    
    func iniciaTimer(){
        print("inicia");
        iniciaImagen2();
        texto.removeFromSuperview();
        iniciaMensaje();
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(MensajeCrea.cierra), userInfo: nil, repeats: false);
        
    }
    
    
    func cierra(){
        print("cierra")
        
        self.removeFromSuperview();
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
    
    func nombresImagenes(){
        nombresImgs.append(UIImage(named: "ICO Corazón")!);
        nombresImgs.append(UIImage(named: "ICO Feliz")!);
        //
    }
    
    
    func cambiaImagen(){
        print("Hilo Imagen")
        let hiloImagen = DispatchQueue.GlobalQueuePriority.default;
        DispatchQueue.global(priority: hiloImagen).async {
            self.timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MensajeCrea.iteraImagen), userInfo: nil, repeats: true);
        };
        
    }
    
    func iteraImagen(){
        if(itera==0){
            itera=1;
        }else{
            itera=0;
        }
        print("Itera: ", itera);
        /*
        for vista in corazon.subviews{
            if(vista.accessibilityIdentifier=="ico"){
                vista.removeFromSuperview();
            }
        }
        //print("ima: ", ima);
        var frameFondo = CGRectMake(0, 0, corazon.frame.width, corazon.frame.height);
        let backImg=UIImageView(frame: frameFondo);
        backImg.contentMode=UIViewContentMode.ScaleAspectFit;
        backImg.image=ima;
        backImg.accessibilityIdentifier="ico";
        corazon.addSubview(backImg);
        */
    }
}
