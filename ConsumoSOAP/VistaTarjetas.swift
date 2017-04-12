//
//  VistaTarjetas.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 10/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class VistaTarjetas: UIViewController, UIWebViewDelegate {
    
    var vistaWeb: UIWebView!;

    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaBotonVolver();
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: nil, identi: nil, scala: false);
        botonAnadir();
        //let add = AddCard();
        //add.add();
        consultaTarjetas();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Método que oculta la barra en este viewcontroller
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let ancho2 = ancho/3;
        let centr = (ancho/2)-(ancho2/2);
        let frameBoton = CGRectMake(0, 0, ancho, ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(VistaTarjetas.vuelve), forControlEvents: .TouchDown);
        let subFrame = CGRectMake(centr, centr, ancho2, ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    //Método que cierra la ventana
    func vuelve(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    //Método que permite poner el boton de añadir tarjeta
    func botonAnadir(){
        let ancho = DatosC.contenedor.anchoP*0.7;
        let alto = DatosC.contenedor.altoP*0.07;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.9;
        let frameBoton = CGRectMake(OX, OY, ancho, alto);
        let boton = UIButton(frame: frameBoton);
        boton.addTarget(self, action: #selector(VistaTarjetas.vista), forControlEvents: .TouchDown);
        DatosB.cont.poneFondoTot(boton, fondoStr: "Botón Agregar Tarjeta", framePers: nil, identi: nil, scala: true);
        self.view.addSubview(boton);
    }
    
    func vista(){
        let OY = self.view.frame.height*0;
        let ancho = self.view.frame.width*1;
        let OX = self.view.frame.width*0;
        let alto = self.view.frame.height*1;
        let frameWeb = CGRectMake(OX, OY, ancho, alto);
        vistaWeb = UIWebView(frame: frameWeb);
        gifCarga(vistaWeb);
        vistaWeb.delegate=self;
        self.view.addSubview(vistaWeb);
        let add = AddCard();
        vistaWeb.loadRequest(add.add());
        let anchoB = vistaWeb.frame.width*0.05;
        let OXB = vistaWeb.frame.width-anchoB;
        let OYB = CGFloat(0);
        let frameCerrar = CGRectMake(OXB, OYB, anchoB, anchoB);
        let botCerrar = UIButton(frame: frameCerrar);
        botCerrar.addTarget(self, action: #selector(VistaTarjetas.cerrarVista), forControlEvents: .TouchDown);
        DatosB.cont.poneFondoTot(botCerrar, fondoStr: "BotonCerrar", framePers: nil, identi: nil, scala: true);
        vistaWeb.addSubview(botCerrar);
    }
    
    func cerrarVista(){
        vistaWeb.removeFromSuperview();
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("Carga Web");
        for vista in webView.subviews{
            if(vista.accessibilityIdentifier == "gif"){
                vista.removeFromSuperview();
                
            }
        }
        if let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies {
            for cookie in cookies {
                
                print("Nomb: ", cookie.name);
                if(cookie.name == "pmntz_add_success"){
                    print("Estado: ", cookie.value);
                    consultaTarjetas();
                    cerrarVista();
                    let msg = VistaMensaje(msg: "Tarjeta ingresada exitosamente");
                    self.view.addSubview(msg);
                }else if(cookie.name == "pmntz_error_message" && cookie.value != ""){
                    let msg = VistaMensaje(msg: "Tarjeta No ingresada");
                    self.view.addSubview(msg);
                }
                //print("\(cookie)")
            }
        }
    }
    
    
    func gifCarga(vistaPadre: UIView){
        let gif = UIImage.gifImageWithName("Cargando");
        let vista = UIImageView(frame: CGRectMake(0, 0, vistaPadre.frame.width, vistaPadre.frame.height));
        vista.image = gif;
        vista.accessibilityIdentifier = "gif";
        vista.contentMode = UIViewContentMode.ScaleAspectFit;
        vistaPadre.addSubview(vista);
    }
    
    func consultaTarjetas(){
        let list = ListCard(vistaBase: self.view);
        list.vistaT = self;
        list.lista();
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
