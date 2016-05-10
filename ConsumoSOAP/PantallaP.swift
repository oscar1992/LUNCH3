//
//  PantallaP.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class PantallaP: UIViewController {
    
    @IBOutlet weak var BotonAnadir: BotonNino!
    var cantBotones=1;
    var anchoP:CGFloat!;
    var altoP:CGFloat!;
    var espaciado:CGFloat!;
    var botones=[BotonNino]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        BotonAnadir.enabled=false;
        consume();
        
        print("inicia");
        self.anchoP=UIScreen.mainScreen().bounds.width;
        self.altoP=UIScreen.mainScreen().bounds.height;
        self.espaciado=anchoP*0.01;
        DatosC.contenedor.anchoP=anchoP;
        DatosC.contenedor.altoP=altoP;
        botones+=[BotonAnadir];
        ordenaBoton();
        //print("ancho: ",anchoP);
        DatosC.contenedor.PantallaP=self;
    }
    
    override func viewWillAppear(animated: Bool) {
        check_consumo();
        DatosC.contenedor.Check();
        if(DatosC.contenedor.lleno&&DatosC.contenedor.primera==false){
            //Anida objs
            //print("Anida?");
            DatosC.contenedor.primera=true;
            for caja in DatosC.contenedor.cajas{
                
                for secu in DatosC.contenedor.secuencia{
                    if(secu.caja==caja.id){
                        //print("secu", secu.nombre);
                        var sublista=[TItems]();
                        for titem in DatosC.contenedor.titems{
                            
                            //print(titem.Combinacion," eq ",secu.id);
                            if(titem.Combinacion==secu.id){
                                //print("titem-m: ",titem.productos?.nombre);
                                
                                for prod in DatosC.contenedor.productos{
                                    if(prod.id==titem.idProducto){
                                        titem.productos=prod;
                                        //print("prod: ",titem.productos?.nombre);
                                    }
                                }
                                sublista.append(titem);
                                
                            }
                            //print("titem", titem.productos?.id);
                        }
                        secu.lista=sublista;
                        caja.secuencia.append(secu);
                    }
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Anade(sender: UIButton) {
        //DatosC.contenedor.ninos.last?.activo=false;
        //DatosC.contenedor.ninos.last?.backgroundColor=UIColor.lightGrayColor();
        DatosC.contenedor.ninos.last?.cambia();
        let botonN = BotonNino();
        cantBotones+=1;
        botones+=[botonN];
        botonN.backgroundColor=UIColor.lightGrayColor()
        botonN.activo=false;
        ordenaBoton();
        self.view.addSubview(botonN);
        let panelNino=VistaNino(frame: CGRectMake(0,(botonN.frame.height+20),anchoP,(altoP-botonN.frame.height)));
        
        botonN.panelNino=panelNino;
        panelNino.backgroundColor=UIColor.init(colorLiteralRed: 1, green: 0.89, blue: 0.77, alpha: 1);
        panelNino.titulo.text?.appendContentsOf(String(cantBotones));
        self.view.addSubview(panelNino);
        DatosC.contenedor.ninos+=[botonN];
    }
    
    func ordenaBoton(){
        let mitadC = ((BotonAnadir.frame.width*CGFloat(cantBotones))+CGFloat(espaciado+CGFloat(cantBotones-1)))/2;
        let pini=(anchoP/2)-mitadC;
        let anchoT=BotonAnadir.frame.width+espaciado;
        var itera=0;
        //print("pini",pini);
        for btn in botones{
            //print("btn: ",btn.restorationIdentifier);
            btn.frame=CGRectMake((pini+(anchoT*CGFloat(itera))), BotonAnadir.frame.origin.y, BotonAnadir.frame.width, BotonAnadir.frame.height);
            itera+=1;
        }
        
        /*
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                
                btn.frame.origin.x=CGFloat();
            }
        }
         */
    }
    
    func consume(){
        let cargaI=ConsultaProductos();
        let cargaII=CargaTItems();
        let cargaIII=CargaSecuencia();
        let cargaIV=CargaCajas();
        
        cargaI.consulta();
        cargaII.CargaTItems();
        cargaIII.CargaSecuencia();
        cargaIV.CargaCajas(BotonAnadir);
        
    }
    
    func check_consumo(){
        //print("CHECK:");
        
        /*
        for caja in DatosC.contenedor.cajas{
            //print("caja: ",caja.Nombre);
        }
        for secu in DatosC.contenedor.secuencia{
            //print("Secuencia: ",secu.id);
        }
        for titem in DatosC.contenedor.titems{
            //print("TItem: ",titem.Combinacion);
        }
 
        for prod in DatosC.contenedor.productos{
            
            print("Prod: ", prod.listaDatos.count, " || ", prod.id);
        }
         */
        
    }
    
}
