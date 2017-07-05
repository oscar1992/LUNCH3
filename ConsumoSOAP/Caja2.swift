//
//  Caja2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 6/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Caja2: UIButton {
    
    var id:Int!;
    var nombre: String!;
    var items = [Producto]();
    
    override init(frame: CGRect){
        super.init(frame: frame);
        self.addTarget(self, action: #selector(Caja2.llena), for: .touchDown);
    }
    
    init(frame: CGRect, id: Int, nombre: String, items: [Producto]){
        super.init(frame: frame);
        self.id=id;
        self.nombre=nombre;
        self.items=items;
        self.addTarget(self, action: #selector(Caja2.llena), for: .touchDown);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que llena la lonchera con los items de la caja saludable
    func llena(){
        print("Llena: ", items.count);
        var p = 1;
        DatosB.cont.home2.lonchera.limpia();
        for item in items{
            print("item: ", item.nombre);
            if (self.accessibilityIdentifier=="Saludable"){
                DatosB.cont.home2.lonchera.setCasilla(item.tipo, prod: item, salud: true);
            }
            if(self.accessibilityIdentifier=="Favorita"){
                //print("ItemF: ", item.nombre)
                DatosB.cont.home2.lonchera.setCasilla(p, prod: item, salud: false);
            }
            if(self.accessibilityIdentifier=="vacia"){
                //print("ItemF: ", item.nombre)
                
            }
            
            p += 1;
        }
        for caja in DatosB.cont.home2.predeterminadas.cajas{
            if (caja is Caja2 && caja.accessibilityIdentifier=="Saludable"){
                DatosB.cont.poneFondoTot(caja, fondoStr: "LoncheraVerde2", framePers: nil, identi: "Caja", scala: true);
            }
            if(caja is Caja2 && caja.accessibilityIdentifier=="Favorita"){
                DatosB.cont.poneFondoTot(caja, fondoStr: "LoncheraAzul2", framePers: nil, identi: "Caja", scala: true);
            }
            if(caja is Caja2 && caja.accessibilityIdentifier=="vacia"){
                DatosB.cont.poneFondoTot(caja, fondoStr: "LoncheraGris2", framePers: nil, identi: "Caja", scala: true);
            }
        }
        DatosB.cont.home2.lonchera.nombr=self.nombre;
        DatosB.cont.home2.lonchera.actualizaContador();
        if(self.accessibilityIdentifier=="Saludable"){
            DatosB.cont.poneFondoTot(self, fondoStr: "LoncheraVerde(activo)", framePers: nil, identi: "Caja", scala: true);
        }
        if(self.accessibilityIdentifier=="Favorita"){
            DatosB.cont.poneFondoTot(self, fondoStr: "Favorita(Activa)", framePers: nil, identi: "Caja", scala: true);
        }
        if(self.accessibilityIdentifier=="vacia"){
            print("vacia");
            DatosB.cont.poneFondoTot(self, fondoStr: "LoncheraGris3", framePers: nil, identi: "Caja", scala: true);
        }
        print("fin llena");
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
