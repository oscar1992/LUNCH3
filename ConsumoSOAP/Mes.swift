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
    
    var NumeroMes: Int!;
    var dias = [Dia]();
    var nSemanas: Int?;
    var ano: Int!;
    var nombreMes: String!;
    
    required init(frame: CGRect, nmes: Int, nAño: Int) {
        super.init(frame: frame);
        self.NumeroMes = nmes;
        self.ano = nAño;
        PoneNombreMes();
        iniciaDias();
        //print("nmes: ", nmes);
        //self.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.0);
        self.backgroundColor=UIColor.darkGrayColor();
        //self.userInteractionEnabled=false;
        self.sendSubviewToBack(self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func BloqueaDias(bloquea: Bool){
        //print("BLoquea");
        //self.ano.BloqueaDias(bloquea);
    }
    
    func iniciaDias(){
        let calendar = NSCalendar.currentCalendar();
        let fecha = NSDateComponents();
        var aux : NSDateComponents!;
        fecha.year=ano;
        fecha.month=NumeroMes;
        var pases = 0;
        for nDia in 1 ... 31{
            aux = fecha;
            fecha.day = nDia;
            if(fecha.isValidDateInCalendar(calendar)){
                let dia = Dia(frame: CGRectMake(0, 0, 10, 10), nDia: fecha.day, mes: self);
                dia.activo=true;
                //rprint("dia: ", dia.numDia);
                dias.append(dia);
                
            }else{
                pases += 1;
                //print("erronea")
                aux.day = aux.day - pases;
            }
        }
        //print("aux: ", aux);
        let fecha2 = calendar.dateFromComponents(aux);
        //print("fevha final: ", fecha2);
        nSemanas = calendar.component(.WeekOfMonth, fromDate: fecha2!);
        
    }
    
    
    
    func PoneNombreMes(){
        switch NumeroMes {
        case 1:
            nombreMes = "Enero";
            break;
        case 2:
            nombreMes = "Febrero";
            break;
        case 3:
            nombreMes = "Marzo";
            break;
        case 4:
            nombreMes = "Abril";
            break;
        case 5:
            nombreMes = "Mayo";
            break;
        case 6:
            nombreMes = "Junio";
            break;
        case 7:
            nombreMes = "Julio";
            break;
        case 8:
            nombreMes = "Agosto";
            break;
        case 9:
            nombreMes = "Septiembre";
            break;
        case 10:
            nombreMes = "Octubre";
            break;
        case 11:
            nombreMes = "Noviembre";
            break;
        case 12:
            nombreMes = "Diciembre";
            break;
        default:
            break;
        }
    }
}