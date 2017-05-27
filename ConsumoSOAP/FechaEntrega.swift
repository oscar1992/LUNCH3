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
        let calendar = Calendar.current;
        var fechaComp = DateComponents();
        let nyear = (calendar as NSCalendar).components(.year, from: Date());
        let nmes = (calendar as NSCalendar).components(.month, from: Date());
        let nsemana = (calendar as NSCalendar).components(.weekOfMonth, from: Date());
        let diasemana = (calendar as NSCalendar).component(.weekday, from: Date());
        let hora = (calendar as NSCalendar).component(.hour, from: Date());
        let ndia = (calendar as NSCalendar).component(.day, from: Date());
        fechaComp.year = nyear.year;
        fechaComp.month = nmes.month;
        fechaComp.weekOfMonth = nsemana.weekOfMonth!+1;
        print("dia S: ", diasemana, " vs ", 1);
        fechaComp.day = ndia;
        print("Dia Semana: ", diasemana," Hora: ", hora);
        if(diasemana == 6 && hora >= 18){
            fechaComp.weekOfMonth = nsemana.weekOfMonth!+2;
        }
        if(fechaComp.day!>=23&&fechaComp.day!<=31){
            print("pasa mes");
            fechaComp.day = fechaComp.day! + (14-(diasemana-1));
            //fechaComp.month = fechaComp.month! + 1;
            if(fechaComp.month!>12){
                fechaComp.month=1;
                fechaComp.year = fechaComp.year! + 1;
            }
        }else{
            print("retorno a domingo: ", (diasemana-1));
            fechaComp.day = fechaComp.day! + (7-(diasemana-1));
        }
        
        print("pre fecha: ", fechaComp.day);
        let fechaa = calendar.date(from: fechaComp);
        print("pre fecha: ", fechaa);
        
        let fecha = calendar.date(from: fechaComp);
        
        let formateador:DateFormatter=DateFormatter();
        
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="yyyy-MM-dd hh:mm:ss-";
        var fecha1 = formateador.string(from: fecha!)+"04";
        formateador.dateFormat="EEEE dd 'de' MMMM";
        fechaMuestra = formateador.string(from: fecha!);
        print("Fecha Siguiente: ", fecha1);
        print("Fecha Siguiente2: ", fechaMuestra);
        return fecha1;
        
    }
    

    
}
