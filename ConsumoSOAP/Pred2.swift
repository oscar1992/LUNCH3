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
        //iniciaCargaCajas();
        //cargaSaludables();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //Método que carga las loncheras saludables y las favoritas
    func cargaSaludables(){
        //evaluaElementos();
        
        if(cini){
            if(cajas.count>0){
                for caja in cajas{
                    caja.removeFromSuperview();
                    //print("remueve");
                }
                cajas.removeAll();
            }
            for vista in self.subviews{
                if vista is UILabel{
                    vista.removeFromSuperview();
                }
            }
            print("PREDE")
            let tot = Double(DatosB.cont.saludables.count)+0.5;
            let ancho = (self.frame.width/CGFloat(tot));
            let alto = ancho * 0.8;
            var p = CGFloat(0);
            //let OY = DatosC.contenedor.altoP*0.05;
            //print("cajas :", tot);
            for cajaS in DatosB.cont.saludables{
                //print("nomb: ", cajaS.nombre);
                let OX = (ancho) * p;
                let frameCaja = CGRect(x: OX, y: 0, width: ancho, height: alto);
                let frameNombre = CGRect(x: OX, y: alto, width: ancho, height: (ancho*0.2));
                let nombre = UILabel(frame: frameNombre);
                nombre.text=cajaS.nombre;
                nombre.textAlignment=NSTextAlignment.center;
                nombre.textColor=UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1);
                nombre.adjustsFontSizeToFitWidth=true;
                nombre.font=UIFont(name: "Gotham Bold", size: nombre.frame.height*0.8);
                
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
                caja.accessibilityIdentifier="Saludable";
                DatosB.cont.poneFondoTot(caja, fondoStr: "LoncheraVerde2", framePers: nil, identi: "Caja", scala: true);
                cajas.append(caja);
                self.addSubview(caja);
                //self.addSubview(nombre);
                p += 1;
                
            }
            let tot2 = Double(DatosB.cont.favoritos.count);
            nombreGrande();
            
            for favo in DatosB.cont.favoritos{
                let OX = ((ancho) * p);
                let frameCaja = CGRect(x: OX, y: 0, width: ancho, height: alto);
                let frameNombre = CGRect(x: OX, y: alto, width: ancho, height: (ancho*0.2));
                let nombre = UILabel(frame: frameNombre);
                //print("framefvao:", frameCaja);
                print("cant: ", DatosB.cont.itemsFavo.count);
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
                nombre.textAlignment=NSTextAlignment.center;
                nombre.textColor=UIColor.init(red: 0, green: 0, blue: 0.5, alpha: 1);
                nombre.font=UIFont(name: "Gotham Bold", size: nombre.frame.height*0.8);
                nombre.adjustsFontSizeToFitWidth=true;
                let caja = Caja2(frame: frameCaja, id: favo.id, nombre: favo.nombre, items: favo.items);
                caja.accessibilityIdentifier="Favorita";
                DatosB.cont.poneFondoTot(caja, fondoStr: "LoncheraAzul2", framePers: nil, identi: "Caja", scala: true);
                cajas.append(caja);
                self.addSubview(caja);
                self.addSubview(nombre);
                p += 1;
                //print("favo: ", favo.nombre);
                //print("favoitts: ", favo.items.count);
                
            }
            if(DatosB.cont.favoritos.count < 5){
                let cc = 5 - DatosB.cont.favoritos.count;
                //print("espacio: ", cc);
                for _ in 0..<cc{
                    let ultFrame = cajas.last?.frame;
                    let OX = ((ancho) * p);
                    let frameN = CGRect(x: OX, y: 0, width: ancho, height: alto);
                    let frameNombre = CGRect(x: OX, y: alto, width: ancho, height: (ancho*0.2));
                    let nombre = UILabel(frame: frameNombre);
                    nombre.text="Vacío";
                    nombre.textAlignment=NSTextAlignment.center;
                    nombre.textColor=UIColor.white;
                    nombre.adjustsFontSizeToFitWidth=true;
                    nombre.font=UIFont(name: "Gotham Bold", size: nombre.frame.height*0.8);
                    let vacia = UIButton(frame: frameN);
                    DatosB.cont.poneFondoTot(vacia, fondoStr: "LoncheraGris2", framePers: nil, identi: "Caja", scala: true);
                    cajas.append(vacia);
                    vacia.addTarget(self, action: #selector(Pred2.limipaLonchera), for: .touchDown);
                    self.addSubview(vacia);
                    self.addSubview(nombre);
                    p += 1;
                }
            }
            //print("tot2: ", cajas.count);
            self.contentSize = CGSize(width: ((ancho)*(CGFloat(10))), height: self.frame.height);
            cini=false;
        }
        cargaSaludableInicial();
    }
    
    //Método que indica a la lonchera a vaciar los productos de su interior
    func limipaLonchera(){
        DatosB.cont.home2.lonchera.limpia();
    }
    
    //Método que llena los productos de una caja favorita
    func llenaFavorito(_ favo: Favoritos){
        /*
        print("dispo");
        for items in DatosB.cont.itemsFavo{
            print("prod: ", items.productos?.nombre)
        }
        */
        if(favo.items.isEmpty){
            print("favorita vacia, inicia llenado")
            for items in DatosB.cont.itemsFavo{
                //print("item id: ", items.id, " favo: ", favo.id);
                if(favo.id == items.id){
                    //print("LLena: ", items.productos.imagen);
                    for prod in DatosC.contenedor.productos{
                        print("prod: ", prod.listaDatos.count);
                            if(items.productos.id == prod.id){
                                
                                favo.items.append(prod);
                            }
                    }
                }
            }
        }
        
        
    }
    
    //Método que pone uan lonchera saludable pre-cargada
    func cargaSaludableInicial(){
        (cajas.first as! Caja2).llena();
        
    }
    
    //Método que pone el nombre grande
    func nombreGrande(){
        let ancho = self.frame.width/CGFloat(1);
        let alto = ancho * 0.2;
        let OX = CGFloat(0);
        let OY = ancho*0.09;
        let frameNombregrande = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let textoG = UILabel(frame: frameNombregrande);
        textoG.textAlignment=NSTextAlignment.center;
        textoG.textColor=UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1);
        textoG.adjustsFontSizeToFitWidth=true;
        textoG.font=UIFont(name: "Gotham Bold", size: textoG.frame.height*0.2);
        textoG.text = "Nuestras loncheras sugeridas";
        self.addSubview(textoG);
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
