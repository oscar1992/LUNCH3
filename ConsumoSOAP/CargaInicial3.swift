//
//  CargaInicial3.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 11/01/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class CargaInicial3: NSObject {
    
    let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory;
    let nsUserDomainMask    = NSSearchPathDomainMask.UserDomainMask;
    let fileManager = NSFileManager.defaultManager();
    
    var cIni: CargaInicial!;
    
    init(cInicial: CargaInicial){
        self.cIni=cInicial;
    }
    
    func comparaFechas(tipo: AnyClass){
        switch tipo {
        case is Producto.Type:
            comparaProductos();
            break;
        case is ProductoSaludable.Type:
            comparaProductoSaludables();
            break;
        default:
            cIni.iniciaEvaluacion();
            break;
        }
    }
    
    func comparaProductos(){
        print("Compara Producto");
        var listaIds = [Int]();
        var listaFechas = [NSDate]();
        for prod in DatosC.contenedor.productos{
            listaIds.append(prod.id);
            listaFechas.append(prod.ultimaActualizacion);
        }
        let productosN = ProductosNuevos(ids: listaIds, fechas: listaFechas, cInicial: self);
    }
    
    func comparaProductoSaludables(){
        print("Compara PSaludables");
        var listaIds = [Int]();
        var listaFechas = [NSDate]();
        for prodS in DatosB.cont.prodSaludables{
            listaIds.append(prodS.id);
            listaFechas.append(prodS.ultimaActualizacion);
        }
        let productoSN=ProductosSaludablesNuevos(ids: listaIds, fechas: listaFechas, cInicial: self);
    }
    
    func cambiaProductosNuevos(traeNuevos:[Producto]){
        for prodN in traeNuevos{
            print("Nuevos: ", prodN.id, " - ", prodN.nombre, " - ", prodN.disponible);
            var i = 0;
             for prodV in DatosC.contenedor.productos{
                 i += 1;
                if(prodV.disponible == false){
                    let indiceV = DatosC.contenedor.productos.indexOf(prodV);
                    DatosC.contenedor.productos.removeAtIndex(indiceV!);
                    print("Elimina: ", prodV.nombre);
                }
                if(prodV.id == prodN.id
                    ){
                    print("Reemplaza: ", prodV.nombre, "disp: ", prodN.disponible);
                    let indiceV = DatosC.contenedor.productos.indexOf(prodV);
                    DatosC.contenedor.productos.removeAtIndex(indiceV!);
                    DatosC.contenedor.productos.append(prodN);
                    print("NuevoV: ", prodN.nombre);
                    print("ViejoFecha: ", prodV.ultimaActualizacion);
                    print("NuevoVFecha: ", prodN.ultimaActualizacion);
                }else if(existeProducto(DatosC.contenedor.productos, idProd: prodN.id) == false){
                    if(prodN.disponible == false){
                        //print("No entra: ", prodN.nombre);
                    }else{
                        print("Nuevo-NuevoV: ", prodN.nombre);
                        DatosC.contenedor.productos.append(prodN);
                    }
                    
                }
            }
        }
        
        eliminaProductos();
        eliminaNoDisponibles();
        persisteProductos();
        let cargaTipoInfo = CargaTinfo2();
        cargaTipoInfo.cargaInformacion(cIni);
        //self.cIni.iniciaEvaluacion();
    }
    
    //Método que elimina los productos no disponibles
    func eliminaNoDisponibles(){
        print("Remueve?");
        var lista = [Producto]();
        for prod in DatosC.contenedor.productos{
            if(prod.disponible == true){
                lista.append(prod);
            }else{
                print("Elimina: ", prod.nombre);
            }
        }
        print("Tama A: ", DatosC.contenedor.productos.count);
        DatosC.contenedor.productos.removeAll();
        print("Tama B: ", DatosC.contenedor.productos.count);
        DatosC.contenedor.productos = lista;
        print("Tama C: ", DatosC.contenedor.productos.count);
    }
    
    //Método que busca y comprueba si el producto ya está en la lista
    func  existeProducto(lista: [Producto], idProd: Int) -> Bool {
        var retorna = false;
        for prod in lista{
            if(prod.id == idProd){
                retorna = true;
            }
        }
        return retorna;
    }
 
    func cambiaProductosSaludablesNuevos(traeNuevos: [ProductoSaludable]){
        for prodSN in traeNuevos{
            for prodSV in DatosB.cont.prodSaludables{
                if(prodSV.id == prodSN.id){
                    //print("Reemplaza: ", prodSV.produ.nombre);
                    let indiceV = DatosB.cont.prodSaludables.indexOf(prodSV);
                    DatosB.cont.prodSaludables.removeAtIndex(indiceV!);
                    DatosB.cont.prodSaludables.append(prodSN);
                    print("NuevoSV: ", prodSV.produ.nombre);
                }
            }
        }
        eliminaProductosSaludables();
        persisteProdutosSaludables();
       self.cIni.iniciaEvaluacion();
    }
    
    func terminaYpersisteP(){
        let cargaI2 = CargaInicial2(cInicial: self.cIni);
        cargaI2.guarda(DatosC.contenedor.productos, tipo: Producto.self);
    }
    
    func terminaYPersistePS(){
        let cargaI2 = CargaInicial2(cInicial: self.cIni);
        cargaI2.guarda(DatosB.cont.prodSaludables, tipo: ProductoSaludable.self);
        //self.cIni.iniciaEvaluacion();
    }
    
    func persisteProductos(){
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        datosURL = (paths?.stringByAppendingString("/Productos"))!;
        for prod in DatosC.contenedor.productos{
            //print("Persiste: ", prod.nombre," dispo: ", prod.disponible);
            
            let rutaEle = datosURL?.stringByAppendingString("/"+String(prod.id));
            let contenido = NSKeyedArchiver.archivedDataWithRootObject(prod);
            fileManager.createFileAtPath(rutaEle!, contents: contenido, attributes: nil);
        }
    }
    
    func persisteProdutosSaludables(){
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        datosURL = (paths?.stringByAppendingString("/ProductoSaludable"))!;
        for prod in DatosB.cont.prodSaludables{
            let rutaEle = datosURL?.stringByAppendingString("/"+String(prod.id));
            let contenido = NSKeyedArchiver.archivedDataWithRootObject(prod);
            fileManager.createFileAtPath(rutaEle!, contents: contenido, attributes: nil);
        }
    }
    
    //Método que elimina los productos que estén almacenados, TODOS!
    func eliminaProductos(){
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        datosURL = (paths?.stringByAppendingString("/Productos"))!;
        for prod in DatosC.contenedor.productos{
            let rutaEle = datosURL?.stringByAppendingString("/"+String(prod.id));
            if(fileManager.fileExistsAtPath(rutaEle!)){
                do{
                    try fileManager.removeItemAtPath(rutaEle!)
                    //print("BorraP OK: ", rutaEle);
                }catch{
                  print("No se pudo borarar: ", rutaEle);
                }
            }else{
                print("No existe el archivo: ", rutaEle)
            }
        }
    
    }
    
    func eliminaProductosSaludables(){
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        var datosURL : String!;
        datosURL = (paths?.stringByAppendingString("/ProductoSaludable"))!;
        for prod in DatosB.cont.prodSaludables{
            let rutaEle = datosURL?.stringByAppendingString("/"+String(prod.id));
            if(fileManager.fileExistsAtPath(rutaEle!)){
                do{
                    try fileManager.removeItemAtPath(rutaEle!)
                    //print("BorraPS : OK");
                }catch{
                    print("No se pudo borrar Saludable: ", rutaEle);
                }
            }else{
                print("No existe el archivo")
            }
        }
    }

}
