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
        let frameP = CGRect(x: frame.origin.x, y: frame.height, width: frame.width, height: frame.height*3);
        super.init(frame: frameP);
        let alto = iniciaLista(datos);
        print("ret: ", alto);
        self.backgroundColor=UIColor.blue;
        self.delegate=self;
        self.contentSize=CGSize(width: self.frame.width, height: alto*2);
    }
    
    func iniciaLista(_ datos: [String])->CGFloat{
        let ancho = self.frame.width;
        //let alto = self.frame.height/1.6;
        //print("alto: ", alto);
        let OX = CGFloat(0);
        var p = CGFloat(0);
        for dato in datos{
            let OY = alto*p;
            let frame = CGRect(x: OX, y: OY, width: ancho, height: alto/2);
            print("frameBot: ", frame);
            iniciaBoton(frame, nombre: dato);
            p += 1;
        }
        
        return (alto*p);
    }
    
    func iniciaBoton(_ frame: CGRect, nombre:String){
        let bot = BotMetodoPago(frame: frame, texto: nombre);
        bot.addTarget(self, action: #selector(Despliega2.cierraVista), for: .touchDown);
        bot.backgroundColor=UIColor.yellow;
        self.addSubview(bot);
    }
    
    func cierraVista(){
        print("cierra")
        self.backgroundColor=UIColor.red;
        self.removeFromSuperview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
