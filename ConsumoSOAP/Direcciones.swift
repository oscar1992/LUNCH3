//
//  Direccion.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 14/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation


class Direcciones: NSObject{
    
    var direccion: String;
    var ciudad: String;
    var latitud: Double;
    var longitud: Double;
    
    init(dir: String, ciu: String, lat: Double, lon: Double) {
        self.direccion=dir;
        self.ciudad=ciu;
        self.latitud=lat;
        self.longitud=lon;
    }
}