//
//  VistaNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

class VistaNino: UIView {
    /*
    var titulo:UILabel!;
    var EspacioLoncheras:Predeterminadas!;
    var Lonchera:Contenedor!;
    var mesActual:Mes?;
    var padre:BotonNino?;
    var barraD : UIView?;
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame);
        self.accessibilityIdentifier="VN";
        titulo=UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20));
        //self.addSubview(titulo);
        titulo.text="Vista";
        titulo.textColor=UIColor.black;
        EspacioLoncheras = Predeterminadas(frame: CGRect(x: 0, y: 0, width: DatosC.contenedor.anchoP, height: (DatosC.contenedor.altoP*0.16866)));
        EspacioLoncheras.backgroundColor = UIColor.clear.withAlphaComponent(0.0);
        self.addSubview(EspacioLoncheras);
        Lonchera=Contenedor(frame: CGRect(x: 0, y: (EspacioLoncheras.frame.origin.y+EspacioLoncheras.frame.height), width: DatosC.contenedor.anchoP, height: (DatosC.contenedor.altoP*0.6391)));
        Lonchera.backgroundColor=UIColor.clear.withAlphaComponent(0.0);
        self.addSubview(Lonchera);
        let bot=UIButton(frame: CGRect(x: CGFloat(DatosC.contenedor.anchoP/2), y: (Lonchera.frame.height+Lonchera.frame.origin.y-20), width: 100, height: 30));
        bot.backgroundColor=UIColor.blue;
        bot.addTarget(self, action: #selector(VistaNino.lee(_:)), for: .touchDown)
        //self.addSubview(bot);
        //self.bringSubviewToFront(bot);
        iniciaBotCalendario();
        //self.frame = CGRectMake(0, 0, 300, 300);
        //self.backgroundColor = UIColor.blueColor();
        self.backgroundColor = UIColor.clear.withAlphaComponent(0.0);
        barraDias();
        //poneSaludable();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Método que se usará con fines de leer una lonchrea (DEBUG)
    func lee(_ sender: UIButton){
        //var scroll = Lonchera.deslizador.mueveAPosicion(DatosC.contenedor.loncheras[DatosC.contenedor.iActual+3])
        print("iact: ", DatosC.contenedor.iActual);
        /*let lonc = DatosC.contenedor.lonchera;
        print("QUIEN: ",lonc.fechaVisible?.text);
        for cas in (lonc.subVista?.casillas)!{
            print("cas: ",cas.elemeto?.producto?.nombre);
            //print("FRrame: ", cas.superview?.superview?.frame);
        }
 */
    }
    
    //Método de inicializaión de la barra de los días
    func barraDias(){
        let ancho = DatosC.contenedor.anchoP*0.6006
        let alto = DatosC.contenedor.altoP*0.04;
        let OY = EspacioLoncheras.frame.height+DatosC.contenedor.altoP*0.0239;
        let OX = DatosC.contenedor.anchoP*0.3444;
        
        let frameBarra = CGRect(x: OX, y: OY, width: ancho, height: alto);
        barraD = UIView(frame: frameBarra);
        let ancho2 = ancho/CGFloat(Lonchera.deslizador.paginas.count);
        var p = 1;//Día de inicio
        for _ in Lonchera.deslizador.paginas{
            let OX = CGFloat(p-1)*ancho2;
            let frameBoton = CGRect(x: OX, y: 0, width: ancho2, height: barraD!.frame.height);
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
    func cambiaLonchera(_ qq: Int){
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
    
    func pasaCalendario(_ sender: AnyObject){
        for lonc in DatosC.contenedor.Pantallap.botones{
            lonc.loncheras = lonc.panelNino.Lonchera.deslizador.paginas;
        }
        DatosC.contenedor.Pantallap.performSegue(withIdentifier: "Calendario", sender: nil);
    }
    
    //Método que inicia el botón del calendario
    func iniciaBotCalendario(){
        let ancho = DatosC.contenedor.anchoP*0.689;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let alto = DatosC.contenedor.altoP*0.07;
        let calendario = UIButton(frame: CGRect(x: OX, y: (Lonchera.frame.height+Lonchera.frame.origin.y), width: (ancho), height: alto));
        calendario.addTarget(self, action: #selector(VistaNino.pasaCalendario(_:)), for: .touchDown);
        //calendario.setTitle("Calendario", forState: .Normal);
        let frameTexto = CGRect(x: 0, y: 0, width: ancho, height: alto);
        let texto = UILabel(frame: frameTexto);
        texto.textAlignment = NSTextAlignment.center;
        texto.textColor = UIColor.white;
        texto.font = UIFont(name: "SansBeamBody-Heavy", size: 25);
        texto.text = "ORDENAR";
        //calendario.backgroundColor=UIColor.cyanColor();
        let fondo = UIImage(named: "BotonOrdenar");
        let backImg = UIImageView(frame: CGRect(x: 0,y: 0,width: calendario.frame.width, height: calendario.frame.height));
        backImg.contentMode = UIViewContentMode.scaleAspectFit;
        backImg.image = fondo;
        
        calendario.addSubview(backImg);
        calendario.addSubview(texto);
        self.sendSubview(toBack: backImg);
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
    */
}
