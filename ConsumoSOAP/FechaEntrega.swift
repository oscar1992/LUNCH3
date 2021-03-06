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
        sabadosMes();
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
        ////print("dia S: ", diasemana, " vs ", 1);
        fechaComp.day = ndia;
        ////print("Dia Semana: ", diasemana," Hora: ", hora);
        if(diasemana >= 6 && hora >= 18){
            fechaComp.weekOfMonth = nsemana.weekOfMonth!+2;
        }
        if(fechaComp.day!>=23&&fechaComp.day!<=31){
            let ultimoDia = (calendar as NSCalendar).component(.day, from: endOfMonth());
            ////print("pasa mes: ", ultimoDia);
            if(ultimoDia>30){
                fechaComp.day = fechaComp.day! + (7-(diasemana-1));
            }else{
                fechaComp.day = fechaComp.day! + (7-(diasemana-1));
            }
            
            //fechaComp.month = fechaComp.month! + 1;
            if(fechaComp.month!>12){
                fechaComp.month=1;
                fechaComp.year = fechaComp.year! + 1;
            }
        }else{
            ////print("retorno a domingo: ", (diasemana-1));
            fechaComp.day = fechaComp.day! + (7-(diasemana-1));
        }
        
        ////print("pre fecha: ", fechaComp.day);
        _ = calendar.date(from: fechaComp);
        ////print("pre fecha: ", fechaa);
        
        
        //let fecha = calendar.date(from: fechaComp);
        let fecha = sabadosMes();
        
        let formateador:DateFormatter=DateFormatter();
        
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="yyyy-MM-dd hh:mm:ss-";
        let fecha1 = formateador.string(from: fecha)+"04";
        formateador.dateFormat="EEEE dd 'de' MMMM";
        fechaMuestra = formateador.string(from: fecha);
        ////print("Fecha Siguiente: ", fecha1);
        ////print("Fecha Siguiente2: ", fechaMuestra);
        return fecha1;
        
    }
    
    func sabadosMes()->Date{
        let calendar = Calendar.current;
        var fechaComp = DateComponents();
        let nyear = (calendar as NSCalendar).components(.year, from: Date());
        let nmes = (calendar as NSCalendar).components(.month, from: Date());
        var hoy = (calendar as NSCalendar).components(.day, from: Date());
        let hoySemana = (calendar as NSCalendar).component(.weekday, from: Date());
        let hoyHora = (calendar as NSCalendar).component(.hour, from: Date());
        fechaComp.year = nyear.year;
        fechaComp.month = nmes.month;
        var sabados = [Date]();
        //print("Hoy semana: ", hoySemana," hora: ", hoyHora);
        var finMes = 31;
        if(hoySemana >= 6 && hoyHora >= 14){
            //print("Pre hoy: ", hoy);
            hoy.day = hoy.day! + 7;
            finMes += 14;
            //print("Hoy: ", hoy);
        }
        for d in 1...finMes{
            fechaComp.day = d;
            let fecha = calendar.date(from: fechaComp);
            let diasemana = (calendar as NSCalendar).component(.weekday, from: fecha!);
            
            if(diasemana == 1){
                ////print("sabados: ", fecha);
                sabados.append(fecha!);
            }
        }
        var i = 0;
        var ret = Date();
        var mes = (calendar as NSCalendar).components(.month, from: sabados.first!);
        for sabado in sabados{
            //print("mesAnt: ", mes, " actual: ", (calendar as NSCalendar).components(.month, from: sabado));
            if(mes.month! < ((calendar as NSCalendar).components(.month, from: sabado)).month!){
                hoy.day = hoy.day! - ((calendar as NSCalendar).components(.day, from: endOfMonth())).day!;
            }
            let diaS = (calendar as NSCalendar).components(.day, from: sabado);
            //print("domingo: ", sabado);

            if(hoy.day! < diaS.day!){
                ret = sabados[i];
                break;
            }
            i += 1;
        }
        //print("elección: ", ret);
        return ret;
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: NSDate() as Date)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }

    
}
