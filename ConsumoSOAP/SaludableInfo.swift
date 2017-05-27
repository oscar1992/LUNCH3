//
//  SaludableInfo.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 2/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class SaludableInfo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: nil, identi: "FondoTot", scala: false);
        iniciaBotonVolver();
        fondoBlanco();
        fondoManzana();
        informacionTitulo1();
        informacionTitulo2();
        // Do any additional setup after loading the view.
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
        volver.addTarget(self, action: #selector(SaludableInfo.vuelve), for: .touchDown);
        let subFrame = CGRect(x: centr, y: centr, width: ancho2, height: ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    //Método que cierra la ventana
    func vuelve(){
        self.dismiss(animated: true, completion: nil);
    }
    
    func fondoBlanco(){
        let ancho = DatosC.contenedor.anchoP;
        let alto = DatosC.contenedor.altoP*0.7;
        let OY = DatosC.contenedor.altoP*0.1;
        let OX = CGFloat(0);
        let frame = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let fondo = UIView(frame: frame);
        fondo.backgroundColor=UIColor.white;
        self.view.addSubview(fondo);
    }
    
    func fondoManzana(){
        let ancho = DatosC.contenedor.anchoP*0.2
        ;
        let OX = DatosC.contenedor.anchoP*0.7;
        let OY = DatosC.contenedor.altoP*0.75;
        let frame = CGRect(x: OX, y: OY, width: ancho, height: ancho);
        let vista = UIView(frame: frame);
        DatosB.cont.poneFondoTot(vista, fondoStr: "Apple", framePers: nil, identi: nil, scala: true);
        self.view.addSubview(vista);
    }
    
    func informacionTitulo1(){
        let anchoTitulo = DatosC.contenedor.anchoP*0.8;
        let altoTitulo = DatosC.contenedor.anchoP*0.1;
        let OX = DatosC.contenedor.anchoP*0.05;
        let OY = DatosC.contenedor.altoP*0.1;
        let frame = CGRect(x: OX, y: OY, width: anchoTitulo, height: altoTitulo);
        let label1 = UILabel(frame: frame);
        label1.text="¿Qué es la lonchera?";
        label1.font=UIFont(name: "Gotham Bold", size: altoTitulo*0.45);
        label1.textColor=UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1);
        self.view.addSubview(label1);
        texto1(OY);
    }
    
    func texto1(_ OYI: CGFloat){
        let ancho = DatosC.contenedor.anchoP*0.9;
        let alto = DatosC.contenedor.altoP*0.3;
        let OX = DatosC.contenedor.anchoP*0.05;
        let OY = OYI + DatosC.contenedor.altoP*0.05;
        let frame = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let texto = UILabel(frame: frame);
        texto.font=UIFont(name: "Gotham Bold", size: alto*0.1);
        texto.text="Somos la primera app de alimentación que te permite elegir, personalizar y ordenar loncheras saludables para ti y tu familia. Con expertos nutricionales seleccionamos la mejor oferta de productos saludables, la organizamos y la ponemos a tu disposición.";
        texto.numberOfLines = 9;
        texto.textColor=UIColor.gray;
        texto.adjustsFontSizeToFitWidth=true;
        self.view.addSubview(texto);
    }
    
    func informacionTitulo2(){
        let anchoTitulo = DatosC.contenedor.anchoP*0.8;
        let altoTitulo = DatosC.contenedor.anchoP*0.1;
        let OX = DatosC.contenedor.anchoP*0.05;
        let OY = DatosC.contenedor.altoP*0.45;
        let frame = CGRect(x: OX, y: OY, width: anchoTitulo, height: altoTitulo);
        let label1 = UILabel(frame: frame);
        label1.text="¿Qué es una lonchera saludable?";
        label1.font=UIFont(name: "Gotham Bold", size: altoTitulo*0.45);
        label1.textColor=UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1);
        self.view.addSubview(label1);
        texto2(OY);
    }
    
    func texto2(_ OYI: CGFloat){
        let ancho = DatosC.contenedor.anchoP*0.9;
        let alto = DatosC.contenedor.altoP*0.3;
        let OX = DatosC.contenedor.anchoP*0.05;
        let OY = OYI+DatosC.contenedor.altoP*0.03
        ;
        let frame = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let texto = UILabel(frame: frame);
        texto.font=UIFont(name: "Gotham Bold", size: alto*0.1);
        texto.text="Seleccionamos los mejores productos saludables\n1. No tienen ingredientes artificiales ni grasas dañinas.\n2. Son bajos en azúcar y en sodio.\n3. Contienen alto aporte nutricional: vitaminas, antioxidantes y minerales.\n";
        texto.numberOfLines = 9;
        texto.textColor=UIColor.gray;
        texto.adjustsFontSizeToFitWidth=true;
        self.view.addSubview(texto);
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
