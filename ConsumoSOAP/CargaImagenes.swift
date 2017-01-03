//
//  CargaImagenes.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 23/12/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit
import Zip


class CargaImagenes: NSObject{
    
    var ciclo = 1;
    let tama = 10;
    var errores = [Producto]();
    
    //Método que descarga el archivo Zip desde el servidor
    func bajaZip(){
        
    }
    
    //Método que descomprime el archivo Zip
    func descomprime(){
        let ruta = "";
        do{
            let directorioDescompresion = Zip.quickUnzipFile(ruta);
        }catch{
            print("Error descomprimiendo Imágenes")
        }
    }

}