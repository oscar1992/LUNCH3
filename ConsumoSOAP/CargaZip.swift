//
//  CargaZip.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 3/01/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit
import SSZipArchive

class CargaZip: NSObject {
    
    let fileManager = FileManager.default;
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory;
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask;
    var paths: String!;
    var entrada : String!;
    var salida : String!;
    var padre: CargaInicial!;
    var n  = 0;
    
    init(padre: CargaInicial){
        self.padre=padre;
    }
    
    func ejecuta(){
        rutas();
        if(!existenImagenes()){// No existen las imágenes
            if(existeZip()){
                for n in 0...9{
                    let rutaEntrada = entrada + ("/elzip"+String(n)+".zip");
                    descomprimir(rutaEntrada);
                }
                
            }else{
                bajaZip();
            }
        }else{
            agregaImagenes();
            padre.pasaLogin();
        }
        
    }
    
    //Método que establece las rutas de los directorios donde se descargará el zip y donde se descomprimian las Imagenes
    func rutas(){
        paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        self.entrada = ((paths)! + "/ZipI");
        self.salida = ((paths)! + "/Imagenes");
    }
    
    //Método que comprueba que el archivo zip se encuentre en el directorio de descarga
    func existeZip()->Bool{
        var retorna = false;
        for n in 0...9{
            let rutaEntrada = entrada + ("/elzip"+String(n)+".zip");
            if(fileManager.fileExists(atPath: rutaEntrada)){
                retorna = true;
            }else{
                retorna = false;
            }
        }
        
        print("Existe ZIP: ", retorna);
        return retorna;
    }
    
    //Método que comprueba que las imágenes se encuentren en el directorio de descarga
    func existenImagenes()-> Bool{
        var retorna = false;
        do{
            let lista = try fileManager.contentsOfDirectory(atPath: salida);
            if(lista.count == 0){
                retorna = false;
            }else{
                retorna = true;
            }
        }catch{
            print("No exsite directorio de Imágenes")
        }
        return retorna;
    }
    
    //Mñetodo que descomprime el archivo zip guardado
    func descomprimir(_ ruta: String){
        //let rutaEntrada = entrada.stringByAppendingString("/elzip2.zip");
        //for n in 0...9{
            //let rutaEntrada = entrada.stringByAppendingString("/elzip"+String(n)+".zip");
            print("ruta: ", ruta);
            if(SSZipArchive.unzipFile(atPath: ruta, toDestination: salida)){
                print("OK descompresion zip: ");
                agregaImagenes();
            }else{
                print("Error descompresion zip");
            }
        
        //}
       
    }
    
    //Método que descarga el zip en la ruta de entrada
    func bajaZip(){
        for n in 0...9{
            let bajaZip = ConsultaZip(entrada: entrada, fileM: fileManager, padre: self);
            bajaZip.descarga(n);
            print("Bajo?");
        }
    }
    
    //Método que carga las imagenes descargadas y las agrega a la lista de productos;
    func agregaImagenes(){
        print("Agrega Imagenes: ");
        if(existenImagenes()){
            var lista: [String];
            do{
                lista = try fileManager.contentsOfDirectory(atPath: self.salida);
            }catch{
                
            }
            for prod in DatosC.contenedor.productos{
                self.salida = ((paths)! + "/Imagenes/");
                let ruta = self.salida + prod.imagenString!;
                
                
                    let data = try? Data(contentsOf: URL(fileURLWithPath: ruta))
                if(data != nil){
                    //print("ruta: ", ruta);
                    //print("prod: ", prod.imagenString);
                    let imagen = UIImage(data: data!);
                    prod.imagen=imagen;
                }
                
                
                
                //print("IMA: ", prod.imagen);
            }
            for itemS in  DatosB.cont.prodSaludables{
                for prod in DatosC.contenedor.productos{
                    if(itemS.produ.id == prod.id){
                        itemS.produ.imagen=prod.imagen;
                    }
                }
                //print("PDSA: ", itemS.produ.imagen);
            }
            for tit in DatosC.contenedor.titems{
                for prod in DatosC.contenedor.productos{
                    if(tit.productos.id == prod.id){
                        tit.productos.imagen == prod.imagen;
                    }
                }
            }
            
        }
        if(n == 9){
            continuaPadre();
        }
        n += 1;
        print("n: ", n);
    }
    
    
    func continuaPadre() -> Void {
        //if(DatosB.cont.loginView.view == nil){
            padre.pasaLogin();
        //}
        
    }
}
