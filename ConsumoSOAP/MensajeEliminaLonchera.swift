//
//  MensajeEliminaLonchera.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 23/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class MensajeEliminaLonchera: UIView {

    
    
    var icono:UIView!;
    var texto: UILabel!;
    var id: Int;
    
    init(frame: CGRect, lonchera: Lonchera2, id: Int){
        self.id=id;
        super.init(frame:frame);
        print("añade");
        iniciaImagen();
        iniciaMensaje();
        iniciaBotones();
        //enviaLonchera(lonchera);
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 1", framePers: nil, identi: nil, scala: false);
        
    }
    
    func iniciaImagen(){
        let altoIma = self.frame.height*0.3;
        let OXima = (self.frame.height/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRectMake(OXima, OYIma, altoIma, altoIma);
        icono = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(icono, fondoStr: "ICO Triste", framePers: nil, identi: nil, scala: true);
        self.addSubview(icono);
        
    }
    
    func iniciaMensaje(){
        let ancho = self.frame.width*0.6;
        let OX = (self.frame.width/2)-(ancho/2)
        let OY = (icono.frame.height*1.2 + icono.frame.origin.y);
        texto = UILabel(frame: CGRectMake(OX, OY, ancho, self.frame.height*0.3));
        texto.text = "¿De verdad quieres eliminar esta Lonchera?";
        //texto.lineBreakMode=NSLineBreakMode.ByWordWrapping;
        //texto.numberOfLines=2;
        texto.adjustsFontSizeToFitWidth=true;
        
        texto.textColor=UIColor.lightGrayColor();
        texto.numberOfLines=0;
        texto.textAlignment=NSTextAlignment.Center;
        texto.font=UIFont(name: "SansBeam Head", size: (texto.frame.height/2));
        self.addSubview(texto);
    }
    
    
    func eliminaLonchera(){
        //print("id:", id);
        DatosB.cont.listaLoncheras.removeAtIndex(id);
        var tot = 0;
        for tipos in DatosB.cont.listaLoncheras{
            tot += tipos.1;
        }
        DatosB.cont.home2.botonCarrito.cant.text=String(tot);
        DatosB.cont.carrito.scroll.cargaTipos();
        cierraVista();
    }
    
    
    func cierraVista(){
        self.removeFromSuperview();
    }
    
    func iniciaBotones(){
        let ancho = self.frame.width*0.4;
        let alto = self.frame.height*0.1;
        let OX = (self.frame.width/2)-((ancho))
        let OY = texto.frame.origin.y+texto.frame.height;
        let frame1 = CGRectMake(OX, OY, ancho, alto);
        let frame2 = CGRectMake((OX+frame1.width+5), OY, ancho, alto);
        let bot1 = UIButton(frame: frame1);
        let bot2 = UIButton(frame: frame2);
        self.addSubview(bot1);
        self.addSubview(bot2);
        DatosB.cont.poneFondoTot(bot1, fondoStr: "Botón Aceptar", framePers: nil, identi: nil, scala: true);
        DatosB.cont.poneFondoTot(bot2, fondoStr: "Botón Cancelar", framePers: nil, identi: nil, scala: true);
        bot1.addTarget(self, action: #selector(MensajeEliminaLonchera.eliminaLonchera), forControlEvents: .TouchDown);
        bot2.addTarget(self, action: #selector(MensajeEliminaLonchera.cierraVista), forControlEvents: .TouchDown);
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
