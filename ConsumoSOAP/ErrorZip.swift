//
//  ErrorZip.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 23/01/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class ErrorZip: UIView {
   
    var icono:UIView!;
    var texto: UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        iniciaFondo();
        iniciaImagen();
        print("Inicia");
    }
    
    func iniciaImagen(){
        let altoIma = self.frame.height*0.3;
        let OXima = (self.frame.height/2)-(altoIma/2);
        let OYIma = self.frame.height*0.1;
        let imagenFrame = CGRect(x: OXima, y: OYIma, width: altoIma, height: altoIma);
        icono = UIView(frame: imagenFrame);
        DatosB.cont.poneFondoTot(icono, fondoStr: "ICO Triste", framePers: nil, identi: nil, scala: true);
        self.addSubview(icono);
    }
    
    func iniciaFondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "Base 2", framePers: nil, identi: nil, scala: false);
        let anchoT = self.frame.width*0.8;
        let altoT = self.frame.height*0.3;
        let OXT = (self.frame.width/2)-(anchoT/2);
        let OYT =  (self.frame.height*0.4);
        let frameT = CGRect(x: OXT, y: OYT, width: anchoT, height: altoT);
        let mensaje = UILabel(frame: frameT);
        mensaje.numberOfLines=2;
        mensaje.font=UIFont(name: "Gotham Bold", size: mensaje.frame.height);
        mensaje.adjustsFontSizeToFitWidth=true;
        mensaje.text="Error bajando imágenes, Revisa tu conexión a internet";
        mensaje.textAlignment=NSTextAlignment.center;
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ErrorZip.cierra), userInfo: nil, repeats: false);
        self.addSubview(mensaje);
        
    }
    
    func cierra(){
        let fileManager = FileManager.default;
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory;
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask;
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        let dir = ((paths)! + "/ZipI");
        let dir2 = ((paths)! + "/Imagenes");
        do{
            try fileManager.removeItem(atPath: dir);
            print("Borra Zips incompletos OK");
            
        }catch{
            print("No se pudo borrar Zips incompletos")
        }
        do{
            try fileManager.removeItem(atPath: dir2);
            print("Borra Imagenes OK");
        }catch{
            print("No se pudo borrar Imagenes incompletas");
        }
        exit(0);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
