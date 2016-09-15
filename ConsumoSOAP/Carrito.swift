//
//  Carrito.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 6/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Carrito: UIViewController {

    
    @IBOutlet weak var laBarra: LaBarra!
    var loncherasTipos = [(Lonchera2!, Int!)]();
    var sum:Sumador!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatosB.cont.carrito=self;
        iniciaSecciones();
        iniciaBotonVolver();
        iniciaFondo();
        
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
        let centr = (ancho/2)-(ancho/4);
        let frameBoton = CGRectMake(0, 0, ancho, ancho);
        let volver = UIButton(frame: frameBoton);
        volver.addTarget(self, action: #selector(Carrito.vuelve), forControlEvents: .TouchDown);
        let subFrame = CGRectMake(centr, centr, ancho/2, ancho/2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
        
    }
    
    //Método que cierra la ventana
    func vuelve(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    //Método que inicia le fondo del carrito
    func iniciaFondo(){
        let fondo = CGRectMake(0, laBarra.frame.height, self.view.frame.width, (self.view.frame.height-laBarra.frame.height));
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: fondo, identi: "FondoCar", scala: false);
    }
    
    //Método que organiza las secciones de la vista del carrito
    func iniciaSecciones(){
        iniciaLetrero();
    }
    
    func iniciaLetrero(){
        let ancho = DatosC.contenedor.anchoP*0.8;
        let alto = DatosC.contenedor.altoP*0.11;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.09;
        let frameLet = CGRectMake(OX, OY, ancho, alto);
        let msg = UILabel(frame: frameLet);
        self.view.addSubview(msg);
        msg.text = "!Estas son las loncheras que armaste¡"
        msg.numberOfLines = 0;
        msg.textAlignment=NSTextAlignment.Center;
        msg.font = UIFont(name: "SansBeam Head", size: msg.frame.height/2);
        iniciaScroll(OY+alto);
    }
    
    //Método que ubica el scroll en la vista
    func iniciaScroll(yini: CGFloat){
        let alto = DatosC.contenedor.altoP*0.55;
        let frameScroll = CGRectMake(0, yini, self.view.frame.width, alto);
        iniciaSuma(yini+alto);
        let scroll = ScrollTipos(frame: frameScroll);
        self.view.addSubview(scroll);
        
    }
    
    //Método que inicia el sumador del total de las loncheras
    func iniciaSuma(yini: CGFloat){
        let alto = DatosC.contenedor.altoP*0.15;
        let frameSuma = CGRectMake(0, yini, self.view.frame.width, alto);
        sum = Sumador(frame: frameSuma);
        self.view.addSubview(sum);
        iniciaBotonConfirmar(yini+alto);
    }
    
    //Método que inicia el Botoón de confirmar pedido
    func iniciaBotonConfirmar(yini: CGFloat){
        let ancho = DatosC.contenedor.anchoP*0.6;
        let alto = DatosC.contenedor.altoP*0.07;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = yini;
        let frameB = CGRectMake(OX, OY, ancho, alto);
        let bot = UIButton(frame: frameB);
        DatosB.cont.poneFondoTot(bot, fondoStr: "BotConfirmar", framePers:  nil, identi: nil, scala: false);
        self.view.addSubview(bot);
        bot.addTarget(self, action: #selector(Carrito.pasa), forControlEvents: .TouchDown);
    }
    
    //Mñetodo que cambia de ventana si el padre tiene datos o no tiene datos
    func pasa(){
        evalua();
        self.performSegueWithIdentifier("Datos", sender: nil);
    }
    
    //Método que evalua los datos del padre
    func evalua(){
        print("eva");
        let padre = DatosD.contenedor.padre;
        if(padre.direccion==nil){
            print("No tiene direccion");
        }else{
            print("dir: ", padre.direccion);
        }
        if(padre.email==nil){
            print("No tiene direccion");
        }else{
            print("ema: ", padre.email);
        }
        if(padre.telefono==nil){
            print("No tiene teléfono");
        }else{
            print("tel: ", padre.telefono);
        }
        
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
