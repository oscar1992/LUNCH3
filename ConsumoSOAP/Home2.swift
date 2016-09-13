//
//  Home2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 1/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Home2: UIViewController {
    
    
    @IBOutlet weak var laBarra: LaBarra!
    var predeterminadas:Pred2!;
    var lonchera:Lonchera2!;
    var botonCarrito:BotonCarrito!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iniciaBotonMenu();
        iniciaBotonCarrito();
        iniciaPredeterminadas();
        iniciaLonchera();
        iniciaBotonAgregar();
        
        let fondo = CGRectMake(0, laBarra.frame.height, self.view.frame.width, (self.view.frame.height-laBarra.frame.height));
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: fondo, identi: "FondoTot", scala: false);
        print("carga home");
        DatosB.cont.home2=self;
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
    
    //Método que Inicia el Botoón del Menú
    func iniciaBotonMenu(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let frameBoton = CGRectMake(0, 0, ancho, ancho);
        let BotonMenu = UIButton(frame: frameBoton);
        BotonMenu.backgroundColor=UIColor.redColor();
        DatosB.cont.poneFondoTot(BotonMenu, fondoStr: "MenuLat", framePers: CGRectMake(ancho/3, ancho/3, ancho*0.3, ancho*0.3), identi: nil, scala: false);
        self.view.addSubview(BotonMenu);
    }
    
    //Método que inicia el botón del carrito
    func iniciaBotonCarrito(){
        let OX = DatosC.contenedor.anchoP-(DatosC.contenedor.altoP * 0.0922);
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let frameBoton = CGRectMake(OX, 0, ancho, ancho);
        botonCarrito = BotonCarrito(frame: frameBoton);
        //botonCarrito.backgroundColor=UIColor.blueColor();
        self.view.addSubview(botonCarrito);
    }
    
    //Método que inicia el espacio de las loncheras predeterminadas
    func iniciaPredeterminadas(){
        let frame = CGRectMake(0, DatosC.contenedor.altoP * 0.0922, DatosC.contenedor.anchoP, (DatosC.contenedor.altoP*0.16866));
        predeterminadas = Pred2(frame: frame);
        //DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoPredeterminadas", framePers: frame, identi: "FondoPred" , scala: false);
        self.view.addSubview(predeterminadas);
        
    }
    
    //Método que inicia la lonchera
    func iniciaLonchera(){
        let ancho = DatosC.contenedor.anchoP*0.78;
        let alto = DatosC.contenedor.altoP*0.4;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.30;
        let frameLonchera = CGRectMake(OX, OY, ancho, alto);
        lonchera = Lonchera2(frame: frameLonchera);
        //lonchera.backgroundColor=UIColor.blueColor();
        self.view.addSubview(lonchera);
    }
    
    //Método que inicia el boton de agregar al carrito
    func iniciaBotonAgregar(){
        let ancho = DatosC.contenedor.anchoP*0.7;
        let alto = DatosC.contenedor.altoP*0.1
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.85;
        let frameBoton = CGRectMake(OX, OY, ancho, alto);
        let boton = UIButton(frame: frameBoton);
        /*
        let frameLabel = CGRectMake(0, 0, ancho, alto);
        let label = UILabel(frame: frameLabel);
        label.text="Agregar al Carrito";
        label.textAlignment=NSTextAlignment.Center;
        label.textColor=UIColor.whiteColor();
        label.font=UIFont(name: "SansBeamBody-Heavy", size: (label.frame.height/2));
        boton.addSubview(label);
         */
        boton.addTarget(self, action: #selector(Home2.anade), forControlEvents: .TouchDown);
        DatosB.cont.poneFondoTot(boton, fondoStr: "BotonOrdenar2", framePers: nil, identi: nil, scala: false);
        self.view.addSubview(boton);
    }
    
    //Método que permite añadir una lonchera al carrito
    func anade(){
        if(lonchera.estaLLena()){
            print("añade");
            DatosB.cont.loncheras.append(lonchera);
            for cas in lonchera.casillas{
                print("ele: ", cas.elemeto?.producto?.nombre);
                cas.elemeto?.elimina();
            }
            lonchera.actualizaContador();
            botonCarrito.cant.text=String(DatosB.cont.loncheras.count);
        }else{
            print("Vacía");
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
