//
//  VistaContacto.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 13/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class VistaContacto: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: nil, identi: "FondoTot", scala: false);
        iniciaBotonVolver();
        fondoBlanco();
        informacionTitulo1();
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
        let frameBoton = CGRectMake(0, 0, ancho, ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(VistaContacto.vuelve), forControlEvents: .TouchDown);
        let subFrame = CGRectMake(centr, centr, ancho2, ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    //Método que oculta la barra en este viewcontroller
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //Método que cierra la ventana
    func vuelve(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    //Método que pinta el fondo blanco
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
    
    func informacionTitulo1(){
        let anchoTitulo = DatosC.contenedor.anchoP;
        let altoTitulo = DatosC.contenedor.anchoP*0.1;
        let OX = DatosC.contenedor.anchoP*0;
        let OY = DatosC.contenedor.altoP*0.1;
        let frame = CGRectMake(OX, OY, anchoTitulo, altoTitulo);
        let label1 = UILabel(frame: frame);
        label1.text="¡Nos encanta escucharte!";
        label1.textAlignment = NSTextAlignment.Center;
        label1.font=UIFont(name: "Gotham Bold", size: altoTitulo*0.45);
        label1.textColor=UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 1);
        self.view.addSubview(label1);
        lista(OY+altoTitulo);
    }
    
    func lista(oy: CGFloat){
        let frameImagen = CGRectMake(0, oy, self.view.frame.width, self.view.frame.height*0.4);
        let ima = UIView(frame: frameImagen);
        DatosB.cont.poneFondoTot(ima, fondoStr: "ContactanosTEXTO", framePers: nil, identi: nil, scala: true);
        self.view.addSubview(ima);
        //ima.backgroundColor=UIColor.redColor();
        let OX = CGFloat(0);
        var OY = oy+self.view.frame.height*0.4;
        let ancho = self.view.frame.width;
        let alto = self.view.frame.height*0.09;
        var frame = CGRectMake(OX, OY, ancho, alto);
        self.view.addSubview(vista(frame, iconoS: "ICO E-mail", texto: "laloncheraparati@gmail.com"));
        OY = OY+alto;
        frame = CGRectMake(OX, OY, ancho, alto);
        //self.view.addSubview(vista(frame, iconoS: "ICO Teléfono", texto: "316900000"));
        OY = OY+alto;
        frame = CGRectMake(OX, OY, ancho, alto);
        //self.view.addSubview(vista(frame, iconoS: "ICO WhatsApp", texto: "3145067899"));
        OY = OY+alto;
        frame = CGRectMake(OX, OY, ancho, alto);
        //self.view.addSubview(vista(frame, iconoS: "ICO Facebook", texto: "LaLonchera"));
        OY = OY+alto;
        frame = CGRectMake(OX, OY, ancho, alto);
        //self.view.addSubview(vista(frame, iconoS: "ICO Términos", texto: "Terminos de uso y políticas de Privacidad"));
        
        
    }
    
    func vista(frame: CGRect, iconoS: String, texto: String)->UIView{
        let vista = UIView(frame: frame);
        let ficono = CGRectMake(0, vista.frame.height*0.05, vista.frame.width*0.2, vista.frame.height*0.9);
        let icono = UIView(frame: ficono);
        DatosB.cont.poneFondoTot(icono, fondoStr: iconoS, framePers: nil, identi: nil, scala: true);
        let ftext = CGRectMake(vista.frame.width*0.2, vista.frame.height*0.3, vista.frame.width*0.8, vista.frame.height/3);
        let text = UILabel(frame: ftext);
        text.text = texto;
        text.textColor = UIColor.grayColor();
        text.font=UIFont(name: "SansBeamBody-Book", size: text.frame.height);
        text.adjustsFontSizeToFitWidth=true;
        
        vista.addSubview(icono);
        vista.addSubview(text);
        return vista;
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
