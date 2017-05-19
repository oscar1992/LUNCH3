//
//  Sumador.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 15/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Sumador: UIView {
    
    var labelPrecio:UILabel!;
    var labelPedido:UILabel!;
    
    
    override init(frame: CGRect){
        super.init(frame: frame);
        //self.backgroundColor=UIColor.whiteColor();
        iniciaPosiciones();
    }
    
    //Método que inicia las posiciones de los frames
    func iniciaPosiciones(){
        let borde = DatosC.contenedor.anchoP*0.02;
        let ancho1 = DatosC.contenedor.anchoP*0.5;
        let ancho2 = DatosC.contenedor.anchoP*0.3;
        let alto = DatosC.contenedor.altoP*0.07;
        let frame1 = CGRect(x: borde, y: (borde), width: ancho1, height: alto);
        let frame2 = CGRect(x: borde, y: (alto), width: ancho1, height: alto);
        let OX1 = self.frame.width - (ancho2+borde);
        let frame3 = CGRect(x: OX1, y: (borde), width: ancho2, height: alto);
        let frame4 = CGRect(x: OX1, y: (alto), width: ancho2, height: alto);
        let msg1 = UILabel(frame: frame1);
        labelPedido = UILabel(frame: frame3);
        let msg2 = UILabel(frame: frame2);
        labelPrecio = UILabel(frame: frame4);
        msg1.text = "Valor del envío";
        msg1.font=UIFont(name: "Gotham Bold", size: msg1.frame.height*0.4);
        msg2.font=UIFont(name: "Gotham Bold", size: msg2.frame.height*0.4);
        labelPrecio.font=UIFont(name: "Gotham Bold", size: msg2.frame.height*0.4);
        labelPedido.font=UIFont(name: "Gotham Bold", size: msg2.frame.height*0.4);
        labelPrecio.textAlignment=NSTextAlignment.right;
        labelPedido.textAlignment=NSTextAlignment.right;
        msg1.textAlignment=NSTextAlignment.left;
        msg2.textAlignment=NSTextAlignment.left;
        msg2.text = "Valor Total";
        msg1.textColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        msg2.textColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        self.addSubview(msg2);
        self.addSubview(msg1);
        self.addSubview(labelPrecio);
        self.addSubview(labelPedido);
    }
    
    //Método que cambia los valores del las etiquetas
    func actuaPrecios(_ precTot: Int, envio: Int){
        let formateadorPrecio = NumberFormatter();
        formateadorPrecio.numberStyle = .currency;
        formateadorPrecio.locale = Locale(identifier: "es_CO");
        
        labelPedido.text=formateadorPrecio.string(from: NSNumber(value: envio));
        //labelPedido.text=formateadorPrecio.string(from: NSNumber((envio)))!;
        labelPrecio.text=formateadorPrecio.string(from: NSNumber(value: precTot))!;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
