//
//  VistaNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit
class VistaNino: UIView {
    
    var titulo:UILabel!;
    var EspacioLoncheras:Predeterminadas!;
    var Lonchera:Contenedor!;
    var mesActual:Mes?;
    var padre:BotonNino?;
    var barraD : UIView?;
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame);
        self.accessibilityIdentifier="VN";
        titulo=UILabel(frame: CGRectMake(10, 10, 100, 20));
        //self.addSubview(titulo);
        titulo.text="Vista";
        titulo.textColor=UIColor.blackColor();
        EspacioLoncheras = Predeterminadas(frame: CGRectMake(0, 0, DatosC.contenedor.anchoP, (DatosC.contenedor.altoP*0.16866)));
        EspacioLoncheras.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.0);
        self.addSubview(EspacioLoncheras);
        Lonchera=Contenedor(frame: CGRectMake(0, (EspacioLoncheras.frame.origin.y+EspacioLoncheras.frame.height), DatosC.contenedor.anchoP, (DatosC.contenedor.altoP*0.6391)));
        Lonchera.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.0);
        self.addSubview(Lonchera);
        let bot=UIButton(frame: CGRectMake(CGFloat(DatosC.contenedor.anchoP/2), (Lonchera.frame.height+Lonchera.frame.origin.y-20), 100, 30));
        bot.backgroundColor=UIColor.blueColor();
        bot.addTarget(self, action: #selector(VistaNino.lee(_:)), forControlEvents: .TouchDown)
        //self.addSubview(bot);
        //self.bringSubviewToFront(bot);
        iniciaBotCalendario();
        //self.frame = CGRectMake(0, 0, 300, 300);
        //self.backgroundColor = UIColor.blueColor();
        self.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.0);
        barraDias();
        //poneSaludable();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Método que se usará con fines de leer una lonchrea (DEBUG)
    func lee(sender: UIButton){
        //var scroll = Lonchera.deslizador.mueveAPosicion(DatosC.contenedor.loncheras[DatosC.contenedor.iActual+3])
        print("iact: ", DatosC.contenedor.iActual);
        let lonc = DatosC.contenedor.lonchera;
        print("QUIEN: ",lonc.fechaVisible?.text);
        for cas in (lonc.subVista?.casillas)!{
            print("cas: ",cas.elemeto?.producto?.nombre);
            //print("FRrame: ", cas.superview?.superview?.frame);
        }
    }
    
    //Método de inicializaión de la barra de los días
    func barraDias(){
        let ancho = DatosC.contenedor.anchoP*0.6006
        let alto = DatosC.contenedor.altoP*0.04;
        let OY = EspacioLoncheras.frame.height+DatosC.contenedor.altoP*0.0239;
        let OX = DatosC.contenedor.anchoP*0.3444;
        
        let frameBarra = CGRectMake(OX, OY, ancho, alto);
        barraD = UIView(frame: frameBarra);
        let ancho2 = ancho/CGFloat(Lonchera.deslizador.paginas.count);
        var p = 1;//Día de inicio
        for _ in Lonchera.deslizador.paginas{
            let OX = CGFloat(p-1)*ancho2;
            let frameBoton = CGRectMake(OX, 0, ancho2, barraD!.frame.height);
            //print("Frame: ", frameBoton);
            let dia = BotonDias(frame: frameBoton);
            dia.poneLetra(p);
            dia.cambiaFondo();
            barraD!.addSubview(dia);
            p += 1;
        }
        //barra.backgroundColor=UIColor.brownColor();
        cambiaLonchera(1);//Activa dia
        self.addSubview(barraD!);
    }
    
    //Método que cambiará a una lonchera indicada
    func cambiaLonchera(qq: Int){
        for dia in (barraD?.subviews as! [BotonDias]){
            if(dia.id == qq){
                //print("aa");
                dia.Activo=true;
            }else{
                //print("nn");
                dia.Activo=false;
            }
            dia.cambiaFondo();
        }
        print("Quien: ", qq);
    }
    
    func pasaCalendario(sender: AnyObject){
        for lonc in DatosC.contenedor.Pantallap.botones{
            lonc.loncheras = lonc.panelNino.Lonchera.deslizador.paginas;
        }
        DatosC.contenedor.Pantallap.performSegueWithIdentifier("Calendario", sender: nil);
    }
    
    //Método que inicia el botón del calendario
    func iniciaBotCalendario(){
        let ancho = DatosC.contenedor.anchoP*0.689;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let alto = DatosC.contenedor.altoP*0.07;
        let calendario = UIButton(frame: CGRectMake(OX, (Lonchera.frame.height+Lonchera.frame.origin.y), (ancho), alto));
        calendario.addTarget(self, action: #selector(VistaNino.pasaCalendario(_:)), forControlEvents: .TouchDown);
        //calendario.setTitle("Calendario", forState: .Normal);
        let frameTexto = CGRectMake(0, 0, ancho, alto);
        let texto = UILabel(frame: frameTexto);
        texto.textAlignment = NSTextAlignment.Center;
        texto.textColor = UIColor.whiteColor();
        texto.font = UIFont(name: "SansBeamBody-Heavy", size: 25);
        texto.text = "ORDENAR";
        //calendario.backgroundColor=UIColor.cyanColor();
        let fondo = UIImage(named: "BotonOrdenar");
        let backImg = UIImageView(frame: CGRectMake(0,0,calendario.frame.width, calendario.frame.height));
        backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = fondo;
        
        calendario.addSubview(backImg);
        calendario.addSubview(texto);
        self.sendSubviewToBack(backImg);
        self.addSubview(calendario);
    }
    
    //Método que pondrá un alonchera saludable en la primera lonchera de la semana
    func poneSaludable(){
        let lon = Lonchera.deslizador.paginas.first;
        let bot = UIButton();
        print("salu?");
        for caja in EspacioLoncheras.cajas{
            print("Caja: ", caja.texto.text, " - ", caja.caja.id);
            
            if (caja.caja.id == 1){
                if(caja.caja.secuencia.first?.lista.count>lon?.subVista?.casillas.count){
                    let cuantas = (caja.caja.secuencia.first?.lista.count)!-(lon?.subVista?.casillas.count)!;
                    for _ in 0 ... cuantas{
                        lon?.addcasilla(bot);
                    }
                }
                var p = 0;
                print("Tama: ", caja.caja.secuencia.first?.lista);
                if(caja.caja.secuencia.first != nil){
                    for item in (caja.caja.secuencia.first?.lista)!{
                        let pv = ProductoView(frame: (lon?.subVista?.casillas[p].frame)!, imagen: (item.productos?.imagen)!);
                        print(pv);
                        lon?.subVista?.casillas[p].seteaElemento(pv, tipo: (item.productos?.tipo)!, ima: (item.productos?.imagen)!, prod: item.productos!);
                        p += 1;
                    }
                }
                
            }
        }
    }
    
}
