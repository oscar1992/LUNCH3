//
//  VistaScrollTipo.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaScrollTipo: UIView {
    
    var tipo :((String, Int, Int), [Producto]);
    var idOrden: Int;
    
    init(frame: CGRect, tipo: ((String, Int, Int), [Producto]), id: Int) {
        self.tipo=tipo;
        self.idOrden=id;
        super.init(frame: frame);
        nombre();
        listaProductos()
        iniciaBoton();
        fondo();
        
        //self.backgroundColor=UIColor.grayColor();
    }
    
    func fondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "Base pedido entregado", framePers: nil, identi: nil, scala: false);
    }
    
    func nombre(){
        let alto1 = self.frame.height*0.1;
        let ancho1 = self.frame.width*0.4;
        let OX1 = self.frame.width*0.05;
        let OY1 = self.frame.height*0.08;
        let OY2 = OY1+alto1+OY1;
        let frame1 = CGRect(x: OX1, y: OY1, width: ancho1, height: alto1);
        let frame2 = CGRect(x: OX1, y: OY2, width: ancho1, height: alto1);
        let Lab1 = UILabel(frame: frame1);
        let Lab2 = UILabel(frame: frame2);
        Lab1.text = "Lonchera "+String(idOrden);
        Lab2.text = tipo.0.0;
        Lab1.font=UIFont(name: "Gotham Bold", size: alto1);
        Lab1.textColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        Lab2.font=UIFont(name: "Gotham Bold", size: alto1);
        Lab2.textColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        self.addSubview(Lab1);
        self.addSubview(Lab2);
    }
    
    func listaProductos(){
        let ancho = self.frame.width*0.5;
        let alto = self.frame.height*0.1;
        let OX1 = self.frame.width*0.1;
        let iniY = self.frame.height*0.4;
        var p = CGFloat(0);
        for prod in tipo.1{
            let OY = (alto * p)+iniY;
            let frame = CGRect(x: OX1, y: OY, width: ancho, height: alto);
            let prodNom = UILabel(frame: frame);
            prodNom.text = "·"+prod.nombre!;
            prodNom.font=UIFont(name: "Gotham Bold", size: alto/2);
            self.addSubview(prodNom);
            p += 1;
        }
    }
    
    func iniciaBoton(){
        let ancho = self.frame.width*0.4;
        let alto = self.frame.height*0.1;
        let OX = self.frame.width*0.55;
        let OY = self.frame.height*0.08;
        let frameBot = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let bot = UIButton(frame: frameBot);
        DatosB.cont.poneFondoTot(bot, fondoStr: "Boton AGREGAR", framePers: nil, identi: nil, scala: true);
        bot.addTarget(self, action: #selector(VistaScrollTipo.agrega), for: .touchDown);
        self.addSubview(bot);
        
    }
    
    func agrega(){
        DatosB.cont.home2.lonchera.limpia();
        for n in 1...DatosB.cont.home2.lonchera.casillas.count{
            if((n)<=tipo.1.count){
                print("n: ",n," Items: ", tipo.1[n-1]);
                DatosB.cont.home2.lonchera.setCasilla(n, prod: tipo.1[n-1], salud: false);
            }
        }
        DatosB.cont.home2.lonchera.nombr = tipo.0.0;
        DatosB.cont.home2.anade();
        DatosB.cont.tipos.performSegue(withIdentifier: "Carrito2", sender: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
