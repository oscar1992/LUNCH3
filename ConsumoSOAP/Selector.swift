//
//  Selector.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Selector: UIButton {
    
    var seleccion = false;
    var nombre: String;
    
    init (frame: CGRect, genero: String){
        self.nombre=genero;
        super.init(frame: frame);
        actuaIma();
        self.addTarget(self, action: #selector(Selector.cambia(_:)), forControlEvents: .TouchDown);
    }
    
    func actuaIma(){
        if(seleccion){
            //print("cambia");
            DatosB.cont.poneFondoTot(self, fondoStr: "Radio Button True", framePers: nil, identi: "sele", scala: true);
        }else{
            DatosB.cont.poneFondoTot(self, fondoStr: "Radio Button False", framePers: nil, identi: "sele", scala: true);
        }
    }
    
    func cambia(sender: AnyObject){
        for sel in (self.superview as! VistaGenero).selects{
            sel.seleccion=false;
            sel.actuaIma();
        }
        if(seleccion){
            seleccion=false;
        }else{
            seleccion=true;
        }
        //print("cccc: ", seleccion);
        actuaIma();
        
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
