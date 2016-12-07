//
//  DatosK.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 5/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

struct KeysPrimariasK{
    static var alto : CGFloat!;
    static var tecladoFrame: CGRect!;
    static var origen: CGFloat!;
}

class DatosK: NSObject {
    static let cont = DatosK();
    var alto: CGFloat!;
    var tecladoFrame:CGRect!;
    var arriba=false;
    var origen: CGFloat!;
    
    
    func subeVista(vista: UIView){
        
        if(vista.frame.origin.y>=0){
            //print("sube: ", vista.accessibilityIdentifier);
            //print("qq: ", vista, "tecladoFrame.height", tecladoFrame.height);
            //print("frameV: ", vista.frame);
            let frameVista = CGRectMake(vista.frame.origin.x, (vista.frame.origin.y-tecladoFrame.height), vista.frame.width, vista.frame.height);
            vista.frame=frameVista;
            //print("frameV: ", vista.frame);
            arriba=true;
        }
        
    }
    
    func bajaVista(vista: UIView){
        //print("baja");
        if(vista.frame.origin.y<0){
            //print("frameV: ", vista.frame);
            let frameVista = CGRectMake(vista.frame.origin.x, 0, vista.frame.width, vista.frame.height);
            vista.frame=frameVista;
            //print("frameV: ", vista.frame);
            arriba=false;
        }
        
    }
    
    func subeVistaCreaUsuario(vista: UIView){
        if(vista.frame.origin.y>=0){
            //print("sube: ", vista.accessibilityIdentifier);
            //print("qq: ", vista, "tecladoFrame.height", tecladoFrame.height);
            //print("frameV: ", vista.frame);
            let frameVista = CGRectMake(vista.frame.origin.x, -origen, vista.frame.width, vista.frame.height);
            vista.frame=frameVista;
            //print("frameV: ", vista.frame);
            arriba=true;
        }
    }
    
    func subeVistaCantidad(vista: UIView, cant: CGFloat){
        if(vista.frame.origin.y>=0){
            let frameVista = CGRectMake(vista.frame.origin.x, (vista.frame.origin.y-cant), vista.frame.width, vista.frame.height);
            vista.frame=frameVista;
            arriba=true;
        }
    }
    
    func bajaVistaCantidad(vista: UIView, cant: CGFloat){
        if(vista.frame.origin.y<0){
            let frameVista = CGRectMake(vista.frame.origin.x, 0, vista.frame.width, vista.frame.height);
            vista.frame=frameVista;
            arriba=false;
        }
    }
}
