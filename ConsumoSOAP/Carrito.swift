//
//  Carrito.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 6/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Carrito: UIViewController {

    var loncherasTipos = ([Lonchera2](), [Int]());
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciaBotonVolver();
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
    
    //Método que organiza las loncheras por su contenido
    func tipificaLoncheras(){
        for lonc in DatosB.cont.loncheras{
            
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
