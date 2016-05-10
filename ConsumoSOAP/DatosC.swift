//
//  DatosC.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 5/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

struct keysPrimarias {
    static let arreglo = [Casilla]();
    static let iActual = 0;
    static let vistaP = ViewController();
    static let anchoP = CGFloat();
    static let altoP = CGFloat();
    static let ninos = [BotonNino]();
    static let PantallaP = UIViewController();
    static let pantallaSV = PantallaSV();
    static let cajas = [Caja]();
    static let productos = [Producto]();
    static let secuencia = [Secuencia]();
    static let titems = [TItems]();
    static let primera = false;
    static let tamaLonchera = CGRect();
    static let loncheras = [LoncheraO]();
    static let lonchera = LoncheraO();
    static let tipo = Int?();
    static let casillaF=CGRect();
    static let Pestanas=[PestanasProductos]();
    static let casillasF = [CGRect]();
    
    }

class DatosC{
    static let contenedor=DatosC();
    
    
    var arreglo = [Casilla]();
    var iActual = 0;
    var vistaP = ViewController();
    var anchoP = CGFloat(0);
    var altoP = CGFloat(0);
    var ninos = [BotonNino]();
    var PantallaP = UIViewController();
    var pantallaSV = PantallaSV();
    var cajas = [Caja]();
    var productos = [Producto]();
    var secuencia = [Secuencia]();
    var titems = [TItems]();
    var lleno = false;
    var primera=false;
    var tamaLonchera = CGRect();
    var loncheras = [LoncheraO]();
    static var lonchera = LoncheraO();
    var tipo = Int?();
    var casillaF=CGRect();
    var Pestanas=[PestanasProductos]();
    var casillasF = [Casilla]();
    
    
    func cambia() {
        vistaP.pageControl.currentPage=iActual;
        for obj in arreglo{
            if(obj.lonchera?.id == iActual){
                obj.activo=true;
            }else{
                obj.activo=false;
            }
            
        }
    }
    
    func Check(){
        //print("Cajas: ",cajas.count);
        //print("Secuencia: ",secuencia.count);
        //print("Titem: ",titems.count);
        //print("Producto: ",productos.count);
        if(cajas.count==0)||(secuencia.count==0)||(titems.count==0)||(productos.count==0){
            lleno=false;
        }else{
            lleno=true;
            //print("lleno ",lleno);
        }
        
    }
}