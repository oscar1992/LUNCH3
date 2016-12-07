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
    var timer: NSTimer!;
    var itera = 0;
    var nombresImgs = [UIImage]();
    var timer2 : NSTimer!;
    var timer3 : NSTimer!;
    var texto : UILabel!;

    
    init (frame: CGRect, msg: String){
        self.mensaje=msg;
        super.init(frame: frame);
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 2", framePers: nil, identi: nil, scala: false);
        iniciaImagen();
        iniciaMensaje();
        iniciaTime3();
        self.accessibilityIdentifier="msg";
        fondo();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func iniciaImagen(){
        let altoIma = self.frame.height;
        let OXima = (self.frame.width/2)-(altoIma/2);
        let OYIma = self.frame.height*0;
        let imagenFrame = CGRectMake(OXima, OYIma, altoIma, altoIma);
        corazon = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(corazon, fondoStr: "LoncheraP1", framePers: nil, identi: "ico", scala: true);
        nombresImagenes();
        self.addSubview(corazon);
    }
    
    func iniciaMensaje(){
        let ancho = self.frame.width*0.8;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (corazon.frame.height + corazon.frame.origin.y);
        texto = UILabel(frame: CGRectMake(OX, OY, ancho, self.frame.height*0.5));
        print("msg: ", mensaje);
        texto.text = mensaje;
        texto.numberOfLines=5;
        texto.textColor=UIColor.lightGrayColor();
        texto.textAlignment=NSTextAlignment.Center;
        texto.adjustsFontSizeToFitWidth=true;
        
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height));
        self.addSubview(texto);
    }
    
    func iniciaImagen2(){
        corazon.removeFromSuperview();
        let altoIma = self.frame.width*0.2;
        let OXima = (self.frame.width/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRectMake(OXima, OYIma, altoIma, altoIma);
        corazon = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(corazon, fondoStr: "ICO Advertencia", framePers: nil, identi: "ico", scala: true);
        self.addSubview(corazon);
    }
    
    func iniciaImagen3(){
        corazon.removeFromSuperview();
        let altoIma = self.frame.width*0.2;
        let OXima = (self.frame.width/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRectMake(OXima, OYIma, altoIma, altoIma);
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
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(MensajeCrea.cierra), userInfo: nil, repeats: false);
        
    }
    
    func iniciaTime3(){
        timer3 = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(MensajeCrea.mataItera), userInfo: nil, repeats: false);

    }
    
    func cierra(){
        print("cierra")
        
        self.removeFromSuperview();
    }
    
    func fondo(){
        let OX = -((DatosC.contenedor.anchoP)-(self.frame.width))/2;
        let OY = -((DatosC.contenedor.altoP)-(self.frame.height))/2;
        let frameB = CGRectMake(OX, OY, DatosC.contenedor.anchoP, DatosC.contenedor.altoP);
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light);
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame=frameB;
        //blurEffectView.layer.zPosition=5;
        self.addSubview(blurEffectView);
        self.sendSubviewToBack(blurEffectView);
    }
    
    func nombresImagenes(){
        nombresImgs.append(UIImage(named: "ICO Corazón")!);
        nombresImgs.append(UIImage(named: "ICO Feliz")!);
        //timer2 = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(MensajeCrea.interaImagen), userInfo: nil, repeats: true);
    }
    
    func interaImagen(){
        if(itera<nombresImgs.count){
            //print("itera: ", nombresImgs[itera]);
            cambiaImagen(nombresImgs[itera]);
            //DatosB.cont.poneFondoTot(corazon, fondoStr: nombresImgs[itera], framePers: nil, identi: "ico", scala: true);
            itera += 1;
        }else{
            itera = 0;
        }
    }
    
    func mataItera(){
        //timer2.invalidate();
        //timer2 = nil;
    }
    
    func cambiaImagen(ima: UIImage){
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
    }
}
