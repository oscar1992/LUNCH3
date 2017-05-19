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
        let frameTitulo = CGRect(x: 0, y: 0, width: ancho, height: alto);
        let titulo = UILabel(frame: frameTitulo);
        titulo.textColor=UIColor.white;
        titulo.text="Género";
        titulo.font=UIFont(name: "Gotham Bold", size: alto);
        self.addSubview(titulo);
    }
    
    func iniciaSelects(){
        let ancho = self.frame.width*0.15;
        let espacio = self.frame.width*0.06;
        let OY = self.frame.height*0.25;
        let frameSelect1 = CGRect(x: 0, y: OY, width: ancho, height: ancho);
        let frameSelect2 = CGRect(x: 0, y: (OY + ancho + espacio), width: ancho, height: ancho);
        let select1 = Selector(frame: frameSelect1, genero: "Masculino");
        let select2 = Selector(frame: frameSelect2, genero: "Femenino");
        selects.append(select1);
        selects.append(select2);
        //select1.backgroundColor=UIColor.redColor();
        //select2.backgroundColor=UIColor.yellowColor();
        self.addSubview(select2);
        self.addSubview(select1);
        let frameLabel1 = CGRect(x: (ancho), y: OY, width: (self.frame.width-ancho), height: ancho);
        let frameLabel2 = CGRect(x: (ancho), y: (OY + ancho + espacio), width: (self.frame.width-ancho), height: ancho);
        let label1 = UILabel(frame: frameLabel1);
        let label2 = UILabel(frame: frameLabel2);
        label1.text="Hombre";
        label2.text="Mujer";
        label2.font=UIFont(name: "Gotham Bold", size: ancho);
        label1.font=UIFont(name: "Gotham Bold", size: ancho);
        label1.textAlignment=NSTextAlignment.center;
        label2.textAlignment=NSTextAlignment.center;
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
