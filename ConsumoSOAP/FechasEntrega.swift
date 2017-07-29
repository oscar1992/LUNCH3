//
//  FechasEntrega.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 07/10/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class FechasEntrega: NSObject {
    var fechaEntrega: NSDate;
    var fechaLimite: NSDate;
    var valor: Int;
    var fechaMuestra : String?;
    var horas = [Int]();
    
    init(fEntrega: NSDate, fLimite: NSDate, val: Int, horas: [Int]){
        
        self.fechaLimite=fLimite;
        self.fechaEntrega=fEntrega;
        self.valor=val;
        self.horas=horas;
        super.init();
        self.fechaMuestrador(fecha: self.fechaEntrega);
    }
    
    func fechaMuestrador(fecha: NSDate){
        let formateador:DateFormatter=DateFormatter();
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="EEEE dd 'de' MMMM";
        fechaMuestra = formateador.string(from: fecha as Date);
    }
    
    
}
