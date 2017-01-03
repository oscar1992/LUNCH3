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
    static let carrito = Carrito();
    static let loncheras = [Lonchera2]();
    static let favoritos = [Favoritos]();
    static let itemsFavo = [TItems]();
    static var listaLoncheras = [(Lonchera2, Int)]();
    static var envia:Int!;
    static var FechasEntrega = [FechaEntrega]();
    static var HorasEntrega = [HoraEntrega]();
    static let loginView = LoginView();
    static let olvida1 = Olvida1();
    static let olvida2 = Olvida2();
    static let nodos = CargaNodos();
    static let datosPadre = DatosPadre();
    static let primeraVezCarrito = true;
    static let historial = Historial();
    static let tipos = Tipos();
    static let cargaProductos = false;
    static let listaTInfo = [TipoInfo]();
    
}

class DatosB: NSObject {
    static var cont = DatosB();
    var saludables = [Saludable]();
    var prodSaludables = [ProductoSaludable]();
    var home2 = Home2();
    var loncheras = [Lonchera2]();
    var favoritos = [Favoritos]();
    var itemsFavo = [TItems]();
    var listaLoncheras = [(Lonchera2, Int)]();
    var carrito = Carrito();
    var envia:Int!;
    var FechasEntrega = [FechaEntrega]();
    var HorasEntrega = [HoraEntrega]();
    var loginView = LoginView();
    var olvida1 = Olvida1();
    var olvida2 = Olvida2();
    var nodos = CargaNodos();
    var datosPadre = DatosPadre();
    var primeraVezCarrito = true;
    var historial = Historial();
    var tipos = Tipos();
    var cargaProductos : Bool?;
    var listaTInfo = [TipoInfo]();
    

    static func elimina(){
        cont = DatosB();
    }
    
    //Método que pone el fondo de TODO!
    func poneFondoTot(vista: UIView, fondoStr: String, framePers: CGRect?, identi: String?, scala: Bool){
        //print("PoneFondo: ", fondoStr);
        
        if(identi != nil){
            //print("identi: ", identi, "subs: ", vista.subviews.count);
            for sub in vista.subviews{
                //print("ssss: ", sub.accessibilityIdentifier);
                if sub.accessibilityIdentifier==identi!{
                    
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
            //print("asigna: ", identi);
            backImg.accessibilityIdentifier=identi;
        }
        vista.addSubview(backImg);
        vista.sendSubviewToBack(backImg);
    }
    
    //Método que agrega una lonchera y evalua
    func agregaLonchera(lonc: Lonchera2){
        let nlon = Lonchera2(frame: lonc.frame);
        nlon.nombr=lonc.nombr;

        for cas in lonc.casillas{
            print("casT: ", cas.elemeto?.producto?.nombre);
        }
        for ncas in 0..<4{
            print("ncas: ", ncas);
            if(lonc.casillas[ncas].elemeto != nil){
                //print("ncas: ", ncas);
                print("elecopia: ", lonc.casillas[ncas].elemeto!.producto!.nombre);
                let pv = lonc.casillas[ncas].elemeto;
                nlon.casillas[ncas]=Casilla(frame: lonc.casillas[ncas].frame);
                pv?.tipo=lonc.casillas[ncas].tipo;
                nlon.casillas[ncas].elemeto = lonc.casillas[ncas].elemeto!
                //nlon.setCasilla(ncas, prod: lonc.casillas[ncas].elemeto!.producto!);
                //nlon.casillas[ncas].seteaElemento(pv!, tipo: pv!.tipo!, ima: pv!.producto!.imagen, prod: pv!.producto!);
                //print("ele: ",nlon.casillas[ncas].elemeto!.producto!.nombre);
            }
            
        }
        nlon.valor=lonc.valor;
        nlon.contador=lonc.contador;
        //print("lon entra: ", nlon.nombr);
        /*
        listaLoncheras.append((nlon, 1));
        for ll in listaLoncheras{
            print("nom: ", ll.0.nombr);
        }*/
        for cas in nlon.casillas{
            print("cas: ", cas.elemeto?.producto?.nombre);
        }
        if (listaLoncheras.isEmpty){
            listaLoncheras.append((nlon, 1));
            //print("Nuevo");
        }else{
            //print("tama: ", listaLoncheras.count);
            var enco=true;
            var agrega = false;
            var p = 0;
            while(enco == true){
                //print("l1: ",listaLoncheras[p].0.nombr," l2: ",nlon.nombr);
                if(mismosProductos(listaLoncheras[p].0, lonc2: nlon)){
                    print("misma lonchera");
                    listaLoncheras[p].1 += 1;
                    enco = false;
                    agrega = true;
                }else{
                    print("diferente lonchera");
                }
                p += 1;
                if(p >= listaLoncheras.count){
                    enco = false;
                }
            }
            if(enco == false && agrega == false){
                listaLoncheras.append((nlon, 1));
            }
        }
        
        /*
        for ll in listaLoncheras{
            print("nom: ", ll.0.nombr, " cant: ", ll.1);
        }*/
    }
    
    //Método que cuenta las casillas llenas
    func casillasLlenas(casillas: [Casilla])->Int{
        var can = 0;
        for cas in casillas{
            if(cas.elemeto != nil){
                can += 1;
            }
        }
        return can;
    }
    
    //Método que evalua si las loncheras tienen los mismos productos
    func mismosProductos(lonc1: Lonchera2, lonc2: Lonchera2)-> Bool{
        if (casillasLlenas(lonc1.casillas)==casillasLlenas(lonc2.casillas)){
            var l1 = [Producto]();
            var l2 = [Producto]();
            for cas in lonc1.casillas{
                if(cas.elemeto != nil){
                    l1.append((cas.elemeto?.producto)!);
                }
            }
            for cas in lonc2.casillas{
                if(cas.elemeto != nil){
                    l2.append((cas.elemeto?.producto)!);
                }
            }
            return comparaListaProductos(l1, lista2: l2);
        }else{
            print("diff cants: L1: ",casillasLlenas(lonc1.casillas)," L2: ", casillasLlenas(lonc2.casillas));
            return false;
        }
    }
    
    //Método que evalua si las listas contiene los mismos productos en las mismas cantidades
    func comparaListaProductos(lista1 :[Producto], lista2: [Producto])-> Bool{
        var prodCants = [(Producto, Int)]();
        for prod1 in lista1{
            if(prodCants.isEmpty){
                prodCants.append((prod1, 1));
                //print("Nuevo");
            }else{
                var ingresa = false;
                for i in 0..<prodCants.count{
                    if(prodCants[i].0.id==prod1.id){
                        prodCants[i].1 += 1;
                        ingresa = true;
                    }
                }
                if(!ingresa){
                    prodCants.append((prod1, 1));
                    //print("Nuevo 2");
                }
            }
        }
        
        var prodCants2 = [(Producto, Int)]();
        for prod2 in lista2{
            if(prodCants2.isEmpty){
                prodCants2.append((prod2, 1));
                //print("Nuevo");
            }else{
                var ingresa = false;
                for i in 0..<prodCants2.count{
                    if(prodCants2[i].0.id==prod2.id){
                        prodCants2[i].1 += 1;
                        ingresa = true;
                    }
                }
                if(!ingresa){
                    prodCants2.append((prod2, 1));
                    //print("Nuevo 2");
                }
            }
        }
        var check = 0;
        if(prodCants.count == prodCants2.count){
            for np in 0 ..< prodCants.count{
                if(prodCants[np].0.id == prodCants2[np].0.id){
                    //print("mismo producto")
                    if(prodCants[np].1 == prodCants2[np].1){
                        //print("misma cantidad")
                        check += 1;
                    }
                }
            }
        }
        
        if(check == prodCants.count){
            
            return true;
        }else{
            
            return false;
        }
        /*
        for prods in prodCants{
            print("pp: ", prods.0.nombre, "cant: ", prods.1);
        }
        for prods in prodCants2{
            print("pp: ", prods.0.nombre, "cant: ", prods.1);
        }*/
    }
    
    //Método que transfiere de una lista plana a una lista con propiedades
    func conciliador(lista: [Producto])->NSArray{
        let array = NSArray();
        for prod in lista{
            array.setValue(prod, forKey: String(prod.id));
        }
        return array;
    }
    
    //Método que permite guardar una lista de datos en el dispositivo
    func guardaLista(lista: [Producto], nombre: String)->Bool{
        if(!nombre.isEmpty){
            let defaults = NSUserDefaults.standardUserDefaults();
            let datosManejables = NSKeyedArchiver.archivedDataWithRootObject(conciliador(lista));
            defaults.setObject(datosManejables, forKey: "Productos");
            defaults.synchronize()
            return true;
        }else{
            return false;
        }
    }
    
    //Método que permite recuperar una lista del dispositivo
    func recuperaLista(nombre: String)->AnyObject?{
        if(!nombre.isEmpty){
            return NSUserDefaults.standardUserDefaults().objectForKey(nombre);
        }else{
            return nil;
        }
    }
}
