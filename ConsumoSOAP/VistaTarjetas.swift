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
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let ancho2 = ancho/3;
        let centr = (ancho/2)-(ancho2/2);
        let frameBoton = CGRect(x: 0, y: 0, width: ancho, height: ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(VistaTarjetas.vuelve), for: .touchDown);
        let subFrame = CGRect(x: centr, y: centr, width: ancho2, height: ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    //Método que cierra la ventana
    func vuelve(){
        self.dismiss(animated: true, completion: nil);
    }
    
    //Método que permite poner el boton de añadir tarjeta
    func botonAnadir(){
        let ancho = DatosC.contenedor.anchoP*0.7;
        let alto = DatosC.contenedor.altoP*0.07;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.9;
        let frameBoton = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let boton = UIButton(frame: frameBoton);
        boton.addTarget(self, action: #selector(VistaTarjetas.vista), for: .touchDown);
        DatosB.cont.poneFondoTot(boton, fondoStr: "Botón Agregar Tarjeta", framePers: nil, identi: nil, scala: true);
        self.view.addSubview(boton);
    }
    
    func vista(){
        let OY = self.view.frame.height*0;
        let ancho = self.view.frame.width*1;
        let OX = self.view.frame.width*0;
        let alto = self.view.frame.height*1;
        let frameWeb = CGRect(x: OX, y: OY, width: ancho, height: alto);
        vistaWeb = UIWebView(frame: frameWeb);
        gifCarga(vistaWeb);
        vistaWeb.delegate=self;
        self.view.addSubview(vistaWeb);
        let add = AddCard();
        vistaWeb.loadRequest(add.add() as URLRequest);
        let anchoB = vistaWeb.frame.width*0.05;
        let OXB = vistaWeb.frame.width-anchoB;
        let OYB = CGFloat(0);
        let frameCerrar = CGRect(x: OXB, y: OYB, width: anchoB, height: anchoB);
        let botCerrar = UIButton(frame: frameCerrar);
        botCerrar.addTarget(self, action: #selector(VistaTarjetas.cerrarVista), for: .touchDown);
        DatosB.cont.poneFondoTot(botCerrar, fondoStr: "BotonCerrar", framePers: nil, identi: nil, scala: true);
        vistaWeb.addSubview(botCerrar);
    }
    
    func cerrarVista(){
        vistaWeb.removeFromSuperview();
        let storage = HTTPCookieStorage.shared
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Carga Web");
        for vista in webView.subviews{
            if(vista.accessibilityIdentifier == "gif"){
                vista.removeFromSuperview();
                
            }
        }
        if let cookies = HTTPCookieStorage.shared.cookies {
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
    
    
    func gifCarga(_ vistaPadre: UIView){
        let gif = UIImage.gifImageWithName("Cargando");
        let vista = UIImageView(frame: CGRect(x: 0, y: 0, width: vistaPadre.frame.width, height: vistaPadre.frame.height));
        vista.image = gif;
        vista.accessibilityIdentifier = "gif";
        vista.contentMode = UIViewContentMode.scaleAspectFit;
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
