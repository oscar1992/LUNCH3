//
//  FechaEntrega.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 19/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class FechaEntrega: NSObject {
    var idFecha: Int;
    var fecha: String;
    var nDia: Int;
    var fechaSiguiente:String!;
    var fechaMuestra:String!;
    
    init(id: Int, nom: String, ndia: Int){
        self.idFecha=id;
        self.fecha=nom;
        self.nDia=ndia;
        super.init();
        self.fechaSiguiente=fechaSig();
    }
    
    func fechaSig()->String{
        let calendar = NSCalendar.currentCalendar();
        let fechaComp = NSDateComponents();
        let nyear = calendar.components(.Year, fromDate: NSDate());
        let nmes = calendar.components(.Month, fromDate: NSDate());
        let nsemana = calendar.components(.WeekOfMonth, fromDate: NSDate());
        let diasemana = calendar.component(.Weekday, fromDate: NSDate());
        let hora = calendar.component(.Hour, fromDate: NSDate());
        _ = calendar.components(.Day, fromDate: NSDate());
        fechaComp.year = nyear.year;
        fechaComp.month = nmes.month;
        fechaComp.weekOfMonth = nsemana.weekOfMonth+1;
        fechaComp.weekday = 1;
        print("Dia Semana: ", diasemana," Hora: ", hora);
        if(diasemana == 7 && hora >= 18){
            fechaComp.weekOfMonth = nsemana.weekOfMonth+2;
        }
        
        //print("pre fecha: ", fechaComp.day);
        let fechaa = calendar.dateFromComponents(fechaComp);
        //print("pre fecha: ", fechaa);
        if(fechaComp.day>=23&&fechaComp.day<=31){
            fechaComp.month += 1;
            if(fechaComp.month>12){
                fechaComp.month=1;
                fechaComp.year += 1;
            }
        }
        let fecha = calendar.dateFromComponents(fechaComp);
        
        let formateador:NSDateFormatter=NSDateFormatter();
        
        formateador.locale = NSLocale.init(localeIdentifier: "es_CO");
        formateador.dateFormat="yyyy-MM-dd hh:mm:ss-";
        var fecha1 = formateador.stringFromDate(fecha!)+"04";
        formateador.dateFormat="EEEE dd 'de' MMMM";
        fechaMuestra = formateador.stringFromDate(fecha!);
        print("Fecha Siguiente: ", fecha1);
        print("Fecha Siguiente2: ", fechaMuestra);
        return fecha1;
        
    }
    

    
}
