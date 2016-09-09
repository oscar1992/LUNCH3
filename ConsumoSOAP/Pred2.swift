//
//  Pred2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 1/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Pred2: UIScrollView, UIScrollViewDelegate {
    
    var cajas = [UIButton]();
    var cini = true;
    
    override init(frame: CGRect){
        super.init(frame: frame);
        self.delegate=self;
        
        //cargaSaludables();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que evalua los elementos den el singleton
    func evaluaElementos(){
        print("prodSa: ", DatosB.cont.prodSaludables.count);
        print("Titems: ", DatosB.cont.itemsFavo.count);
        if(DatosB.cont.prodSaludables.count==0){
            
            for salu in DatosB.cont.saludables{
                let cargaS = CargaProductoSalud();
                cargaS.cargaSaludables();
            }
        }
        if(DatosB.cont.itemsFavo.count==0){
            print("Vacio");
            
            for favo in DatosB.cont.favoritos{
                let cargaF = CargaItemsFavoritos(favo: favo)
                cargaF.carga(favo.id);
            }
            cini = true;
        }
    }
    
    func cargaSaludables(){
        //evaluaElementos();
        if(cini){
            print("PREDE")
            let tot = Double(DatosB.cont.saludables.count)+0.5;
            let ancho = self.frame.width/CGFloat(tot);
            let alto = ancho * 0.8;
            var p = CGFloat(0);
            
            //print("cajas :", tot);
            for cajaS in DatosB.cont.saludables{
                //print("nomb: ", cajaS.nombre);
                let OX = (ancho) * p;
                let frameCaja = CGRectMake(OX, 0, ancho, alto);
                let frameNombre = CGRectMake(OX, alto, ancho, (ancho*0.2));
                let nombre = UILabel(frame: frameNombre);
                nombre.text=cajaS.nombre;
                nombre.textAlignment=NSTextAlignment.Center;
                nombre.textColor=UIColor.whiteColor();
                nombre.font=UIFont(name: "SansBeam Head", size: nombre.frame.height/2)
                //print("Frame Caja:", frameCaja);
                var produs = [Producto]();
                
                for itemS in DatosB.cont.prodSaludables{
                    //print("salud: ", cajaS.idSalud);
                    //print("items id: ", itemS.salu.idSalud);
                    if(itemS.salu.idSalud==cajaS.idSalud){
                        //print("ana: ", itemS.produ.nombre);
                        produs.append(itemS.produ)
                    }
                }
                let caja = Caja2(frame : frameCaja, id: cajaS.idSalud, nombre: cajaS.nombre, items: produs);
                DatosB.cont.poneFondoTot(caja, fondoStr: "L1", framePers: nil, identi: "Caja", scala: true);
                cajas.append(caja);
                self.addSubview(caja);
                self.addSubview(nombre);
                
                p += 1;
                
            }
            let tot2 = Double(DatosB.cont.favoritos.count);
            
            
            for favo in DatosB.cont.favoritos{
                let OX = ((ancho) * p);
                let frameCaja = CGRectMake(OX, 0, ancho, alto);
                let frameNombre = CGRectMake(OX, alto, ancho, (ancho*0.2));
                let nombre = UILabel(frame: frameNombre);
                //print("framefvao:", frameCaja);
                //print("cant: ", DatosB.cont.itemsFavo.count);
                //favo.items.removeAll();
                /*
                for titem in DatosB.cont.itemsFavo{
                    print("tit: ", titem.productos?.nombre);
                    if(titem.id==favo.id){
                        print("titems: ", titem.id, " favo: ", favo.id, " prod: ", titem.productos?.nombre);
                        favo.items.append(titem.productos!);
                    }
                }*/
                llenaFavorito(favo);
                nombre.text=favo.nombre;
                nombre.textAlignment=NSTextAlignment.Center;
                nombre.textColor=UIColor.whiteColor();
                nombre.font=UIFont(name: "SansBeam Head", size: nombre.frame.height/2);
                let caja = Caja2(frame: frameCaja, id: favo.id, nombre: favo.nombre, items: favo.items);
                DatosB.cont.poneFondoTot(caja, fondoStr: "L4", framePers: nil, identi: "Caja", scala: true);
                cajas.append(caja);
                self.addSubview(caja);
                self.addSubview(nombre);
                p += 1;
                //print("favo: ", favo.nombre);
                //print("favoitts: ", favo.items.count);
                
            }
            //print("tot2: ", tot2);
            self.contentSize = CGSizeMake(((ancho)*(CGFloat(tot+tot2))), self.frame.height);
            cini=false;
        }
        
    }
    
    //Método que llena los productos de una caja favorita
    func llenaFavorito(favo: Favoritos){
        print("dispo");
        for items in DatosB.cont.itemsFavo{
            print("prod: ", items.productos?.nombre)
        }
        
        for items in DatosB.cont.itemsFavo{
            if(favo.id == items.id){
                favo.items.append(items.productos!);
            }
        }
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
