//
//  ViewController.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 28/03/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate, NSXMLParserDelegate {
    
    @IBOutlet weak var ima1: ProductoView!
    @IBOutlet weak var ima2: ProductoView!
    @IBOutlet weak var ima3: ProductoView!
    @IBOutlet weak var Contenedor: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var posi: UILabel!
    @IBOutlet weak var Pnael1: UIView!
    
    
    
    let cc=ConsultaProductos();
    var posiT:CGPoint?;
    var posiS:[CGRect]?;
    var arrgeloE=[CGRect]();
    var ancho_casillas:CGFloat?=0;
    var pad_inicial:CGFloat?=0;
    var espaciado:CGFloat?=0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //creaSemana();
        
        pageControl.numberOfPages=5;
        print("CONTENEDOR: ",Contenedor.frame.height);
        cc.consulta();
        setTamamnos();
        for cg in DatosC.contenedor.arreglo{
            let pos=pad_inicial!+CGFloat((CGFloat(cg.tipo!-1)*(ancho_casillas!+espaciado!)));
            cg.frame=CGRectMake(pos, cg.frame.origin.y, ancho_casillas!, ancho_casillas!);
                let cg2 = cg.frame.origin.y + Contenedor.frame.origin.y;
                var cg3:CGRect;
                cg3 = CGRectMake(cg.frame.origin.x, cg2, cg.frame.width, cg.frame.height);
                print(cg3);
                arrgeloE.append(cg3);
        }
        
        DatosC.contenedor.vistaP=self;
        DatosC.contenedor.cambia();
        print("SCREEN",UIScreen.mainScreen().bounds.height);
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Conusltar(sender: UIButton) {
        var p=0;
        for a in cc.objs{
            
            let pos=CGFloat(90*p);
            //print("posi",pos);
            let imageView=ProductoView(frame: CGRectMake((10+pos), Pnael1.frame.origin.y, 80, 80), imagen: a.imagen);
            imageView.VistaGeneral=self;
            imageView.tipo=a.tipo;
            imageView.bloquea=true;
            //imageView.padre=Pnael1;
            Pnael1.addSubview(imageView);
            //imageView.imagen=a.imagen;
            
            //self.view.addSubview(imageView);
            p += 1;
        }
    }
    
    func actualizaPageConttroler(){
        pageControl.currentPage=DatosC.contenedor.iActual;
    }
    
    func evaluaPos(elemento: ProductoView){
        
        print("iActual: ",DatosC.contenedor.iActual);
        var p=0;
        for coor in DatosC.contenedor.arreglo{
            
            if(CGRectContainsPoint(arrgeloE[p], posiT!) && coor.activo! && coor.tipo == elemento.tipo && elemento.bloquea!){
                print("dentro de: ",coor.lonchera.id);
                coor.addSubview(elemento);
                elemento.bloquea=false;
                coor.elemeto?.removeFromSuperview();
                coor.elemeto=elemento;
                coor.elemeto?.frame=CGRectMake(0 , 0, coor.frame.width, coor.frame.height);
                for ima in (coor.elemeto?.subviews)!{
                    ima.frame=CGRectMake(0 , 0, coor.frame.width, coor.frame.height);
                }
            }else{
                //print("fuera");
                //Pnael1.addSubview(elemento);
            }
            p += 1;
        }
    }
    
    func setTamamnos(){
        espaciado=5;
        ancho_casillas=(Contenedor.frame.height/CGFloat(3));
        pad_inicial=(UIScreen.mainScreen().bounds.size.width/2)-((ancho_casillas!*CGFloat(3))+(espaciado!*CGFloat(3-1)))/2;
        pad_inicial=CGFloat(abs(Double(pad_inicial!)));
        print("casillasA: ",ancho_casillas);
        print(pad_inicial);
        print("pantalla: ",UIScreen.mainScreen().bounds.height);
    }
    
}

