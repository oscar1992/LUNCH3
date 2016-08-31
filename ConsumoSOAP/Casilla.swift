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
    var ultimaPosicion:CGPoint=CGPointMake(0,0);
    var precio : UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(Casilla.toca(_:)), forControlEvents: .TouchDown);
        precio = UILabel(frame: CGRectMake(0, self.frame.height*0.9, self.frame.width, self.frame.height*0.1));
        precio!.backgroundColor = UIColor.whiteColor();
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
    func toca(sender: AnyObject){
        //print("activo: ", activo);
        if(activo == true){
            print("IACTUAL: ", DatosC.contenedor.iActual);
            for BotNino in DatosC.contenedor.ninos{
                if(BotNino.activo == true){
                    //print("iact: ", DatosC.contenedor.iActual);
                    //print("lons: ", BotNino.loncheras.count);
                    if(BotNino.loncheras.count == 0){
                        BotNino.loncheras = DatosC.contenedor.loncheras;
                    }
                    DatosC.contenedor.lonchera = BotNino.loncheras[DatosC.contenedor.iActual];
                    //print("Cambia: ");
                }
                
            }
            DatosC.contenedor.tipo=tipo;
            print("QQ: ", DatosC.contenedor.lonchera.fechaVisible?.text);
            //DatosC.contenedor.lonchera=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
            for cs in (DatosC.contenedor.lonchera.subVista?.casillas)!{
                cs.elemeto?.Natural=false;
            }
            DatosC.contenedor.Pantallap.performSegueWithIdentifier("Seleccion", sender: nil);
            //print("fin tocado2");
        }
    }
    
    //Método que permite poner un producto nuevo dentro de la casilla
    func seteaElemento(ele: ProductoView, tipo: Int, ima: UIImage, prod: Producto){
        activo = false;
        elemeto = ele;
        elemeto!.producto=prod;
        elemeto!.imagen = UIImageView(frame: self.frame);
        elemeto!.imagen!.image = ima;
        elemeto!.padre=self;
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
    func iniciaPrecio(texto: String){
        //print("tt: ", texto);
        precio!.text = texto;
        precio!.frame=CGRectMake(0, self.frame.height*0.8, self.frame.width, self.frame.height*0.2);
        self.bringSubviewToFront(precio!);
    }
    
    //Método que establece el fondo de una casilla
    func setFondo(verde: Bool){
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
        let frame = CGRectMake(0, 0, self.frame.width, self.frame.height);
        let backImg = UIImageView(frame: frame);
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
        self.addSubview(backImg);
        self.sendSubviewToBack(backImg);

    }
    
    }
