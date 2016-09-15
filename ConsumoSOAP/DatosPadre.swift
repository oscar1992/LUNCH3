//
//  DatosPadreViewController.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 15/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class DatosPadre: UIViewController {

    @IBOutlet weak var laBarra: LaBarra!
    var borde:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround()
        borde=DatosC.contenedor.altoP*0.02;
        iniciaNombre();
        iniciaBotonVolver();
        iniciaFondo()
        // Do any additional setup after loading the view.
    }
    
    //Método que inicia el fondo de los datops
    func iniciaFondo(){
        let fondo = CGRectMake(0, laBarra.frame.height, self.view.frame.width, (self.view.frame.height-laBarra.frame.height));
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: fondo, identi: "FondoCar", scala: false);
    }
    
    //Método que inicia el botón de volver
    func iniciaBotonVolver(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let centr = (ancho/2)-(ancho/4);
        let frameBoton = CGRectMake(0, 0, ancho, ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(DatosPadre.vuelve), forControlEvents: .TouchDown);
        let subFrame = CGRectMake(centr, centr, ancho/2, ancho/2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
        
    }
    
    //Método que cierra la ventana
    func vuelve(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Método que inicia el nombre del padre y el mensaje de referencia
    func iniciaNombre(){
        let ancho = DatosC.contenedor.anchoP*0.3;
        let alto = DatosC.contenedor.anchoP*0.05;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.2;
        let frameNomb = CGRectMake(OX, OY, ancho, alto);
        let nom = UILabel(frame: frameNomb);
        nom.text=DatosD.contenedor.padre.nombre;
        nom.font=UIFont(name: "SansBeamBody-Heavy", size: nom.frame.height);
        nom.textAlignment=NSTextAlignment.Center;
        nom.textColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        self.view.addSubview(nom);
        let ancho2 = DatosC.contenedor.anchoP*0.5;
        let OX2=(DatosC.contenedor.anchoP/2)-(ancho2/2);
        let frame2 = CGRectMake(OX2, OY+alto, ancho2, alto);
        let text = UILabel(frame: frame2);
        text.text="Confirma tus datos de entrega";
        text.textAlignment=NSTextAlignment.Center;
        self.view.addSubview(text);
        iniciaTabDireccion((text.frame.height+text.frame.origin.y));
    }
    
    //Método que inicia la tabla de los datos de la dirreción
    func iniciaTabDireccion(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.07;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Direccion";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let vista2 = UIView(frame: frameVista2);
        vista2.backgroundColor=UIColor.whiteColor();
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        let ent = UITextField(frame: frameText2);
        vista2.addSubview(ent);
        ent.text=DatosD.contenedor.padre.direccion;
        ent.textColor=UIColor.grayColor();
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabTelefono((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la direccion
    func iniciaTabTelefono(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.07;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Teléfono / Celular";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let vista2 = UIView(frame: frameVista2);
        vista2.backgroundColor=UIColor.whiteColor();
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        let ent = UITextField(frame: frameText2);
        vista2.addSubview(ent);
        ent.text=DatosD.contenedor.padre.telefono;
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabFechaEntrega((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la fecha de netrega
    func iniciaTabFechaEntrega(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.07;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Fecha de Entrega";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let vista2 = UIView(frame: frameVista2);
        vista2.backgroundColor=UIColor.whiteColor();
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        let ent = UITextField(frame: frameText2);
        vista2.addSubview(ent);
        ent.text=DatosD.contenedor.padre.telefono;
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabHoraEntrega((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la fecha de netrega
    func iniciaTabHoraEntrega(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.07;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Hora de Entrega";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let vista2 = UIView(frame: frameVista2);
        vista2.backgroundColor=UIColor.whiteColor();
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        let ent = UITextField(frame: frameText2);
        vista2.addSubview(ent);
        ent.text=DatosD.contenedor.padre.telefono;
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
        iniciaTabMetodo((vista2.frame.height+vista2.frame.origin.y));
    }
    
    //Método que inicia la tabla de la fecha de netrega
    func iniciaTabMetodo(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP;
        let bordeTxt = (ancho*0.02);
        let alto = DatosC.contenedor.anchoP*0.07;
        let frameBarra = CGRectMake(0, (yini+borde), ancho, alto);
        let vista = UIView(frame: frameBarra);
        let frameText = CGRectMake(bordeTxt, 0, ancho, alto);
        let texto = UILabel(frame: frameText);
        texto.text="Método de pago";
        texto.font=UIFont(name: "SansBeamBody-Book", size: texto.frame.height/2);
        vista.addSubview(texto);
        vista.backgroundColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        let frameVista2=CGRectMake(0, (frameBarra.origin.y+alto), ancho, alto);
        let vista2 = UIView(frame: frameVista2);
        vista2.backgroundColor=UIColor.whiteColor();
        let frameText2=CGRectMake(bordeTxt, 0, ancho, alto);
        let ent = UITextField(frame: frameText2);
        vista2.addSubview(ent);
        ent.text=DatosD.contenedor.padre.telefono;
        self.view.addSubview(vista);
        self.view.addSubview(vista2);
    }
   
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
        func dismissKeyboard() {
            view.endEditing(true)
        }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
