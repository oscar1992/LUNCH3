//
//  HistorialViewController.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 31/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Historial: UIViewController {
    
    var scroll1: ScrollNEntregadas!;
    var scroll2: ScrollEEntregadas!;

    override func viewDidLoad() {
        super.viewDidLoad()
        DatosB.cont.poneFondoTot(self.view, fondoStr: "FondoHome", framePers: nil, identi: nil, scala: false);
        iniciaBotonVolver()
        cargas();
        iniciaScroll1();
        iniciaScroll2();
        DatosB.cont.historial=self;
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
        volver.addTarget(self, action: #selector(Historial.vuelve), forControlEvents: .TouchDown);
        let subFrame = CGRectMake(centr, centr, ancho2, ancho2);
        DatosB.cont.poneFondoTot(volver, fondoStr: "Volver", framePers: subFrame, identi: nil, scala: true);
        self.view.addSubview(volver);
    }
    
    func vuelve(){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func cargas(){
        let cargaP = CargaPedidos();
        cargaP.cargaPedidos(DatosD.contenedor.padre);
    }
    
    func iniciaScroll1(){
        let alto = DatosC.contenedor.altoP*0.3;
        let ancho = DatosC.contenedor.anchoP;
        let OX = CGFloat(0);
        let OY = DatosC.contenedor.altoP*0.2;
        let alto2 = DatosC.contenedor.altoP*0.05;
        let OY2 = (DatosC.contenedor.altoP*0.2)-alto2;
        let frameTitulo = CGRectMake(0, OY2, ancho, alto2);
        let titulo = UIView(frame: frameTitulo);
        let labTitulo = UILabel(frame: CGRectMake(0, 0, ancho, alto2));
        labTitulo.text="Pedidos pendientes de entrega";
        labTitulo.textAlignment=NSTextAlignment.Center;
        labTitulo.textColor=UIColor.whiteColor();
        labTitulo.font=UIFont(name: "Gotham Bold", size: alto2/3);
        titulo.addSubview(labTitulo);
        DatosB.cont.poneFondoTot(titulo, fondoStr: "Base roja", framePers: nil, identi: nil, scala: false);
        self.view.addSubview(titulo);
        let frame1 = CGRectMake(OX, OY, ancho, alto);
        scroll1 = ScrollNEntregadas(frame: frame1);
        self.view.addSubview(scroll1);
        
    }
    
    func iniciaScroll2(){
        let alto = DatosC.contenedor.altoP*0.3;
        let ancho = DatosC.contenedor.anchoP;
        let OX = CGFloat(0);
        let OY = DatosC.contenedor.altoP*0.6;
        let alto2 = DatosC.contenedor.altoP*0.05;
        let OY2 = (DatosC.contenedor.altoP*0.6)-alto2;
        let frameTitulo = CGRectMake(0, OY2, ancho, alto2);
        let titulo = UIView(frame: frameTitulo);
        let labTitulo = UILabel(frame: CGRectMake(0, 0, ancho, alto2));
        labTitulo.text="Pedidos entregados";
        labTitulo.textAlignment=NSTextAlignment.Center;
        labTitulo.textColor=UIColor.whiteColor();
        labTitulo.font=UIFont(name: "Gotham Bold", size: alto2/3);
        titulo.addSubview(labTitulo);
        DatosB.cont.poneFondoTot(titulo, fondoStr: "Base verde", framePers: nil, identi: nil, scala: false);
        self.view.addSubview(titulo);
        let frame1 = CGRectMake(OX, OY, ancho, alto);
        scroll2 = ScrollEEntregadas(frame: frame1);
        self.view.addSubview(scroll2);
    }
    
    func actuaScroll1(pedidos: [Pedido]){
        scroll1.cargaPedidos(pedidos);
    }
    
    func actuaScroll2(pedidos: [Pedido]){
        scroll2.cargaPedidos(pedidos);
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
