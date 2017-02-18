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
        volver.addTarget(self, action: #selector(SaludableInfo.vuelve), forControlEvents: .TouchDown);
        let subFrame = CGRectMake(centr, centr, ancho2, ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    //Método que cierra la ventana
    func vuelve(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func fondoBlanco(){
        let ancho = DatosC.contenedor.anchoP;
        let alto = DatosC.contenedor.altoP*0.7;
        let OY = DatosC.contenedor.altoP*0.1;
        let OX = CGFloat(0);
        let frame = CGRectMake(OX, OY, ancho, alto);
        let fondo = UIView(frame: frame);
        fondo.backgroundColor=UIColor.whiteColor();
        self.view.addSubview(fondo);
    }
    
    func fondoManzana(){
        let ancho = DatosC.contenedor.anchoP*0.1;
        let OX = DatosC.contenedor.anchoP*0.7;
        let OY = DatosC.contenedor.altoP*0.75;
        let frame = CGRectMake(OX, OY, ancho, ancho);
        let vista = UIView(frame: frame);
        DatosB.cont.poneFondoTot(vista, fondoStr: "Apple", framePers: nil, identi: nil, scala: true);
        self.view.addSubview(vista);
    }
    
    func informacionTitulo1(){
        let anchoTitulo = DatosC.contenedor.anchoP*0.8;
        let altoTitulo = DatosC.contenedor.anchoP*0.1;
        let OX = DatosC.contenedor.anchoP*0.05;
        let OY = DatosC.contenedor.altoP*0.1;
        let frame = CGRectMake(OX, OY, anchoTitulo, altoTitulo);
        let label1 = UILabel(frame: frame);
        label1.text="¿Qué es la lonchera?";
        label1.font=UIFont(name: "Gotham Bold", size: altoTitulo*0.45);
        label1.textColor=UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1);
        self.view.addSubview(label1);
        texto1(OY);
    }
    
    func texto1(OYI: CGFloat){
        let ancho = DatosC.contenedor.anchoP*0.9;
        let alto = DatosC.contenedor.altoP*0.3;
        let OX = DatosC.contenedor.anchoP*0.05;
        let OY = OYI;
        let frame = CGRectMake(OX, OY, ancho, alto);
        let texto = UILabel(frame: frame);
        texto.font=UIFont(name: "Gotham Bold", size: alto*0.1);
        texto.text="Hicimos el trabajo por ti, como expertos nutricionales, seleccionamos la mejor oferta de productos saludables y la ponemos a tu dispocisión, solo aquí en La Lonchera. Armamos y llevamos Loncheras saludables para ti y tu familia.";
        texto.numberOfLines = 9;
        texto.textColor=UIColor.grayColor();
        texto.adjustsFontSizeToFitWidth=true;
        self.view.addSubview(texto);
    }
    
    func informacionTitulo2(){
        let anchoTitulo = DatosC.contenedor.anchoP*0.8;
        let altoTitulo = DatosC.contenedor.anchoP*0.1;
        let OX = DatosC.contenedor.anchoP*0.05;
        let OY = DatosC.contenedor.altoP*0.4;
        let frame = CGRectMake(OX, OY, anchoTitulo, altoTitulo);
        let label1 = UILabel(frame: frame);
        label1.text="¿Qué es una lonchera saludable?";
        label1.font=UIFont(name: "Gotham Bold", size: altoTitulo*0.45);
        label1.textColor=UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1);
        self.view.addSubview(label1);
        texto2(OY);
    }
    
    func texto2(OYI: CGFloat){
        let ancho = DatosC.contenedor.anchoP*0.9;
        let alto = DatosC.contenedor.altoP*0.3;
        let OX = DatosC.contenedor.anchoP*0.05;
        let OY = OYI+DatosC.contenedor.altoP*0.03;
        let frame = CGRectMake(OX, OY, ancho, alto);
        let texto = UILabel(frame: frame);
        texto.font=UIFont(name: "Gotham Bold", size: alto*0.1);
        texto.text="Aseguramos que todos los productos marcados con la hoja:\n*No tienen endulzantes artificiales\n*Son bajos en azúcar\n*No tienen grasas dañinas\n*No tienen ingredientes artificiales\n*Son bajos en sodio\nContienen alto aporte nutricional: vitaminas, antioxidantes y minerales.";
        texto.numberOfLines = 9;
        texto.textColor=UIColor.grayColor();
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
