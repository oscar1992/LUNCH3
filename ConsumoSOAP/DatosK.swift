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
    
    
    func subeVista(_ vista: UIView){
        
        if(vista.frame.origin.y>=0){
            //print("sube: ", vista.accessibilityIdentifier);
            //print("qq: ", vista, "tecladoFrame.height", tecladoFrame.height);
            //print("frameV: ", vista.frame);
            let frameVista = CGRect(x: vista.frame.origin.x, y: (vista.frame.origin.y-tecladoFrame.height), width: vista.frame.width, height: vista.frame.height);
            vista.frame=frameVista;
            //print("frameV: ", vista.frame);
            arriba=true;
        }
        
    }
    
    func bajaVista(_ vista: UIView){
        print("baja");
        if(vista.frame.origin.y<0){
            //print("frameV: ", vista.frame);
            let frameVista = CGRect(x: vista.frame.origin.x, y: 0, width: vista.frame.width, height: vista.frame.height);
            vista.frame=frameVista;
            //print("frameV: ", vista.frame);
            arriba=false;
        }
        
    }
    
    func subeVistaCreaUsuario(_ vista: UIView){
        if(vista.frame.origin.y>=0){
            //print("sube: ", vista.accessibilityIdentifier);
            //print("qq: ", vista, "tecladoFrame.height", tecladoFrame.height);
            //print("frameV: ", vista.frame);
            let frameVista = CGRect(x: vista.frame.origin.x, y: -origen, width: vista.frame.width, height: vista.frame.height);
            vista.frame=frameVista;
            //print("frameV: ", vista.frame);
            arriba=true;
        }
    }
    
    func subeVistaCantidad(_ vista: UIView, cant: CGFloat){
        if(vista.frame.origin.y>=0){
            let frameVista = CGRect(x: vista.frame.origin.x, y: (vista.frame.origin.y-cant), width: vista.frame.width, height: vista.frame.height);
            vista.frame=frameVista;
            arriba=true;
        }
    }
    
    func bajaVistaCantidad(_ vista: UIView, cant: CGFloat){
        if(vista.frame.origin.y<0){
            let frameVista = CGRect(x: vista.frame.origin.x, y: 0, width: vista.frame.width, height: vista.frame.height);
            vista.frame=frameVista;
            arriba=false;
        }
    }
}
