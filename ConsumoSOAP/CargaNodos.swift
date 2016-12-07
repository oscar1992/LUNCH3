//
//  CargaNodos.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 19/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation

class CargaNodos: NSObject {
    
    var nodos=[NodoMapa]();
    
    func cargaNodosA(){
        var dir1: Direcciones!;
        var dir2: Direcciones!;
        var dir3: Direcciones!;
        var dir4: Direcciones!;
        for n in 0 ..< 4{
            
            switch n {
            case 0:
                let lat = 4.6509747;
                let lon = -74.0746498;
                dir1 = Direcciones(dir: "Cra 30 Cll 63", ciu: "Bogotá", lat: lat, lon: lon);
                break;
            case 1:
                let lat = 4.6478667;
                let lon = -74.0598306;
                dir2 = Direcciones(dir: "Cra 7 Cll 63", ciu: "Bogotá", lat: lat, lon: lon);
                break;
            case 2:
                let lat = 4.686872;
                let lon = -74.0592943;
                dir4 = Direcciones(dir: "Autopista Call 100", ciu: "Bogotá", lat: lat, lon: lon);
                break;
            case 3:
                let lat = 4.679897;
                let lon = -74.0407609;
                dir3 = Direcciones(dir: "Cra 7 Cll 100", ciu: "Bogotá", lat: lat, lon: lon);
                break;
            default:
                break;
            }
        }
        let nodo1 = NodoMapa(coordenadas: dir1, anterior: nil, siguiente: nil);
        let nodo2 = NodoMapa(coordenadas: dir2, anterior: nodo1, siguiente: nil);
        let nodo3 = NodoMapa(coordenadas: dir3, anterior: nodo2, siguiente: nil);
        nodo2.siguiente=nodo3;
        let nodo4 = NodoMapa(coordenadas: dir4, anterior: nodo3, siguiente: nodo1);
        nodo3.siguiente=nodo4;
        nodo1.anterior = nodo4;
        nodo1.siguiente = nodo2;
        
        nodo1.angulo();
        nodo2.angulo();
        nodo3.angulo();
        nodo4.angulo();
        
        nodos.append(nodo1);
        nodos.append(nodo2);
        nodos.append(nodo3);
        nodos.append(nodo4);
    }
    
    func cercania(punto: Direcciones){
        var qq = [(Double, Double, NodoMapa)]();
        for nodo in nodos{
            let lat = abs(nodo.coordenadas.latitud)-abs(punto.latitud);
            let lon = abs(nodo.coordenadas.longitud)-abs(punto.longitud);
            qq.append((lat, lon, nodo));
        }
        var rueda = true;
        var p = 0;
        var bajo1 = (0.0, NodoMapa(coordenadas: punto, anterior: nil, siguiente: nil));
        
        while (rueda) {
            if(bajo1.0==0.0){
                bajo1 = (sqrt((pow(qq[p].0, 2))+(pow(qq[p].1, 2))), qq[p].2);
            }
            let nodoSig = qq[p+1].2;
            
            let sig = (sqrt((pow(qq[p+1].0, 2))+(pow(qq[p+1].1, 2))), nodoSig);
            //print("b1: ",bajo1, "-", bajo1.1.coordenadas.direccion);
            //print("sig: ",sig); 
            //print("p: ", p);
            if(bajo1.0>sig.0){
                bajo1 = sig
            }
            p += 1;
            if(p>=qq.count-1){
                rueda=false;
            }
        }
        print("bajo: ", bajo1.0, "nodo: ", bajo1.1.coordenadas.direccion);
        var angulo = bajo1.1.anguloCercano(punto);
        print("angulo: ", angulo);
    }
}