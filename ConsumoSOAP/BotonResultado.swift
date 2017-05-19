//
//  BotonResultado.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 18/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotonResultado: UIButton {
    
    var nombre : String?;
    var producto : Producto?;
    var pestaña : PestanasProductos?;
    
    
    init(frame: CGRect, producto: Producto, pestañas : PestanasProductos){
        super.init(frame: frame);
        self.nombre=producto.nombre;
        self.producto=producto;
        self.pestaña=pestañas;
        let frameNombre = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
        let nom = UILabel(frame: frameNombre);
        nom.text=nombre;
        self.addSubview(nom);
        self.addTarget(self, action: #selector(BotonResultado.cambiaPestaña(_:)), for: .touchUpInside);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que cambia la pestala de acuerdo al tipo de producto contenido
    func cambiaPestaña(_ sender: AnyObject){
        pestaña?.cambia(self);
        for pest in DatosC.contenedor.Pestanas{
            if(pest.activo==true){
                //print("PESTAÑA: ", pest);
                var p = 0;
                for pagi in (pest.subVista?.paginas)!{
                    print("pagi: ",p);
                    //for ele in (pest.subVista?.paginas.first!.view.subviews)!{
                    for ele in pagi.view.subviews{
                        //print("cass: ", casi.elemeto?.producto?.nombre);
                        if ele is Casilla{
                            let casi = ele as! Casilla;
                            print("casi: ", casi.elemeto?.producto?.nombre);
                            if(self.producto?.id == casi.elemeto?.producto?.id){
                                rotaPestaña(pest.subVista!, npest: p);
                            }
                            
                            //print("casi padre: ", casi.superview);
                        }
                        //print("ele: ", ele);
                    }
                    p += 1;
                }
            }
        }
        DatosC.contenedor.pantallaSV.cierraBusqueda(self);
    }
    
    //Método que permite cambiar la pestaña donde se aloja un producto
    func rotaPestaña(_ pest: VistaPestana, npest: Int){
        pest.setViewControllers([pest.paginas[npest]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil);
        pest.control?.currentPage=npest;
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
