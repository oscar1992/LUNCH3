//
//  CajaView.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit
import Foundation

class CajaView: UIButton {
    
    var caja : Caja!;
    var Secuencia:String!;
    var ordenActual:Int=0;
    var texto: UILabel!;
    var selimina = false;
    var sobrepaso : Bool!;
    var sobreIndice = 4;
    
    required override init(frame: CGRect) {
        super.init(frame: frame);
        self.addTarget(self, action: #selector(CajaView.muestra(_:)), forControlEvents: .TouchDown);
        sobrepaso = false;
        //iniciaTexto();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que pone los productos de una predeterminada en el home
    func muestra(button:UIButton){
        if(caja.secuencia.count != 0){
            
        
        
        let vistaN=self.superview?.superview! as! VistaNino;
        let desliza = vistaN.Lonchera.deslizador as VistaLonchera;
        DatosC.contenedor.lonchera = desliza.paginas[(desliza.control?.currentPage)!];
        if(desliza.quien<0){
            desliza.quien=0;
        }
        if(DatosC.contenedor.lonchera.subVista?.casillas.count>4){
            let sobre = (DatosC.contenedor.lonchera.subVista?.casillas.count)! - 4;
            for _ in 0 ... sobre{
                DatosC.contenedor.lonchera.remcasilla(self);
            }
            
        }
        DatosC.contenedor.lonchera = desliza.paginas[(desliza.control?.currentPage)!];
        //print("QUIEN: ", (desliza.control?.currentPage)!);
        let subVista = DatosC.contenedor.lonchera;self.caja.secuencia[ordenActual].lista.count
        

        let alto = subVista.subVista?.casillas[0].frame.height;
        let ancho = subVista.subVista?.casillas[0].frame.width;
        var p=0;
        
        
        
        //print("Cant: ",self.caja.secuencia[ordenActual].lista.count);
            for casi in (subVista.subVista?.casillas)!{
                casi.elemeto?.elimina();
            }

        
        if(self.caja.secuencia[ordenActual].lista.count>4 && subVista.subVista?.casillas.count<self.caja.secuencia[ordenActual].lista.count){
            print("> que 4: ", subVista.subVista?.casillas.count);
            for _ in 0..<(self.caja.secuencia[ordenActual].lista.count-4){
                subVista.addcasilla(self);
                //print("oo")
            }
            sobrepaso = true;
        }
        if(caja.secuencia[ordenActual].lista.count <= 4){
            sobrepaso = false;
        }else{
            sobrepaso = true;
        }
            
        for casi in subVista.subVista!.casillas{
           
            if(p>=caja.secuencia[ordenActual].lista!.count){
            
            }
            if(casi.elemeto==nil){
                
            }else{
                print("elimina");
                casi.elemeto!.elimina();
                
            }
            if(self.caja.id == -2){// Caja Favorita
                
                print("casi: ",casi.tipo, " prod: ", caja.secuencia[ordenActual].lista.count);
                if(casi.tipo <= caja.secuencia[ordenActual].lista.count && (casi.tipo != nil || sobrepaso)){
                    let nn=CGRectMake(0, 0, ancho!, alto!);
                    var tit : TItems;
                    if(casi.tipo == nil){
                        print("sobreindice: ", caja.secuencia[ordenActual].lista.count);
                        
                        tit = caja.secuencia[ordenActual].lista[sobreIndice-1];
                        sobreIndice += 1;
                    }else{
                        tit = caja.secuencia[ordenActual].lista[casi.tipo!-1];
                    }
                    
                    let icono=ProductoView(frame: nn, imagen: tit.productos!.imagen!);
                    icono.padre=casi;
                    casi.seteaElemento(icono, tipo: (tit.productos!.tipo)!, ima: tit.productos!.imagen!, prod: tit.productos!);
                    //print("pre casilla: ", casi.elemeto?.producto?.nombre);
                    casi.activo=true;
                    casi.elemeto?.Natural = true;
                    casi.tipo = p+1;
                    casi.bringSubviewToFront(icono);
                    casi.elemeto?.tipo = tit.productos?.tipo;
                    DatosC.contenedor.lonchera.subVista!.casillas[p]=casi;
                    DatosC.contenedor.lonchera.subVista!.casillas[p].addSubview(icono);
                }
                
            }else{

            for Titem in caja.secuencia[ordenActual].lista!{
                //print("item: ", Titem.productos?.nombre);
                //casi.elemeto?.elimina();
                
                if(Titem.productos?.tipo==casi.tipo){
                    
                    let nn=CGRectMake(0, 0, ancho!, alto!);
                    let icono=ProductoView(frame: nn, imagen: Titem.productos!.imagen!);
                    icono.tipo=casi.tipo;
                    icono.producto=Titem.productos;
                    icono.padre=casi;
                    casi.activo=true;
                    casi.elemeto?.Natural = true;
                    casi.tipo = p+1;
                    /*casi.elemeto=icono;
                    casi.activo=true;
                    casi.bringSubviewToFront(icono);*/
                    
                    casi.seteaElemento(icono, tipo: icono.tipo!, ima: Titem.productos!.imagen!, prod: Titem.productos!);
                    //print("casi: ", casi.elemeto?.producto?.nombre);
                    //print("padre: ", casi.elemeto?.padre);
                    DatosC.contenedor.lonchera.subVista!.casillas[p]=casi;
                    casi.addSubview(icono);
                    
                    DatosC.contenedor.lonchera.subVista!.casillas[p].addSubview(icono);
                    print("pos set: ", DatosC.contenedor.lonchera.subVista!.casillas[p].elemeto?.producto?.nombre);
                //}else{
              
                }
                
                }
            }
            print("p: ", p, "caja: ", caja.secuencia[ordenActual].nombre);
            print("caja: ", caja.Nombre);
            if(p>=caja.secuencia[ordenActual].lista!.count&&self.caja.id == -2){
                
                let Cas = casi;
                print("mata: ", Cas.elemeto?.producto?.nombre);
                Cas.elemeto=nil;
                
                DatosC.contenedor.lonchera.subVista!.casillas[p]=Cas;
            }
            for cas in DatosC.contenedor.lonchera.subVista!.casillas{
                print("cas2: ", cas.elemeto?.producto?.nombre);
                cas.activo=true;
            }
            p+=1;
            //print("p: ", p," csai: ", casi.tipo);
            
        }
        if(self.caja.id == -2 ){
            //print("organiza: ", subVista.subVista?.casillas.count);
            sobreIndice = 4;
            subVista.subVista?.crea();
        }
            DatosC.contenedor.lonchera.color = self.caja.id;
            //print("id: ", caja.id);
        DatosC.contenedor.lonchera.contador!.actua();
        //DatosC.contenedor.lonchera.contador?.actua();
        ordenActual+=1;
        if(ordenActual>=caja.secuencia.count){
            ordenActual=0;
        }
            
        }
    }
    //Método que establece el fondo de la caja
    func setFondo(nom: String){
        for vista in self.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        
        var imagen: UIImage;
        //print("nom: ", nom)
        switch nom {
            case "VERDE":
                imagen = UIImage(named: "L1")!;
                break;
            case "ECONOMICA":
                imagen = UIImage(named: "L2")!;
                break;
            case "DIVERTIDA":
                imagen = UIImage(named: "L3")!;
                break;
            case "AZUL":
                imagen = UIImage(named: "L4")!;
                break;
            default:
                imagen = UIImage(named: "L1")!;
            break;
        }
        
        let frame = CGRectMake(0, 0, self.frame.width, self.frame.height);
        let backImg = UIImageView(frame: frame);
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
        self.addSubview(backImg);
        self.sendSubviewToBack(backImg);
    }
    
    //Método que inicia el texto que acompaña a las loncheras
    func iniciaTexto(){
        
        let OY = self.frame.height;
        let alto = DatosC.contenedor.altoP*0.0554;
        let ancho = self.frame.width;
        let frameTexto = CGRectMake(0, OY, ancho, alto);
        texto = UILabel(frame: frameTexto);
        self.addSubview(texto);
        //print("frame: ", frameTexto);

    }
    
    //Método que le da el nombre a las cajas
    func setNombre(nombre: String){
        //print("sett: ", nombre);
        texto.font = UIFont(name: "SansBeam Head", size: 16);
        texto.textAlignment = NSTextAlignment.Center;
        texto.textColor = UIColor.whiteColor();
        texto.text = nombre;
    }
    
    //Método que elimina una caja de la vista
    func elimina(){
        if(selimina){
        self.frame = CGRectMake(0, 0, 0, 0);
        self.backgroundColor = UIColor.blackColor();
        //print("Elimina: ", self.superview);
        //DatosC.contenedor.Pantallap.view.addSubview(self);
        self.removeFromSuperview();
        }
    }
}
