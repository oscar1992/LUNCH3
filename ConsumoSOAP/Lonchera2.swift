//
//  Lonchera2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Lonchera2: UIView {
    
    var casillas = [Casilla]();
    var contador:Contador2!;
    var botfavo:UIButton!;
    var favorita=false;
    
    override init(frame: CGRect){
        super.init(frame: frame);
        iniciaCasillas();
        iniciaTablaDatos();
        iniciaBotonFav();
        DatosB.cont.poneFondoTot(self, fondoStr: "LoncheraVerde", framePers: nil, identi: "loncheraB", scala: false);
        print("ini lonch")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que inicia las casillas de la lonchera
    func iniciaCasillas(){
        let oox = (self.frame.width/2)-((self.frame.width*0.9)/2);
        let ooy = (self.frame.height/2)-((self.frame.height*0.8)/2);
        let frameRef = CGRectMake(oox, ooy, (self.frame.width*0.9), (self.frame.height*0.8));
        let vistaRef = UIView(frame: frameRef);
        //vistaRef.backgroundColor=UIColor.blueColor();
        self.addSubview(vistaRef);
        let ancho = vistaRef.frame.width/2;
        let bordelateral = DatosC.contenedor.anchoP*0.01
        let alto = vistaRef.frame.height/2;
        var p = CGFloat(0);
        var l = CGFloat(0);
        for n in 0...3{
            let OX = ((ancho+bordelateral) * p)+(bordelateral/2);
            let OY = ((alto+bordelateral) * l)+(bordelateral/2);
            let frameCas = CGRectMake((OX), OY, ancho, alto);
            let cas = Casilla(frame: frameCas);
            vistaRef.addSubview(cas);
            cas.tipo=n+1;
            cas.setFondo(true);
            casillas.append(cas);
            p += 1;
            if(p>1){
                p=0;
                l += 1;
            }
            
        }
    }
    
    //Método que inicia la tabla de los datos
    func iniciaTablaDatos(){
        let ancho = self.frame.width;
        let alto = DatosC.contenedor.altoP*0.110;
        let OX = CGFloat(0);
        let OY = self.frame.height;
        let frameLetrero = CGRectMake(OX, OY, ancho, alto);
        contador = Contador2(frame: frameLetrero);
        //contador.backgroundColor=UIColor.blueColor();
        DatosB.cont.poneFondoTot(contador, fondoStr: "BarraValor", framePers: nil, identi: "Contador", scala: false);
        self.addSubview(contador);
    }
    
    //Método que permite poner un elemento en una casilla
    func setCasilla(tipo: Int, prod: Producto){
        for cas in casillas{
            //print("tipo: ", tipo);
            if (cas.tipo == tipo){
                //print("castipo: ", tipo);
                if(cas.elemeto != nil){
                    cas.elemeto?.elimina();
                }
                //cas.seteaElemento(prod, tipo: cas.tipo!, ima: (prod.producto?.imagen)!, prod: prod.producto!);
                
                cas.elemeto?.espacioPadre=cas.frame;
                let imagenN = prod.imagen;
                let prodN=ProductoView(frame: CGRectMake(0, 0, cas.frame.width, cas.frame.height), imagen: imagenN);
                prodN.producto=prod;
                prodN.padre=cas;
                prodN.espacioPadre=CGRectMake(0, 0, cas.frame.width, cas.frame.height)
                cas.elemeto=prodN;
                cas.addSubview(prodN);
            }
        }
        actualizaContador();
    }
    
    //Método que evalua los valores de los productos y el color de la lonchera
    func actualizaContador(){
        print("actua")
        var valor:Int=0;
        var calorias:Int=0;
        var azucar:Int=0;
        var proteina:Int=0;
        var salud = true;
        for cas in casillas{
            if(cas.elemeto != nil){
                print("ele?: ", cas.elemeto?.producto?.nombre);
                for dato in (cas.elemeto?.producto?.listaDatos)!{
                    switch dato.id {
                    case 1:
                        calorias += Int(dato.valor);
                        break;
                    case 3:
                        azucar += Int(dato.valor);
                        break;
                    case 4:
                        proteina += Int(dato.valor);
                        break;
                    default:
                        break;
                    }
                    
                }
                valor += (cas.elemeto?.producto?.precio)!;
                //print("val: ", valor);
                if(cas.elemeto?.producto?.salud==false){
                    salud = false;
                }
            }
            
            
        }
        contador.azucar.text=String(azucar);
        contador.calorias.text=String(calorias);
        contador.proteina.text=String(proteina);
        contador.valor.text=String(valor);
        cambiaColor(salud);
        //print("salud: ", salud);
    }
    
    //Método que cambia el color de la lonchera de verde a blanco
    func cambiaColor(salud: Bool){
        if(salud){
            DatosB.cont.poneFondoTot(self, fondoStr: "LoncheraVerde", framePers: nil, identi: "loncheraB", scala: false);
            for cas in casillas{
                //print("CambiaFondo: ", salud);
                cas.setFondo(salud);
            }
        }else{
            DatosB.cont.poneFondoTot(self, fondoStr: "LoncheraBlanca", framePers: nil, identi: "loncheraB", scala: false);
            for cas in casillas{
                //print("CambiaFondo: ", salud);
                cas.setFondo(salud);
            }
        }
    }
    
    //Método que indica si la lonchera no contiene productos
    func estaLLena()->Bool{
        var llena = false;
        for cas in casillas{
            if(cas.elemeto != nil){
                llena=true;
            }
        }
        return llena;
    }
    
    //Método que limipa la lonchera
    func limpia(){
        for cas in casillas{
            if(cas.elemeto != nil){
                //print("lleno")
                cas.elemeto!.elimina();
                
            }else{
                //print("vacio")
            }
        }
        //actualizaContador();
    }
    
    //Método que inicia el botón de añadir favoritos
    func iniciaBotonFav(){
        botfavo=UIButton();
        var imagen: UIImage;
        imagen = UIImage(named: "BotonF")!;
        
        let OX=self.frame.width*0.9
        let OY=self.frame.height*0.3;
        //let BAOX=(OX+ancho);
        
        let Bancho=(self.frame.width*0.1173);
        let frame = CGRectMake(OX, OY, Bancho, Bancho);
        let frame2 = CGRectMake(0, 0, frame.width, frame.height);
        //print("frameF: ",frame);
        let backImg = UIImageView(frame: frame2);
        botfavo?.frame=frame;
        backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
        botfavo?.addSubview(backImg);
        botfavo?.sendSubviewToBack(backImg);
        botfavo?.addTarget(self, action: #selector(Lonchera2.subeFavorita), forControlEvents: .TouchDown);
        self.addSubview(botfavo!);
        
    }
    
    //Método que sube la lonchera
    func subeFavorita(){
        if(DatosB.cont.favoritos.count<=5){
            if(!favorita ){
                var prds = [Producto]()
                for cas in casillas{
                    if(cas.elemeto != nil){
                        prds.append((cas.elemeto?.producto)!);
                    }
                }
                let sube = SubeFavorito(nombre: "Defecto", prods: prds);
                
                sube.enviaFavorito();
                favorita=true;
                
            }else{
                
                //Remueve
            }
        }else{
            print("se pasó de cajas");
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
