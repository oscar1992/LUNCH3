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
    
    let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory;
    let nsUserDomainMask    = NSSearchPathDomainMask.UserDomainMask;
    let fileManager = NSFileManager.defaultManager();
    var cInicial : CargaInicial?;
    
    //Constructor que pidecomo parámetro la clase desde la cual se llama para poder seguir iterando;
    init(cInicial: CargaInicial) {
        self.cInicial=cInicial;
        
    }
    
    //Método que guarda varios tipos de listas en el dispositivo
    func guarda(lista: [AnyObject], tipo: AnyClass){
        
        cInicial!.iniciaEvaluacion();
        print("Inicia persistencia: ", tipo);
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        switch tipo {
        case is Producto.Type:
            datosURL = (paths?.stringByAppendingString("/Productos"))!;
            break;
        case is TipoInfo.Type:
            datosURL = (paths?.stringByAppendingString("/TipoInfo"))!;
            break;
        case is Tag.Type:
            datosURL = (paths?.stringByAppendingString("/Tag"))!;
            break;
        case is Saludable.Type:
            datosURL = (paths?.stringByAppendingString("/Saludable"))!;
            break;
        case is Favoritos.Type:
            datosURL = (paths?.stringByAppendingString("/Favoritos"))!;
            break;
        case is TItems.Type:
            datosURL = (paths?.stringByAppendingString("/TItems"))!;
            break;
        case is ProductoSaludable.Type:
            datosURL = (paths?.stringByAppendingString("/ProductoSaludable"))!;
            break;
        case is UIImage.Type:
            datosURL = (paths?.stringByAppendingString("/Imagenes"))!;
            break;
        default:
            print("Tipo desconocido: ", tipo);
            break;
        }
        
        if(!fileManager.fileExistsAtPath(datosURL!)){
            do{
                try fileManager.createDirectoryAtPath(datosURL!, withIntermediateDirectories: false, attributes: nil);
                //print("OK creacion directorio: ", datosURL);
                print("Guarda ", tipo, "tama", lista.count);
                var p = 0;
                for ele in lista{
                    switch tipo {
                    case is Producto.Type:
                        let prod = (ele as! Producto);
                        let rutaEle = datosURL?.stringByAppendingString("/"+String(prod.id));
                        let contenido = NSKeyedArchiver.archivedDataWithRootObject(prod);
                        fileManager.createFileAtPath(rutaEle!, contents: contenido, attributes: nil);
                        
                        break;
                    case is TipoInfo.Type:
                        let obj = (ele as! TipoInfo);
                        let rutaEle = datosURL?.stringByAppendingString("/"+String(p));
                        //print("P: ", p);
                        let contenido = NSKeyedArchiver.archivedDataWithRootObject(obj);
                        fileManager.createFileAtPath(rutaEle!, contents: contenido, attributes: nil);
                        p += 1;
                        break;
                    case is Tag.Type:
                        let obj = (ele as! Tag);
                        let rutaEle = datosURL?.stringByAppendingString("/"+String(obj.idTag));
                        let contenido = NSKeyedArchiver.archivedDataWithRootObject(obj);
                        fileManager.createFileAtPath(rutaEle!, contents: contenido, attributes: nil);
                        
                        break;
                    case is Saludable.Type:
                        let obj = (ele as! Saludable);
                        let rutaEle = datosURL?.stringByAppendingString("/"+String(obj.idSalud));
                        let contenido = NSKeyedArchiver.archivedDataWithRootObject(obj);
                        fileManager.createFileAtPath(rutaEle!, contents: contenido, attributes: nil);
                        
                        break;
                    case is Favoritos.Type:
                        let obj = (ele as! Favoritos);
                        let rutaEle = datosURL?.stringByAppendingString("/"+String(obj.id));
                        let contenido = NSKeyedArchiver.archivedDataWithRootObject(obj);
                        fileManager.createFileAtPath(rutaEle!, contents: contenido, attributes: nil);
                        
                        break;
                    case is TItems.Type:
                        let obj = (ele as! TItems);
                        //print("TIMEM a guardar: ", obj.id);
                        let rutaEle = datosURL?.stringByAppendingString("/"+String(obj.id));
                        let contenido = NSKeyedArchiver.archivedDataWithRootObject(obj);
                        fileManager.createFileAtPath(rutaEle!, contents: contenido, attributes: nil);
                        
                        break;
                    case is ProductoSaludable.Type:
                        let obj = (ele as! ProductoSaludable);
                        print("Producto Saludable: ", obj.id);
                        let rutaEle = datosURL?.stringByAppendingString("/"+String(obj.id));
                        let contenido = NSKeyedArchiver.archivedDataWithRootObject(obj);
                        fileManager.createFileAtPath(rutaEle!, contents: contenido, attributes: nil);
                        break;
                    default:
                        print("Tipo desconocido: ", tipo);
                        break;
                    }
                    
                }
            }catch{
                print("NO se pudo crear el directorio: ", datosURL);
            }
            
        }else{
            print("Directorio existe: ", datosURL);
            lee(tipo);
        }
    }
    
    //Método que lee los archivos almacenados en el dispositivo
    func lee(tipo: AnyClass){
        print("Inica Lectura: ", tipo);
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        switch tipo {
        case is Producto.Type:
            datosURL = (paths?.stringByAppendingString("/Productos"))!;
            break;
        case is TipoInfo.Type:
            datosURL = (paths?.stringByAppendingString("/TipoInfo"))!;
            break;
        case is Tag.Type:
            datosURL = (paths?.stringByAppendingString("/Tag"))!;
            break;
        case is Saludable.Type:
            datosURL = (paths?.stringByAppendingString("/Saludable"))!;
            break;
        case is Favoritos.Type:
            datosURL = (paths?.stringByAppendingString("/Favoritos"))!;
            break;
        case is TItems.Type:
            datosURL = (paths?.stringByAppendingString("/TItems"))!;
            break;
        case is ProductoSaludable.Type:
            datosURL = (paths?.stringByAppendingString("/ProductoSaludable"))!;
            break;
        default:
            print("Tipo desconocido: ", tipo);
            break;
        }
        do{
            let lista = try fileManager.contentsOfDirectoryAtPath(datosURL!);
            carga(tipo, lista: lista, ruta: datosURL);
            print("tama: ", lista.count);
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
    
    func carga(tipo: AnyClass, lista: [String], ruta: String){
        switch tipo {
        case is Producto.Type:
            DatosC.contenedor.productos.removeAll();
            for ele in lista{
                let rutaEle = ruta.stringByAppendingString("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObjectWithData(fileManager.contentsAtPath(rutaEle)!));
                print("FECHA PROD: ",(prod as! Producto).ultimaActualizacion);
                DatosC.contenedor.productos.append(prod as! Producto);
            }
            
            break;
        case is TipoInfo.Type:
            DatosB.cont.listaTInfo.removeAll();
            print("TAMAINFO: ", lista.count);
            for ele in lista{
                let rutaEle = ruta.stringByAppendingString("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObjectWithData(fileManager.contentsAtPath(rutaEle)!));
                //print("TIPOINFO: ", (prod as! TipoInfo).valor);
                DatosB.cont.listaTInfo.append(prod as! TipoInfo);
            }
            
            break;
        case is Tag.Type:
            DatosD.contenedor.tags.removeAll();
            for ele in lista{
                let rutaEle = ruta.stringByAppendingString("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObjectWithData(fileManager.contentsAtPath(rutaEle)!));
                DatosD.contenedor.tags.append(prod as! Tag);
            }
            break;
        case is Saludable.Type:
            DatosB.cont.saludables.removeAll();
            for ele in lista{
                let rutaEle = ruta.stringByAppendingString("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObjectWithData(fileManager.contentsAtPath(rutaEle)!));
                DatosB.cont.saludables.append(prod as! Saludable);
            }
            break;
        case is Favoritos.Type:
            DatosB.cont.favoritos.removeAll();
            for ele in lista{
                let rutaEle = ruta.stringByAppendingString("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObjectWithData(fileManager.contentsAtPath(rutaEle)!));
                DatosB.cont.favoritos.append(prod as! Favoritos);
            }
            break;
        case is TItems.Type:
            DatosB.cont.itemsFavo.removeAll();
            for ele in lista{
                let rutaEle = ruta.stringByAppendingString("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObjectWithData(fileManager.contentsAtPath(rutaEle)!));
                DatosB.cont.itemsFavo.append(prod as! TItems);
            }
            break;
        case is ProductoSaludable.Type:
            DatosB.cont.prodSaludables.removeAll();
            for ele in lista{
                let rutaEle = ruta.stringByAppendingString("/"+ele);
                let prod = (NSKeyedUnarchiver.unarchiveObjectWithData(fileManager.contentsAtPath(rutaEle)!));
                DatosB.cont.prodSaludables.append(prod as! ProductoSaludable);
            }
            break;
        case is UIImage.Type:
            
            break;
        default:
            print("Tipo desconocido: ", tipo);
            break;
        }
        print("Carga: ", tipo);
    }
    
    func exixte(tipo: AnyClass)->Bool{
        var retorna = false;
        print("Inicia Comprobación: ",tipo);
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL:String!;
        switch tipo {
        case is Producto.Type:
            datosURL = (paths?.stringByAppendingString("/Productos"))!;
            break;
        case is TipoInfo.Type:
            datosURL = (paths?.stringByAppendingString("/TipoInfo"))!;
            break;
        case is Tag.Type:
            datosURL = (paths?.stringByAppendingString("/Tag"))!;
            break;
        case is Saludable.Type:
            datosURL = (paths?.stringByAppendingString("/Saludable"))!;
            break;
        case is Favoritos.Type:
            datosURL = (paths?.stringByAppendingString("/Favoritos"))!;
            break;
        case is TItems.Type:
            datosURL = (paths?.stringByAppendingString("/TItems"))!;
            break;
        case is ProductoSaludable.Type:
            datosURL = (paths?.stringByAppendingString("/ProductoSaludable"))!;
            break;
        default:
            print("Tipo desconocido: ", tipo);
            break;
        }
        if(!datosURL.isEmpty){
            //if(fileManager.fileExistsAtPath(datosURL)){
                do{
                    let lista = try fileManager.contentsOfDirectoryAtPath(datosURL);
                    if(lista.count == 0){
                        print("Sin datos");
                        do{
                            try fileManager.removeItemAtPath(datosURL);
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
    
    
}