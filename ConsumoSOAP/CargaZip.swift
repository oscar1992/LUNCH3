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
    
    let fileManager = NSFileManager.defaultManager();
    let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory;
    let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask;
    var paths: String!;
    var entrada : String!;
    var salida : String!;
    var padre: CargaInicial!;
    
    init(padre: CargaInicial){
        self.padre=padre;
    }
    
    func ejecuta(){
        rutas();
        if(!existenImagenes()){// No existen las imágenes
            if(existeZip()){
                descomprimir();
            }else{
                bajaZip();
            }
        }else{
            agregaImagenes();
        }
        
    }
    
    //Método que establece las rutas de los directorios donde se descargará el zip y donde se descomprimian las Imagenes
    func rutas(){
        paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        self.entrada = (paths?.stringByAppendingString("/ZipI"))!;
        self.salida = (paths?.stringByAppendingString("/Imagenes"))!;
    }
    
    //Método que comprueba que el archivo zip se encuentre en el directorio de descarga
    func existeZip()->Bool{
        var retorna = false;
        entrada = paths.stringByAppendingString("/elzip2.zip")
        if(fileManager.fileExistsAtPath(entrada)){
            retorna = true;
        }else{
            retorna = false;
        }
        print("Existe ZIP: ", retorna);
        return retorna;
    }
    
    //Método que comprueba que las imágenes se encuentren en el directorio de descarga
    func existenImagenes()-> Bool{
        var retorna = false;
        do{
            let lista = try fileManager.contentsOfDirectoryAtPath(salida);
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
    func descomprimir(){
        //let rutaEntrada = entrada.stringByAppendingString("/elzip2.zip");
        if(SSZipArchive.unzipFileAtPath(entrada, toDestination: salida)){
            print("OK descompresion zip");
            agregaImagenes();
        }else{
            print("Error descompresion zip");
        }
    }
    
    //Método que descarga el zip en la ruta de entrada
    func bajaZip(){
        let bajaZip = ConsultaZip(entrada: entrada, fileM: fileManager, padre: self);
        bajaZip.descarga();
        print("Bajo?");
    }
    
    //Método que carga las imagenes descargadas y las agrega a la lista de productos;
    func agregaImagenes(){
        print("Agrega Imagenes: ");
        if(existenImagenes()){
            var lista: [String];
            do{
                lista = try fileManager.contentsOfDirectoryAtPath(self.salida);
            }catch{
                
            }
            for prod in DatosC.contenedor.productos{
                self.salida = (paths?.stringByAppendingString("/Imagenes/"))!;
                let ruta = self.salida.stringByAppendingString(prod.imagenString!);
                //print("ruta: ", ruta);
                let data = NSData(contentsOfFile: ruta)
                let imagen = UIImage(data: data!);
                prod.imagen=imagen;
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
        continuaPadre();
    }
    
    
    func continuaPadre() -> Void {
        padre.pasaLogin();
    }
}
