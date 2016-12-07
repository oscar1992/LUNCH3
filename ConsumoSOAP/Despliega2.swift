//
//  Despliega2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 21/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Despliega2: UIScrollView, UIScrollViewDelegate{
    
    var alto:CGFloat;
    
    init(frame: CGRect, datos: [String]){
        self.alto=frame.height;
        let frameP = CGRectMake(frame.origin.x, frame.height, frame.width, frame.height*3);
        super.init(frame: frameP);
        let alto = iniciaLista(datos);
        print("ret: ", alto);
        self.backgroundColor=UIColor.blueColor();
        self.delegate=self;
        self.contentSize=CGSizeMake(self.frame.width, alto*2);
    }
    
    func iniciaLista(datos: [String])->CGFloat{
        let ancho = self.frame.width;
        //let alto = self.frame.height/1.6;
        //print("alto: ", alto);
        let OX = CGFloat(0);
        var p = CGFloat(0);
        for dato in datos{
            let OY = alto*p;
            let frame = CGRectMake(OX, OY, ancho, alto/2);
            print("frameBot: ", frame);
            iniciaBoton(frame, nombre: dato);
            p += 1;
        }
        
        return (alto*p);
    }
    
    func iniciaBoton(frame: CGRect, nombre:String){
        let bot = BotMetodoPago(frame: frame, texto: nombre);
        bot.addTarget(self, action: #selector(Despliega2.cierraVista), forControlEvents: .TouchDown);
        bot.backgroundColor=UIColor.yellowColor();
        self.addSubview(bot);
    }
    
    func cierraVista(){
        print("cierra")
        self.backgroundColor=UIColor.redColor();
        self.removeFromSuperview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
