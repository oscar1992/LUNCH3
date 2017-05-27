//
//  CargaInicial2.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 15/12/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class CargaInicial2 : NSObject{
    
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory;
    let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask;
    let fileManager = FileManager.default;
    var cInicial : CargaInicial?;
    
    //Constructor que pidecomo parámetro la clase desde la cual se llama para poder seguir iterando;
    init(cInicial: CargaInicial) {
        self.cInicial=cInicial;
        
    }
    
    //Método que guarda varios tipos de listas en el dispositivo
    func guarda(_ lista: [AnyObject], tipo: AnyClass){
        cInicial!.iniciaEvaluacion();
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        switch tipo {
        case is Producto.Type:
            datosURL = ((paths)! + "/Productos");
            break;
        case is TipoInfo.Type:
            datosURL = ((paths)! + "/TipoInfo");
            break;
        case is Tag.Type:
            datosURL = ((paths)! + "/Tag");
            break;
        case is Saludable.Type:
            datosURL = ((paths)! + "/Saludable");
            break;
        case is Favoritos.Type:
            datosURL = ((paths)! + "/Favoritos");
            break;
        case is TItems.Type:
            datosURL = ((paths)! + "/TItems");
            break;
        case is ProductoSaludable.Type:
            datosURL = ((paths)! + "/ProductoSaludable");
            break;
        case is UIImage:
            datosURL = ((paths)! + "/Imagenes");
            break;
        default:
            print("Tipo desconocido: ", tipo);
            break;
        }
        
        if(!fileManager.fileExists(atPath: datosURL!)){
            do{
                try fileManager.createDirectory(atPath: datosURL!, withIntermediateDirectories: false, attributes: nil);
                //print("OK creacion directorio: ", datosURL);
                //print("Guarda ", tipo, "tama", lista.count);
                var p = 0;
                for ele in lista{
                    switch tipo {
                    case is Producto.Type:
                        let prod = (ele as! Producto);
                        let rutaEle = (datosURL)! + ("/"+String(prod.id));
                        let contenido = NSKeyedArchiver.archivedData(withRootObject: prod);
                        fileManager.createFile(atPath: rutaEle, contents: contenido, attributes: nil);
                        
                        break;
                    case is TipoInfo.Type:
                        let obj = (ele as! TipoInfo);
                        let rutaEle = (datosURL)! + ("/"+String(p));
                        //print("P: ", p);
                        let contenido = NSKeyedArchiver.archivedData(withRootObject: obj);
                        fileManager.createFile(atPath: rutaEle, contents: contenido, attributes: nil);
                        p += 1;
                        break;
                    case is Tag.Type:
                        let obj = (ele as! Tag);
                        let rutaEle = (datosURL)! + ("/"+String(obj.idTag));
                        let contenido = NSKeyedArchiver.archivedData(withRootObject: obj);
                        fileManager.createFile(atPath: rutaEle, contents: contenido, attributes: nil);
                        
                        break;
                    case is Saludable.Type:
                        let obj = (ele as! Saludable);
                        let rutaEle = (datosURL)! + ("/"+String(obj.idSalud));
                        let contenido = NSKeyedArchiver.archivedData(withRootObject: obj);
                        fileManager.createFile(atPath: rutaEle, contents: contenido, attributes: nil);
                        
                        break;
                    case is Favoritos.Type:
                        let obj = (ele as! Favoritos);
                        let rutaEle = (datosURL)! + ("/"+String(obj.id));
                        let contenido = NSKeyedArchiver.archivedData(withRootObject: obj);
                        fileManager.createFile(atPath: rutaEle, contents: contenido, attributes: nil);
                        
                        break;
                    case is TItems.Type:
                        let obj = (ele as! TItems);
                        //print("TIMEM a guardar: ", obj.id);
                        let rutaEle = (datosURL)! + ("/"+String(obj.id));
                        let contenido = NSKeyedArchiver.archivedData(withRootObject: obj);
                        fileManager.createFile(atPath: rutaEle, contents: contenido, attributes: nil);
                        
                        break;
                    case is ProductoSaludable.Type:
                        let obj = (ele as! ProductoSaludable);
                        //print("Producto Saludable: ", obj.id);
                        let rutaEle = (datosURL)! + ("/"+String(obj.id));
                        let contenido = NSKeyedArchiver.archivedData(withRootObject: obj);
                        fileManager.createFile(atPath: rutaEle, contents: contenido, attributes: nil);
                        break;
                    default:
                        print("Tipo desconocido: ", tipo);
                        break;
                    }
                    
                }
            }catch{
                //print("NO se pudo crear el directorio: ", datosURL);
            }
            
        }else{
            //print("Directorio existe: ", datosURL);
            lee(tipo);
        }
    }
    
    //Método que lee los archivos almacenados en el dispositivo
    func lee(_ tipo: AnyClass){
        print("Inica Lectura: ", tipo);
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        switch tipo {
        case is Producto.Type:
            datosURL = ((paths)! + "/Productos");
            break;
        case is TipoInfo.Type:
            datosURL = ((paths)! + "/TipoInfo");
            break;
        case is Tag.Type:
            datosURL = ((paths)! + "/Tag");
            break;
        case is Saludable.Type:
            datosURL = ((paths)! + "/Saludable");
            break;
        case is Favoritos.Type:
            datosURL = ((paths)! + "/Favoritos");
            break;
        case is TItems.Type:
            datosURL = ((paths)! + "/TItems");
            break;
        case is ProductoSaludable.Type:
            datosURL = ((paths)! + "/ProductoSaludable");
            break;
        case is UIImage.Type:
            //print("Lee imagenes");
            datosURL = ((paths)! + "/Imagenes");
            break;
        default:
            print("LEE Tipo desconocido: ", tipo);
            break;
        }
        do{
            let lista = try fileManager.contentsOfDirectory(atPath: datosURL!);
            carga(tipo, lista: lista, ruta: datosURL);
            //print("tama: ", lista.count);
            //for ll in lista{
                //let rutaEle = datosURL?.stringByAppendingString("/"+ll);
                //print("NN: ", rutaEle);
                //print("Trae", (NSKeyedUnarchiver.unarchiveObjectWithData(fileManager.contentsAtPath(rutaEle!)!)));
                //let prod = (NSKeyedUnarchiver.unarchiveObjectWithData(fileManager.contentsAtPath(rutaEle!)!))
                //print("prod: ", (prod as! Producto).nombre);
            //}
        }catch{
            print("Error leyendo archivos");
        }
        
    }
    
    func carga(_ tipo: AnyClass, lista: [String], ruta: String){
        switch tipo {
        case is Producto.Type:
            DatosC.contenedor.productos.removeAll();
            for ele in lista{
                let rutaEle = ruta + ("/"+ele);
                //print("Ruta: ", rutaEle);
                if(fileManager.fileExists(atPath: rutaEle)){
                    //print("Existe: ", fileManager.contents(atPath: rutaEle)) ;
                    let data = fileManager.contents(atPath: rutaEle)!
                    
                    let prod = (NSKeyedUnarchiver.unarchiveObject(with: data));
                    //print("FECHA PROD: ",(prod as! Producto).id);
                    DatosC.contenedor.productos.append(prod as! Producto);
                }else{
                    //print("NO existe")
                }
                
            }
            
            break;
        case is TipoInfo.Type:
            print("TInfo Viejos Pre Borrado:", DatosB.cont.listaTInfo.count);
            //DatosB.cont.listaTInfo.removeAll();
            print("TAMAINFO: ", lista.count);
            for ele in lista{
                let rutaEle = ruta + ("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObject(with: fileManager.contents(atPath: rutaEle)!));
                //print("TIPOINFO: ", (prod as! TipoInfo).valor);
                DatosB.cont.listaTInfo.append(prod as! TipoInfo);
            }
            print("TInfo Viejos :", DatosB.cont.listaTInfo.count);
            print("TInfo Nuevos :", DatosB.cont.listaTInfoNuevos.count);
            /*if(DatosB.cont.listaTInfoNuevos.count > 0){
                print("Agrega nuevos");
                for tinfoN in DatosB.cont.listaTInfoNuevos{
                    DatosB.cont.listaTInfo.append(tinfoN);
                    
                }
                
            }*/
            guardaTinfoNUevo();
            break;
        case is Tag.Type:
            DatosD.contenedor.tags.removeAll();
            for ele in lista{
                let rutaEle = ruta + ("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObject(with: fileManager.contents(atPath: rutaEle)!));
                DatosD.contenedor.tags.append(prod as! Tag);
            }
            break;
        case is Saludable.Type:
            DatosB.cont.saludables.removeAll();
            for ele in lista{
                let rutaEle = ruta + ("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObject(with: fileManager.contents(atPath: rutaEle)!));
                DatosB.cont.saludables.append(prod as! Saludable);
            }
            break;
        case is Favoritos.Type:
            DatosB.cont.favoritos.removeAll();
            for ele in lista{
                let rutaEle = ruta + ("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObject(with: fileManager.contents(atPath: rutaEle)!));
                DatosB.cont.favoritos.append(prod as! Favoritos);
            }
            break;
        case is TItems.Type:
            DatosB.cont.itemsFavo.removeAll();
            for ele in lista{
                let rutaEle = ruta + ("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObject(with: fileManager.contents(atPath: rutaEle)!));
                //print("item: ", prod);
                DatosB.cont.itemsFavo.append(prod as! TItems);
            }
            break;
        case is ProductoSaludable.Type:
            DatosB.cont.prodSaludables.removeAll();
            for ele in lista{
                let rutaEle = ruta + ("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObject(with: fileManager.contents(atPath: rutaEle)!));
                let prodS = (prod as! ProductoSaludable);
                for pp in DatosC.contenedor.productos{
                    if(prodS.produ.id == pp.id){
                        //print("PS: ", prodS.produ.nombre);
                        //print("PP:  ", pp.nombre);
                        prodS.produ.imagen=pp.imagen;
                    }
                }
                
                DatosB.cont.prodSaludables.append(prod as! ProductoSaludable);
            }
            break;
        case is UIImage.Type:
            //print("Carga Imagenes");
            for ele in lista{
                let rutaEle = ruta + ("/"+ele);
                print("rutaEle: ", rutaEle);
                if(fileManager.fileExists(atPath: rutaEle)){
                    do{
                        var ima = try (NSKeyedUnarchiver.unarchiveObject(with: fileManager.contents(atPath: rutaEle)!));
                        for prod in DatosC.contenedor.productos{
                            if(prod.id == Int(ele)){
                                //print("Asigna: ", prod.nombre, "ele: ", ele, " tt: ", ima);
                                prod.imagen=(ima as! UIImage);
                            }
                        }
                    }catch{
                        
                    }
                }else{
                    
                }
                
            }
            break;
        default:
            print("Tipo desconocido: ", tipo);
            break;
        }
        print("Carga: ", tipo);
    }
    
    func exixte(_ tipo: AnyClass)->Bool{
        var retorna = false;
        print("Inicia Comprobación: ",tipo);
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL:String!;
        switch tipo {
        case is Producto.Type:
            datosURL = ((paths)! + "/Productos");
            break;
        case is TipoInfo.Type:
            datosURL = ((paths)! + "/TipoInfo");
            break;
        case is Tag.Type:
            datosURL = ((paths)! + "/Tag");
            break;
        case is Saludable.Type:
            datosURL = ((paths)! + "/Saludable");
            break;
        case is Favoritos.Type:
            datosURL = ((paths)! + "/Favoritos");
            break;
        case is TItems.Type:
            datosURL = ((paths)! + "/TItems");
            break;
        case is ProductoSaludable.Type:
            datosURL = ((paths)! + "/ProductoSaludable");
            break;
        case is UIImage.Type:
            datosURL = ((paths)! + "/Imagenes");
            break;
        default:
            print("Tipo desconocido: ", tipo);
            break;
        }
        if(!datosURL.isEmpty){
            //if(fileManager.fileExistsAtPath(datosURL)){
                do{
                    let lista = try fileManager.contentsOfDirectory(atPath: datosURL);
                    if(lista.count == 0){
                        print("Sin datos");
                        do{
                            try fileManager.removeItem(atPath: datosURL);
                        }catch{
                            print("Error borrando directorio");
                        }
                        retorna = false;
                    }else{
                        print("Con datos");
                        retorna = true;
                    }
                }catch{
                    print("No existe el directorio: ", datosURL);
                }
            //}else{
                //print();
            //}
        }else{
            print("Error en tipo de lista");
        }
        return retorna;
    }
    
    //Método que permite almacaner los favoritos del padre, se tratan independuente de las otras cargas debido a que se actualizan siempre
    func guardaFavoritos(){
        print("Favoritos OK")
    }
    
    //Método que guarda las imágenes, independiente del método de guardar datos, ya que el switch no reconoce la clase como un tipo
    func guardaImagenes(_ lista: [Producto]){
        cInicial!.iniciaEvaluacion();
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        datosURL = ((paths)! + "/Imagenes");
        if(!fileManager.fileExists(atPath: datosURL!)){
            do{
                try fileManager.createDirectory(atPath: datosURL!, withIntermediateDirectories: false, attributes: nil);
                for ele in lista{
                    let obj = (ele);
                    let rutaEle = (datosURL)! + ("/"+String(obj.id));
                    let contenido = NSKeyedArchiver.archivedData(withRootObject: obj.imagen!);
                    fileManager.createFile(atPath: rutaEle, contents: contenido, attributes: nil);
                }
            }catch{
                
            }
        }
        lee(UIImage);
    }
    
    //Método que guarda la información nutricional si llegan datos nuevos
    func guardaTinfoNUevo(){
        print("Guarda Nuevos: ", DatosB.cont.listaTInfo.count);
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        datosURL = ((paths)! + "/TipoInfo");
        if(fileManager.fileExists(atPath: datosURL!)){
            
        }else{
            print("Entra - No directorio");
            do{
                var p = DatosB.cont.listaTInfo.count-1;
                print("Guarda Tinfo");
                for tinfo in DatosB.cont.listaTInfoNuevos{
                    print("info: ", p);
                    try fileManager.createDirectory(atPath: datosURL!, withIntermediateDirectories: false, attributes: nil);
                    let obj = (tinfo);
                    let rutaEle = (datosURL)! + ("/"+String(p));
                    let contenido = NSKeyedArchiver.archivedData(withRootObject: obj);
                    fileManager.createFile(atPath: rutaEle, contents: contenido, attributes: nil);
                    p += 1;
                }
            }catch{
                print("Error en guardado TInfo nuevo");
            }
        }
    }
    
}
