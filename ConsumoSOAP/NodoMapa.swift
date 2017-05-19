//
//  NodoMapa.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 18/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class NodoMapa: NSObject{
    var coordenadas: Direcciones;
    var siguiente: NodoMapa?;
    var anterior: NodoMapa?;
    var anguloAnterior:Double!;
    var anguloSiguiente:Double!;
    var tangente:Bool!;
    
    init(coordenadas: Direcciones, anterior: NodoMapa?, siguiente: NodoMapa?) {
        self.coordenadas=coordenadas;
        self.siguiente=siguiente;
        self.anterior=anterior;
    }
    
    func angulo(){
        if(siguiente != nil && anterior != nil){
            print("Nodo: ", coordenadas.direccion);
            /*
            let angA = anguloAnterior();
            let angS = anguloSiguiente();
            
            print("Anterior: ", angA);
            print("Siguiente: ", angS);
            print("------------------");
            */
            llevaAcero(coordenadas, anteriores: (anterior?.coordenadas)!, siguientes: (siguiente?.coordenadas)!);
        }else{
            print("Nodo: ", coordenadas.direccion);
            print("SIGUIENTE: ", siguiente?.coordenadas.direccion);
            print("ANTERIOR: ", anterior?.coordenadas.direccion);
            print("------------------");
        }
        setTangente();
    }

    
    func angulo2(_ propia: Direcciones, evaluada: Direcciones)->Double{
        var grados: Double;
        let p1 = (0*evaluada.longitud)+(1*evaluada.latitud);
        let r1 = sqrt(pow(propia.longitud, 2)+pow(propia.latitud, 2));
        let r2 = sqrt(pow(evaluada.longitud, 2)+pow(evaluada.latitud, 2));
        let p2 = r1+r2;
        let pre = p1/p2;
        //print("p1: ", p1," p2: ", p2);
        //print("pre: ", pre);
        grados = (acos(pre)*180)/M_PI;
        //print("pregrados: ", grados);
        if(evaluada.longitud<0){
            grados = 360 - grados;
        }
        return grados;
    }
    
    func llevaAcero(_ propias: Direcciones, anteriores: Direcciones, siguientes: Direcciones){
        let pla = propias.latitud - propias.latitud;
        let plo = propias.longitud - propias.longitud;
        var ala:Double;
        if(propias.latitud < 0){
            ala = anteriores.latitud+propias.latitud;
        }else{
            ala = anteriores.latitud-propias.latitud;
        }
        var alo:Double;
        if(propias.longitud > 0){
            alo = anteriores.longitud+propias.longitud;
        }else{
            alo = anteriores.longitud-propias.longitud;
        }
        var sla:Double;
        if(propias.latitud < 0){
            sla = siguientes.latitud+propias.latitud;
        }else{
            sla = siguientes.latitud-propias.latitud;
        }
        var slo:Double;
        if(propias.longitud > 0){
            slo = siguientes.longitud+propias.longitud;
        }else{
            slo = siguientes.longitud-propias.longitud;
        }
        //print("pla: ", pla, " plo: ", plo, " ala: ", ala, " alo: ", alo, " sla: ", sla," slo: ", slo);
        let propia=Direcciones(dir: "", ciu: "", lat: pla, lon: plo);
        let anterior=Direcciones(dir: "", ciu: "", lat: ala, lon: alo);
        let siguiente=Direcciones(dir: "", ciu: "", lat: sla, lon: slo);
        anguloAnterior=angulo2(propia, evaluada: anterior);
        anguloSiguiente=angulo2(propia, evaluada: siguiente);
        print("anterior: ", angulo2(propia, evaluada: anterior));
        print("siguinete: ", angulo2(propia, evaluada: siguiente));
    }
    
    func anguloCercano(_ punto: Direcciones){
        print("punto: ", punto.latitud, "-- ", punto.longitud);
        let pla = coordenadas.latitud - coordenadas.latitud;
        let plo = coordenadas.longitud - coordenadas.longitud;
        var ala : Double;
        var alo : Double;
        if(coordenadas.latitud > 0){
            ala = punto.latitud-coordenadas.latitud;
        }else{
            ala = punto.latitud+coordenadas.latitud;
        }
        if(coordenadas.longitud > 0){
            alo = punto.longitud-abs(coordenadas.longitud);
        }else{
            alo = punto.longitud+abs(coordenadas.longitud);
        }
        let propia=Direcciones(dir: "", ciu: "", lat: pla, lon: plo);
        let anterior=Direcciones(dir: "", ciu: "", lat: ala, lon: alo);
        //print("pla: ", pla, " plo: ", plo, " ala: ", ala, " alo: ", alo);
        let angulo = angulo2(propia, evaluada: anterior)
        print("Angulo: ", angulo, "tangente: ", tangente, "mayor: ", mayor(), "anguloPlano: ", anguloPlano());
        if(anguloPlano()==true){
            if(tangente==true){
                if(anguloAnterior>anguloSiguiente){
                    var anguloizq=angulo;
                    var anguloder=angulo;
                    if(angulo > 180){
                        anguloder -= 360;
                    }else{
                        anguloizq += 360;
                        
                    }
                    if((anguloizq)>anguloAnterior&&(anguloder)<anguloSiguiente){
                        print("esta adentro")
                    }else{
                        print("está afuera");
                    }
                }else{
                    if(angulo<anguloAnterior&&angulo>anguloSiguiente){
                        print("esta adentro")
                    }else{
                        print("está afuera");
                    }
                }
            }else{
                
            }
        }else{
            if(anguloAnterior>anguloSiguiente){
                print("Angulo: ", angulo)
                if(angulo>anguloAnterior&&angulo<anguloSiguiente){
                    print("esta adentro");
                }else{
                    print("está afuera");
                }
            }else{
                if(angulo<anguloAnterior&&angulo>anguloSiguiente){
                    print("esta adentro");
                }else{
                    print("está afuera");
                }
            }
        }
        
    }
    
    
    
    func anguloPlano()->Bool{
        let angulos = mayor();
        if(angulos.0-angulos.1>=180){
            
            return true;
        }else{
            return false;
        }
    }

    
    func mayor()->(Double, Double){
        if(anguloSiguiente>anguloAnterior){
            return (anguloSiguiente, anguloAnterior);
        }else{
            return (anguloAnterior, anguloSiguiente);
        }
    }
    
    func setTangente(){
        let sig = siguiente;
        let ant = anterior;
        var bsig:Bool;
        var bant:Bool;
        if(sig?.coordenadas.latitud>self.coordenadas.latitud){
            bsig=true;
        }else{
            bsig=false;
        }
        if(ant?.coordenadas.latitud>self.coordenadas.latitud){
            bant=true;
        }else{
            bant=false;
        }
        tangente = bsig && bant;
    }
}
