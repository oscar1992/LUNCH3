//
//  Casilla.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 4/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Casilla: UIButton {
    
    
    var tipo:Int?;
    var lonchera:LoncheraO!;
    var activo:Bool = true;
    var elemeto:ProductoView?;
    var ultimaPosicion:CGPoint=CGPoint(x: 0,y: 0);
    var precio : UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(Casilla.toca(_:)), for: .touchDown);
        precio = UILabel(frame: CGRect(x: 0, y: self.frame.height*0.9, width: self.frame.width, height: self.frame.height*0.1));
        precio!.backgroundColor = UIColor.white;
        setFondo(true);
        //self.addSubview(precio!);
        //self.backgroundColor=UIColor.magentaColor();
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    //Método de llamdo de la alacena sobre una casilla vacía
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        DatosC.contenedor.lonchera=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
        DatosC.contenedor.tipo=tipo;
        DatosC.contenedor.lonchera=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
        for cs in (DatosC.contenedor.lonchera.subVista?.casillas)!{
            cs.elemeto?.Natural=false;
        }
        //DatosC.contenedor.Pantallap.performSegueWithIdentifier("Seleccion", sender: nil);
        print("fin tocado");
    }
    */
    
    // Método que se llama al tocar la casilla
    func toca(_ sender: AnyObject){
        //print("activo: ", activo);
        if(activo == true){
            
            for BotNino in DatosC.contenedor.ninos{
                if(BotNino.activo == true){
                    //print("iact: ", DatosC.contenedor.iActual);
                    //print("lons: ", BotNino.loncheras.count);
                    if(BotNino.loncheras.count == 0){
                        BotNino.loncheras = DatosC.contenedor.loncheras;
                    }
                    //DatosC.contenedor.lonchera = BotNino.loncheras[DatosC.contenedor.iActual];
                    //print("Cambia: ");
                }
                
            }
            DatosC.contenedor.tipo=tipo!;
            //print("tipo: ", DatosC.contenedor.tipo);
            print("cas frame: ", self.frame);
            //print("QQ: ", DatosC.contenedor.lonchera.fechaVisible?.text);
            //DatosC.contenedor.lonchera=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
            /*for cs in (DatosC.contenedor.lonchera.subVista?.casillas)!{
                cs.elemeto?.Natural=false;
            }*/
            DatosB.cont.home2.performSegue(withIdentifier: "Seleccion", sender: nil);
            //print("fin tocado2");
        }
    }
    
    //Método que permite poner un producto nuevo dentro de la casilla
    func seteaElemento(_ ele: ProductoView, tipo: Int, ima: UIImage, prod: Producto){
        activo = false;
        elemeto = ele;
        elemeto!.producto=prod;
        //elemeto!.imagen = UIImageView(frame: self.frame);
        //elemeto!.imagen!.image = ima;
        elemeto!.padre=self;
        
        let pv = UIImageView(frame: self.frame);
        pv.image=elemeto!.producto?.imagen;
        self.addSubview(pv);
        elemeto?.imagen=pv;
        //print("SETEA: ", elemeto!.producto?.nombre);
        
        self.tipo=tipo;
        //elemeto!.frame=CGRectMake(0, 0, 30, 30);
        //print("Setea: ", elemeto!.frame);
        for vista in self.subviews{
            if vista is UILabel{
                precio!.text = String(prod.precio);
                //print("Precioo");
            }else{
                vista.removeFromSuperview();
            }
            
        }
        setFondo(elemeto!.producto!.salud!);
        self.addSubview(elemeto!);
        //self.bringSubviewToFront(precio!);
    }
    //Mètodo que le da el tamaño al label del precio
    func iniciaPrecio(_ texto: String){
        //print("tt: ", texto);
        precio!.text = texto;
        precio!.frame=CGRect(x: 0, y: self.frame.height*0.8, width: self.frame.width, height: self.frame.height*0.2);
        self.bringSubview(toFront: precio!);
    }
    
    //Método que establece el fondo de una casilla
    func setFondo(_ verde: Bool){
        
        for vista in self.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        
        var imagen: UIImage;
        if(verde){
            imagen = UIImage(named: "CasillaVerde")!;
        }else{
            imagen = UIImage(named: "CasillaBlanca")!;
        }

        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        let backImg = UIImageView(frame: frame);
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
        self.addSubview(backImg);
        
        if(self.elemeto == nil && self.tipo != nil){
            var imagen2: UIImage;
            //print("aguas");
            switch self.tipo! {
            case 1:
                if(verde){
                    imagen2 = UIImage(named: "ICOEnergíaV")!;
                }else{
                    imagen2 = UIImage(named: "ICOEnergíaB")!;
                }
                break;
            case 2:
                if(verde){
                    imagen2 = UIImage(named: "ICOVitaminasV")!;
                }else{
                    imagen2 = UIImage(named: "ICOVitaminasB")!;
                }
                break;
            case 3:
                if(verde){
                    imagen2 = UIImage(named: "ICOCrecimientoV")!;
                }else{
                    imagen2 = UIImage(named: "ICOCrecimientoB")!;
                }
                break;
            case 4:
                if(verde){
                    imagen2 = UIImage(named: "ICOBebidasV")!;
                }else{
                    imagen2 = UIImage(named: "ICOBebidasB")!;
                }
                break;
            default:
                imagen2 = UIImage(named: "CasillaVerde")!;
                break;
            }
            let ancho = frame.width*0.4;
            let OX = (frame.width/2)-(ancho/2);
            let OY = (frame.height/2)-(ancho/2);
            let frame2 = CGRect(x: OX, y: OY, width: ancho, height: ancho);
            let backImg2 = UIImageView(frame: frame2);
            backImg2.image=imagen2;
            backImg2.contentMode=UIViewContentMode.scaleAspectFit;
            self.addSubview(backImg2);
            self.sendSubview(toBack: backImg2);
        }
        self.sendSubview(toBack: backImg);

    }
    
    }
