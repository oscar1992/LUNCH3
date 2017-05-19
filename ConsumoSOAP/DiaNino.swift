//
//  DiaNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 19/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class DiaNino: UIView {
    
    
    var lonchera:LoncheraO?;
    var Precio:UILabel?;
    var Fecha:UILabel?;
    var facturaNino: FacturaNino?;
    var ancho: CGFloat?;
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor=UIColor.blue;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inicia(_ framePadre: CGRect)->Int{
        
        Fecha=UILabel(frame : CGRect(x: 25, y: 0, width: 200, height: 30));
        Fecha?.text=lonchera?.fechaVisible?.text;
        self.addSubview(Fecha!);
        var p = 0;
        let alto=CGFloat(30);
        let espaciado = CGFloat(10);
        let borde = CGFloat(30);
        for ele in (lonchera?.subVista?.casillas)!{
            if(ele.elemeto?.producto != nil){
                //print("ele: ", ele.elemeto?.producto?.nombre);
                let vproducto=UIView(frame: CGRect(x: 0, y: ((alto+espaciado)*CGFloat(p))+borde, width: framePadre.width, height: alto));
                    vproducto.backgroundColor=UIColor.lightGray;
                let nombre = UILabel(frame: CGRect(x: 0, y: 0, width: vproducto.frame.width/2, height: vproducto.frame.height));
                let precio = UILabel(frame: CGRect(x: vproducto.frame.width/2, y: 0, width: vproducto.frame.width/2, height: vproducto.frame.height));
                nombre.text=ele.elemeto?.producto?.nombre;
                precio.text=String(ele.elemeto!.producto!.precio);
                vproducto.addSubview(nombre);
                vproducto.addSubview(precio);
                self.addSubview(vproducto);
                p += 1;
            }
        }
        return p;
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
