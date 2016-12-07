//
//  VistaGenero.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaGenero: UIView {
    
    var selects = [Selector]();
    
    override init (frame: CGRect){
        super.init(frame:frame)
        iniciatitulo();
        iniciaSelects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func iniciatitulo(){
        let ancho = self.frame.width*0.5;
        let alto = self.frame.height*0.2;
        let frameTitulo = CGRectMake(0, 0, ancho, alto);
        let titulo = UILabel(frame: frameTitulo);
        titulo.textColor=UIColor.whiteColor();
        titulo.text="Género";
        titulo.font=UIFont(name: "Gotham Bold", size: alto);
        self.addSubview(titulo);
    }
    
    func iniciaSelects(){
        let ancho = self.frame.width*0.15;
        let espacio = self.frame.width*0.06;
        let OY = self.frame.height*0.25;
        let frameSelect1 = CGRectMake(0, OY, ancho, ancho);
        let frameSelect2 = CGRectMake(0, (OY + ancho + espacio), ancho, ancho);
        let select1 = Selector(frame: frameSelect1, genero: "Masculino");
        let select2 = Selector(frame: frameSelect2, genero: "Femenino");
        selects.append(select1);
        selects.append(select2);
        //select1.backgroundColor=UIColor.redColor();
        //select2.backgroundColor=UIColor.yellowColor();
        self.addSubview(select2);
        self.addSubview(select1);
        let frameLabel1 = CGRectMake((ancho), OY, (self.frame.width-ancho), ancho);
        let frameLabel2 = CGRectMake((ancho), (OY + ancho + espacio), (self.frame.width-ancho), ancho);
        let label1 = UILabel(frame: frameLabel1);
        let label2 = UILabel(frame: frameLabel2);
        label1.text="Hombre";
        label2.text="Mujer";
        label2.font=UIFont(name: "Gotham Bold", size: ancho);
        label1.font=UIFont(name: "Gotham Bold", size: ancho);
        label1.textAlignment=NSTextAlignment.Center;
        label2.textAlignment=NSTextAlignment.Center;
        self.addSubview(label1);
        self.addSubview(label2);
        
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
