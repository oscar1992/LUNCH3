//
//  LetreroAgregar.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 22/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class LetreroAgregar: UIView {
    
    var icono:UIView!;
    var texto: UILabel!;
    
    init(frame: CGRect, lonchera: Lonchera2){
        super.init(frame:frame);
        print("añade");
        iniciaImagen();
        iniciaMensaje();
        enviaLonchera(lonchera);
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 1", framePers: nil, identi: nil, scala: false);
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(LetreroAgregar.cierraVista), userInfo: nil, repeats: false);
        
    }
    
    func iniciaImagen(){
        let altoIma = self.frame.height*0.3;
        let OXima = (self.frame.height/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRectMake(OXima, OYIma, altoIma, altoIma);
        icono = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(icono, fondoStr: "ICO Cart", framePers: nil, identi: nil, scala: true);
        self.addSubview(icono);
        
    }
    
    func iniciaMensaje(){
        let ancho = self.frame.width*0.6;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (icono.frame.height + icono.frame.origin.y);
        texto = UILabel(frame: CGRectMake(OX, OY, ancho, self.frame.height*0.25));
        texto.text = "¡Listo! Agregaste esta lonchera a tu carrito de compras";
        //texto.lineBreakMode=NSLineBreakMode.ByWordWrapping;
        //texto.numberOfLines=2;
        texto.adjustsFontSizeToFitWidth=true;
        
        texto.textColor=UIColor.lightGrayColor();
        texto.numberOfLines=0;
        texto.textAlignment=NSTextAlignment.Center;
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height/2));
        self.addSubview(texto);
    }

    
    func enviaLonchera(lonchera: Lonchera2){
        DatosB.cont.agregaLonchera(lonchera);
        //DatosB.cont.loncheras.append(lonchera);
        for cas in lonchera.casillas{
            //print("ele: ", cas.elemeto?.producto?.nombre);
            //cas.elemeto?.elimina();
        }
        lonchera.actualizaContador();
        var tot = 0;
        if (DatosB.cont.listaLoncheras.count <= 0){
            tot += 1;
        }else{
            for tipo in DatosB.cont.listaLoncheras{
                tot += tipo.1;
            }
        }
        DatosB.cont.home2.botonCarrito.cant.text=String(tot);
    }
    
    
    func cierraVista(){
        self.removeFromSuperview();
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
