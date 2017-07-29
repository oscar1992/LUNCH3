//
//  DatosD.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 25/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

struct keysPrimarias2 {
    static let padre = Padre();
    static let ninos = [Ninos]();
    static let categorias = [Categoria]();
    static let favoritas = Caja();
    static let favOk = false;
    static let calendario = Calendario();
    static let tags = [Tag]();
    static let  diasCopia = [Dia]();
    static let fechas = [FechasEntrega]();
    
}


class DatosD {
    
    static var contenedor=DatosD();
    
    var padre = Padre();
    var ninos = [Ninos]();
    var categorias = [Categoria]();
    var favoritas = Caja();
    var favOk = false;
    var calendario = Calendario();
    var tags = [Tag]();
    var diasCopia = [Dia]();
    var fechas = [FechasEntrega]();
    
    static func elimina(){
        contenedor = DatosD();
    }
}
