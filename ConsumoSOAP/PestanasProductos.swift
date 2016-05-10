//
//  PestanasProductos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 20/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class PestanasProductos: UIButton {
    
    var subVista:VistaPestana?;
    var activo:Bool?;
    var tipo:Int?;
    var padre:UIView?;
        
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor=UIColor.redColor();
        if(subVista != nil){
            self.addSubview((subVista?.view)!);
        }else{
            subVista=VistaPestana(transitionStyle: UIPageViewControllerTransitionStyle.Scroll,
                                  navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal ,
                                  options:nil );
            
            
        }
        backgroundColor=UIColor.lightGrayColor();
        self.addTarget(self, action: #selector(PestanasProductos.cambia(_:)), forControlEvents: .TouchDown);
        self.subVista?.view.hidden=true;
        //print("crea");
        
    }
    
    func cambia(sender: UIButton){
        for pest in DatosC.contenedor.Pestanas{
            if(pest.activo==true){
                
                pest.activo=false;
                pest.backgroundColor=UIColor.lightGrayColor();
                pest.subVista!.view.hidden=true;
                //print("Activo: ",self.subVista!.view.hidden);
            }
            
        }
        if(activo==true){
            //print("Desactiva");
            self.activo=false;
            self.backgroundColor=UIColor.lightGrayColor();
            self.subVista!.view.hidden=true;
        }else{
            //print("Activa");
            self.activo=true;
            self.backgroundColor=UIColor.redColor();
            self.subVista!.view.hidden=false;
        }
    }
    
    func iniSlide()->VistaPestana{
        
        subVista?.view.frame=CGRectMake(0, (self.padre!.frame.height*0.2), DatosC.contenedor.anchoP, self.padre!.frame.height*0.5);
        //print("retama", subVista?.view.frame);
        subVista?.tipo=self.tipo;
        subVista?.carga();
        return subVista!;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
