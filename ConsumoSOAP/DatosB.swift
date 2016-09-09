//
//  DatosB.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 1/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

struct keysPrimariasB{
    static let saludables = [Saludable]();
    static let prodSaludables = [ProductoSaludable]();
    static let home2 = Home2();
    static let loncheras = [Lonchera2]();
    static let favoritos = [Favoritos]();
    static var itemsFavo = [TItems]();
}

class DatosB: NSObject {
    static let cont = DatosB();
    var saludables = [Saludable]();
    var prodSaludables = [ProductoSaludable]();
    var home2 = Home2();
    var loncheras = [Lonchera2]();
    var favoritos = [Favoritos]();
    var itemsFavo = [TItems]();
    
    func poneFondoTot(vista: UIView, fondoStr: String, framePers: CGRect?, identi: String?, scala: Bool){
        //print("PoneFondo: ", fondoStr);
        
        if(identi != nil){
            for sub in vista.subviews{
                if sub.accessibilityIdentifier==identi{
                    sub.removeFromSuperview();
                }
            }
        }
        var frameFondo:CGRect!;
        if(framePers == nil){
            frameFondo = CGRectMake(0, 0, vista.frame.width, vista.frame.height);
        }else{
            frameFondo = framePers;
        }
        let img = UIImage(named: fondoStr);
        let backImg=UIImageView(frame: frameFondo);
        
        if(scala){
            backImg.contentMode=UIViewContentMode.ScaleAspectFit;
        }
        
        backImg.image=img;
        if(identi != nil){
            backImg.accessibilityIdentifier=identi;
        }
        vista.addSubview(backImg);
        vista.sendSubviewToBack(backImg);
    }
    
    
}
