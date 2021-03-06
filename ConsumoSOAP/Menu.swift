//
//  Menu.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 31/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Menu: UIView {

    let padre:Home2;
    
    init(padre: Home2){
        let ancho = DatosC.contenedor.anchoP;
        let alto = DatosC.contenedor.altoP*0.9078;
        let OX = -ancho;
        let OY = DatosC.contenedor.altoP * 0.0922;
        let frame = CGRect(x: OX, y: OY, width: ancho, height: alto);
        self.padre=padre;
        super.init(frame: frame);
        cabecera();
        iniciaBotones();
        fondo();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    func fondo(){
        let OX = CGFloat(0);
        let OY = CGFloat(0);
        let frameB = CGRectMake(OX, OY, self.frame.width, self.frame.height);
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light);
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame=frameB;
        //blurEffectView.layer.zPosition=5;
        self.addSubview(blurEffectView);
        self.sendSubviewToBack(blurEffectView);
    }
    */
    
    //Método que pone el fondo
    func fondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "FondoVerde", framePers: nil, identi: nil, scala: false);
    }
    
    //Método que pinta la cabecera del menú desplegable
    func cabecera(){
        let alto = DatosC.contenedor.altoP*0.2;
        let ancho = self.frame.width;
        let frameVista = CGRect(x: 0, y: 0, width: ancho, height: alto);
        let vista = Cabecera(frame: frameVista);
        self.addSubview(vista);
        //vista.backgroundColor=UIColor.yellowColor();
    }
    
    //Método que inicia los gráficos de los botones del menú
    func iniciaBotones(){
        let altoBot = (DatosC.contenedor.altoP*0.8)/7;
        let ancho = self.frame.width;
        let OX = CGFloat(0);
        for n in 0...7{
            let OY = altoBot*CGFloat(n)+DatosC.contenedor.altoP*0.2;
            let frame = CGRect(x: OX, y: OY, width: ancho, height: altoBot);
            switch n {
            case 0:
                let bot = BotonMenu(ima: "MenuCarrito", texto: "Mis Pedidos", frame: frame);
                self.addSubview(bot);
                bot.addTarget(self, action: #selector(Menu.pasaHistorial), for: .touchDown);
                break;
            case 4:
                let bot = BotonMenu(ima: "BotonCerrar", texto: "Cerrar Sesión", frame: frame);
                self.addSubview(bot);
                bot.addTarget(self, action: #selector(Menu.cierraSesion), for: .touchDown);
                break;
            case 1:
                let bot = BotonMenu(ima: "ICO 1", texto: "¿Qué es la lonchera?", frame: frame);
                self.addSubview(bot);
                bot.addTarget(self, action: #selector(Menu.pasaSaludableInfo), for: .touchDown);
                break;
            case 2:
                let bot = BotonMenu(ima: "ICO 4", texto: "Tarjetas", frame: frame);
                self.addSubview(bot);
                bot.addTarget(self, action: #selector(Menu.pasaTarjetas), for: .touchDown);
                break;
            case 3:
                let bot = BotonMenu(ima: "ICO 5", texto: "Contacto", frame: frame);
                self.addSubview(bot);
                bot.addTarget(self, action: #selector(Menu.pasaContacto), for: .touchDown);
                break;
            default:
                break;
            }
        }
        
    }
    
    //Método que permite pasar a la ventana del historial
    func pasaHistorial(){
        padre.muestra();
        padre.performSegue(withIdentifier: "Historial", sender: nil);
    }
    
    //Método que cierra la sesión y destruye los datos cargados
    func cierraSesion(){
        let msgCierra = MensajeCierra();
        self.addSubview(msgCierra);
    }
    
    //Método que permite pasar a la ventana del historial
    func pasaSaludableInfo(){
        padre.muestra();
        padre.performSegue(withIdentifier: "SaludableInfo", sender: nil);
    }
    
    //Método que permite pasar a la ventana de tarjetas
    func pasaTarjetas(){
        padre.muestra();
        padre.performSegue(withIdentifier: "Tarjetas", sender: nil);
    }
    
    //Método que permite pasar a la ventana de contacto
    func pasaContacto(){
        padre.muestra();
        padre.performSegue(withIdentifier: "Contacto", sender: nil);
    }

}
