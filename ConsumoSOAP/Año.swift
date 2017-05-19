//
//  Año.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class An_o: UIView {
    /*
    
    var añoTit:UILabel?;
    var añoString:String?;
    var tamaMes : CGFloat?;
    var anchoMes : CGFloat?;
    var borde: CGFloat?;
    var bordeAncho : CGFloat?;
    var padre : AnoScroll!;
    var (meses, desf) = ([Mes](), CGFloat(0));
    var añoNumero:Int!;
    var nino : Ninos?;
    var mesString : UILabel?;
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        
        //self.backgroundColor=UIColor.yellowColor();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que crea el espacio del año que contendrá 6 meses a partir de la fecha actual
    func setAño(_ date: Date, espacio: CGRect)-> CGRect{
        anchoMes = espacio.width * 1;
        tamaMes = espacio.height * 0.9;
        borde = espacio.height * 0.05;
        bordeAncho = espacio.width * 0.1;
        let formateador:DateFormatter=DateFormatter();
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="yyyy";
        añoString = formateador.string(from: date);
        añoNumero = Int(añoString!);
        //añoTit=UILabel(frame: CGRectMake((self.frame.width/2)-25,(10), 100, 30));
        añoTit = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30));
        añoTit?.text=añoString;
        self.addSubview(añoTit!);
        var altoaño = CGFloat(0);
        (meses, desf) = (setMeses(date));
        //altoaño += (desf);
        for mes in meses{
            //self.addSubview(mes);
            altoaño += mes.frame.height;
            //altoaño + desf
            
            //print("altoMes: ", mes.frame.height, " - ", desf/2);
        }
        altoaño += desf;
        //altoaño += (meses.last?.frame.height)!+((bordeAncho!)*CGFloat(4));
        
        //print("deberia tener: ", ((((meses.last?.frame.height)!+bordeAncho!)*CGFloat(meses.count)))+bordeAncho!);
        //altoaño = ((((meses.last?.frame.height)!+desf)*CGFloat(meses.count)))+bordeAncho!;
        //print("alto final: ", altoaño);
        //altoaño += (desf*CGFloat(meses.count));
        let frameAño = CGRect(x: 0, y: 0, width: espacio.width, height: altoaño);
        self.frame = frameAño;
        
        return frameAño;
    }
    
    //Método llamado de la funcion de setear el año actual, que incializa los objetos de los 6 meses contenidos
    func setMeses(_ date: Date)-> ([Mes], CGFloat){
        var fechaManejo = date;
        var cambiaAño = false;
        var meses = [Mes]();
        let calendar=Calendar.current;
        var mesActual=(calendar as NSCalendar).component(.month, from: date);
        var AñoActual = (calendar as NSCalendar).component(.year, from: date);
        let formateador:DateFormatter=DateFormatter();
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="yyyyMMdd";
        var desfaz = CGFloat(0);
        var desfaz2 = CGFloat(0);
        for nmes in 0 ..< 15{
            if(mesActual > 6){
                mesActual = mesActual - 12;
                //Cambio de año
                var fecha2 = DateComponents();
                
                AñoActual += 1;
                fecha2.year = AñoActual;
                fecha2.month = mesActual;
                fechaManejo=Calendar.current.date(from: fecha2)!;
                cambiaAño = true;
                print("Cambio de año: ", AñoActual);
                //print("Fecha: ", formateador.stringFromDate(fechaManejo));
                desfaz = 0;
            }
            
            //print("Num mes: ", mesActual);
            let frameMes = CGRect(x: (bordeAncho!/2), y: (borde!+desfaz)+((CGFloat(nmes) * tamaMes!))+((CGFloat(nmes) * 0.05)), width: anchoMes!, height: tamaMes!);
            //print("frame: ", frameMes);
            //let mes = Mes(frame: frameMes, nmes: mesActual);
            //setDias(fechaManejo, nmes: mes);
            mesActual += 1;
            if(cambiaAño){
                //desfaz = (meses.last?.frame.height)!;
            }
            //desfaz += ubicaDias(mes, nmes: nmes, cambiaAño: cambiaAño);
            desfaz2 += desfaz;
            if(cambiaAño){
                desfaz = 0;
                cambiaAño = false;
            }
            //print("LLega desfaz: ", desfaz);
            //mes.ano=self;
            //meses.append(mes);
            //mes.dias.last?.setFondo2(2);
        }
        
        return (meses, desfaz2);
    }
    
    //Método que inicia y valida los días dentro de un mes
    func setDias(_ date: Date, nmes: Mes){
        
        let calendar = Calendar.current;
        var fechaComp = DateComponents();
        let año = (calendar as NSCalendar).components(.year, from: date);
        //let mes = calendar.components(.Month, fromDate: date);
        
        
        let formateador:DateFormatter=DateFormatter();
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="yyyyMMdd";
        var sema: Int?
        var dias = [Dia]();
        for ndia in 1 ... 31{
            fechaComp.year = año.year;
            fechaComp.month = nmes.NumeroMes!;
            fechaComp.day = ndia;
            var smes = "";
            var sdia = "";
            if(nmes.NumeroMes! < 10){
                smes = "0"+String(nmes.NumeroMes!);
            }else{
                smes = String(nmes.NumeroMes!);
                
            }
            //print("mes: ", smes);
            if(ndia < 10){
                sdia = "0"+String(ndia);
            }else{
                sdia = String(ndia);
            }
            
            let fef = formateador.date(from: String(describing: año.year)+smes+sdia)
            
            
            if(fechaComp.isValidDate(in: calendar)){
                //print("FECHA: ", año.year, "/", nmes.NumeroMes, "/", ndia);
                let nsemana = (calendar as NSCalendar).components(.weekOfMonth, from: fef!);
                sema = nsemana.weekOfMonth;
                //print("sema: " , sema, "--", ndia, "--", nsemana.weekOfMonth);
                
                //let dia = Dia();
                //dia.numDia = ndia;
                //dia.nSemana = sema;
                //dia.diaSenama = ( calendar.components(.Weekday, fromDate: fef!)).weekday;
                /*if(dia.diaSenama == 7){
                    print("weekend")
                    dia.setFondo2(3);
                }*/
                //dia.mes = nmes;
                //dias.append(dia);
                //print("dia: ",dia.numDia , "ultimo: ",dia.mes.dias.last?.numDia);
                
                if(sema != nil && sema != nsemana.weekOfMonth){
                    //print("Cambia");
                    
                }
                
            }else{
                //print("FECHA no valida: ", año.year, "/", mes.month, "/", ndia);
            }
        }
        nmes.nSemanas=sema;
        nmes.dias=dias;
        //print("Sema fin: ",sema);
        
    }
    
    //Mètodo que ubica los días del mes con el deafase de los dias en semanas extras o mayores a 4
    func ubicaDias(_ mes: Mes, nmes: Int, cambiaAño: Bool)->CGFloat{
        let alto = mes.frame.height / 4;
        let ancho = mes.frame.width / 7;
        //print("cambio año: ", cambiaAño);
        //print("frame mes: ", mes.frame);
        //print("alto mes: ", alto, "ancho: ", ancho);
        var desfaze = CGFloat(0);
        var suma = false;
        //print("de ", mes.nSemanas);
        switch mes.nSemanas! {
        case 4:
            
            break;
        case 5:
            
            desfaze = -(alto);
            suma = false;
            break;
        case 6:
            
            desfaze = -(alto);
            suma = true;
            
            break;
        default:
            break;
        }
        //print("Desface: ", desfaze);
        var auxY = CGFloat(0);
        for dia in mes.dias{
            if(nmes == 0 && desfaze != 0) {
                //desfaze = 0;
            }
            if(cambiaAño){
                //print("Desfaze Cambio de año: ", desfaze);
                desfaze = abs(desfaze);
            }
            let Mo = mes.frame.origin.x;
            let My = mes.frame.origin.y;
            let OX = CGFloat(dia.diaSenama! - 1) * ancho;
            let OY = ((CGFloat(dia.nSemana! - 1) * alto) + desfaze + abs(desfaze))+My;
            if(auxY != OY){
                //print("OX: ", OX);
            }
            auxY = OY;
            let frame = CGRect(x: OX, y: OY, width: ancho, height: alto);
            //print("dd: ", dia.numDia, " --: ",frame);
            dia.frame = frame;
            
            dia.setFondo2(1);
            self.addSubview(dia);
        }
        if(suma){
            return -desfaze;
        }else{
            
            if(nmes == 0){
                //desfaze = alto;
                //
                //print("mes: ",nmes);
                if(cambiaAño){
                    //print("camb: ", alto);
                    desfaze = alto;
                }else{
                    desfaze = 0;
                }
                                //print("primero: ",desfaze);
                return desfaze;
            }else{
                if(cambiaAño){
                    //print("camb: ", alto);
                    desfaze = alto;
                }else{
                    desfaze = 0;
                }
                //print("desface: ", desfaze);
                return desfaze;
            }
        }
        
        
    }
    
    //Método que bloquea todos los días
    func BloqueaDias(_ bloquea: Bool){
        for mes in self.meses{
            for dia in mes.dias{
                //print("blo");
                dia.isUserInteractionEnabled = !bloquea;
                if(bloquea){
                    dia.setFondo2(2);
                }else{
                    dia.setFondo2(1);
                }
                //print("nnn: ", dia.nSemana);
                if(dia.diaSenama == 7){
                    //print("weekend")
                    dia.setFondo2(3);
                }
            }
        }
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
*/
}
