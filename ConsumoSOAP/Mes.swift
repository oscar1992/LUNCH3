//
//  Mes.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 10/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class Mes: UIView{
    
    var año: Int?;
    var numeroMes:Int?;
    var NombreMes:String?;
    var mesTit:UILabel?;
    var semanas = [Semana]();
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor=UIColor.brownColor();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func organizaMes(){
        //print("mid:", self.frame.width);
        print("Max: ",semanaMax());
        let fechaCom=NSDateComponents()
        fechaCom.year=año!;
        fechaCom.month=numeroMes!;
        print("Inicio", NombreMes);
        var semanaCamb=0;
        let borde = CGFloat(30);
        let espaciado = CGFloat(10);
        let altura = (self.frame.height/CGFloat(semanaMax()))-(espaciado*2);
        var p=CGFloat(0);
        var sem = Semana();
        for dia in 1 ..< 32{
            fechaCom.day=dia;
            let fechai=NSCalendar.currentCalendar().dateFromComponents(fechaCom);
            let calendari=NSCalendar.currentCalendar();
            let semanai=calendari.component(.WeekOfMonth, fromDate: fechai!);
            let diasemana=calendari.component(.Weekday, fromDate: fechai!);
            if(fechaCom.isValidDateInCalendar(calendari)){
                
                //print("CAMB: ",semanaCamb, "I:", semanai);
                if(semanaCamb == semanai){
                    //print("cambia");
                    self.addSubview(sem);
                    let dia = Dia();
                    sem.casillas();
                    dia.numDia=fechaCom.day;
                    dia.diaSenama=diasemana;
                    if(diasemana>=2 && diasemana<=6){
                        sem.addDia(dia);
                        //print("semana i: ", semanai, "dia", fechaCom.day, "día: ",diasemana);
                    }


                }else{
                    //print("nuevo");
                    sem = Semana();
                    semanas.append(sem);
                    sem.numSemanaMes=semanai;
                    semanaCamb=semanai;
                    
                    let semanaFrame=CGRectMake(0, (borde+((altura+espaciado)*p)), self.frame.width, altura);
                    sem.frame=semanaFrame;
                    sem.casillas();
                    self.addSubview(sem);
                    let dia = Dia();
                    dia.numDia=fechaCom.day;
                    dia.diaSenama=diasemana;
                    if(diasemana>=2 && diasemana<=6){
                        sem.addDia(dia);
                        //print("semana i: ", semanai, "dia", fechaCom.day, "día: ",diasemana);
                    }
                    
                    p += 1;
                }
                
                
                
            }
            
        }
        print("Fin", NombreMes);
        mesTit = UILabel(frame: CGRectMake((self.frame.width/2-50), 0, 100, 30));
        mesTit?.textAlignment = NSTextAlignment.Center;
        
        self.addSubview(mesTit!);

    }
    
    func semanaMax()->Int{
        let fechaCom=NSDateComponents()
        fechaCom.year=año!;
        fechaCom.month=numeroMes!;
        fechaCom.day=31;
        var valida=true;
        var semanaf=0;
        while(valida){
            let calendari=NSCalendar.currentCalendar();
            let fechai=NSCalendar.currentCalendar().dateFromComponents(fechaCom);
            if(fechaCom.isValidDateInCalendar(calendari)){
                semanaf=calendari.component(.WeekOfMonth, fromDate: fechai!);
                valida=false;
            }else{
                fechaCom.day -= 1;
            }
        }
        return semanaf;
    }
    
    
}