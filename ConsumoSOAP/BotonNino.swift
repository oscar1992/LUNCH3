//
//  BotonNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class BotonNino: UIButton {
    
    var panelNino:VistaNino!;
    var activo:Bool!;
    var imagen:UIImage!;
    var nombreNino:String!;
    var fecha:NSDate!;
    var genero:Bool!;
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        activo=false;
        self.addTarget(self, action: #selector(BotonNino.accionM(_:)), forControlEvents: .TouchDown)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func accionM(button:UIButton){
        cambia();
    }
    
    func cambia(){
        let vistaS=DatosC.contenedor.ninos;
        for btn in vistaS{
            let bb=btn;
            
            if(bb.activo==true){
                //print("pasa",bb);
                bb.activo=false;
                bb.panelNino.hidden=true;
                bb.backgroundColor=UIColor.lightGrayColor();
            }
        }
        if(activo==true){
            activo=false;
            
            panelNino.hidden=true;
        }else{
            activo=true;
            self.backgroundColor=UIColor.blueColor();
            
            DatosC.contenedor.loncheras = panelNino.Lonchera.deslizador.paginas;
            DatosC.contenedor.iActual = panelNino.Lonchera.deslizador.quien;
            panelNino.hidden=false;
        }

    }
    
}
