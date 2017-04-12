//
//  VistaWeb2.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 6/03/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class VistaWeb2: UIView {
    
    var botCerrar:UIButton!;
    var texto:String!
    var titulo: UILabel!;
    
    override init(frame: CGRect){
        super.init(frame: frame);
        //self.backgroundColor=UIColor.blueColor();
        
        iniciaBoton();
        iniciaTitulo();
        gifCarga(self);
    }
    
    func iniciaBoton(){
        let anchoB = self.frame.width*0.07;
        let OXB = self.frame.width-(anchoB*1);
        let OYB = CGFloat(0);
        let frameCerrar = CGRectMake(OXB, OYB, anchoB, anchoB);
        botCerrar = UIButton(frame: frameCerrar);
        botCerrar.addTarget(self, action: #selector(VistaWeb2.cerrarVista), forControlEvents: .TouchDown);
        DatosB.cont.poneFondoTot(botCerrar, fondoStr: "BotonCerrar", framePers: nil, identi: nil, scala: true);
        self.addSubview(botCerrar);
    }
    
    func cerrarVista(){
        print("boton");
        self.removeFromSuperview();
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
    }
    
    func iniciaTitulo(){
        let alto = self.frame.width*0.1;
        let frameTitulo = CGRectMake(0.5, 0, self.frame.width*0.93, alto);
        titulo = UILabel(frame: frameTitulo);
        titulo.text = texto;
        //titulo.text="Selecciona la tarjeta de crédito con la que deseas pagar la orden";
        titulo.font=UIFont(name: "SansBeam Head", size: titulo.frame.height/2);
        titulo.adjustsFontSizeToFitWidth=true;
        titulo.textAlignment=NSTextAlignment.Center;
        self.addSubview(titulo);
    }
    
    func refrescaTexto(){
        if (titulo != nil){
            titulo.text = texto;
        }
    }
    
    func gifCarga(vistaPadre: UIView){
        let gif = UIImage.gifImageWithName("Cargando");
        let vista = UIImageView(frame: CGRectMake(0, 0, vistaPadre.frame.width, vistaPadre.frame.height));
        vista.image = gif;
        vista.accessibilityIdentifier = "gif";
        vista.contentMode = UIViewContentMode.ScaleAspectFit;
        vistaPadre.addSubview(vista);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
