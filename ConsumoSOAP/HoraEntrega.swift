//
//  HoraEntrega.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 19/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class HoraEntrega: NSObject {
    var idHora:Int;
    var horaInicial:String;
    var horaFinal:String;
    var fechaEntrega:FechaEntrega;
    
    init(id: Int, horaIni: String, horaFin: String, fechaE: FechaEntrega) {
        self.idHora=id;
        self.horaInicial=horaIni;
        self.horaFinal=horaFin;
        self.fechaEntrega=fechaE;
    }
     
}
