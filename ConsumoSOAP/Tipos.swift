//
//  Tipos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Tipos: UIViewController {
    
    var scroll : SrcollHistorialTipos!;

    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaBotonVolver();
        fondo();
        iniciaScroll();
        DatosB.cont.tipos=self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let ancho2 = ancho/3;
        let centr = (ancho/2)-(ancho2/2);
        let frameBoton = CGRect(x: 0, y: 0, width: ancho, height: ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(Tipos.vuelve), for: .touchDown);
        let subFrame = CGRect(x: centr, y: centr, width: ancho2, height: ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    func vuelve(){
        self.dismiss(animated: true, completion: nil);
    }
    
    func fondo(){
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: nil, identi: nil, scala: false);
    }
    
    func iniciaScroll(){
        let alto = DatosC.contenedor.altoP*0.8;
        let OY = DatosC.contenedor.altoP*0.2;
        let frameScroll = CGRect(x: 0, y: OY, width: self.view.frame.width, height: alto);
        scroll = SrcollHistorialTipos(frame: frameScroll);
        self.view.addSubview(scroll);
    }
    
    func actuaScroll(_ tipos: [((String, Int, Int), [Producto])]){
        scroll.cargaTipos(tipos);
    }
    
    //Método que oculta la barra en este viewcontroller
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
