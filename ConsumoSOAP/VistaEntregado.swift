//
//  VistaEntregado.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaEntregado: UIView {

    var pedido:Pedido;
    
    init(frame: CGRect, pedido: Pedido) {
        self.pedido=pedido;
        super.init(frame: frame);
        fondo();
        ubicaLabels();
        botonEditar();
    }
    
    func fondo(){
        DatosB.cont.poneFondoTot(self, fondoStr: "Base pedido entregado", framePers: nil, identi: nil, scala: false);
    }
    
    func ubicaLabels(){
        let alto = self.frame.height/6;
        let ancho = self.frame.width/2;
        let OX = CGFloat(ancho*0.05);
        for n in 0...5{
            let OY = alto * CGFloat(n);
            let frame1 = CGRect(x: OX, y: OY, width: ancho, height: alto);
            switch n {
            case 0:
                parLabels(frame1, text1: "Pedido#:", text2: String(pedido.id!));
                break;
            case 1:
                parLabels(frame1, text1: "Fecha Pedido:", text2: formateadorFecha(pedido.fechaPedido));
                break;
            case 2:
                parLabels(frame1, text1: "Fecha Entrega:", text2: formateadorFecha(pedido.fechaEntrega));
                break;
            case 3:
                parLabels(frame1, text1: "Hora de Entrega:", text2: String(pedido.horaEntrega));
                break;
            case 4:
                parLabels(frame1, text1: "Valor Total:", text2: String(pedido.valor));
                break;
            case 5:
                parLabels(frame1, text1: "Cantidad:", text2: String(pedido.cantidad));
                break;
            default:
                break;
            }
            
        }
    }
    
    func parLabels(_ frame1 : CGRect, text1: String, text2: String){
        let frame2 = CGRect(x: frame1.width, y: frame1.origin.y, width: frame1.width, height: frame1.height);
        let lab1 = UILabel(frame: frame1);
        let lab2 = UILabel(frame: frame2);
        lab1.text=text1;
        lab2.text=text2;
        lab2.textAlignment=NSTextAlignment.left;
        lab1.font=UIFont(name: "Gotham Bold", size: frame1.height/2);
        lab2.font=UIFont(name: "SansBeam Head", size: frame1.height/2);
        self.addSubview(lab1);
        self.addSubview(lab2);
    }
    
    func botonEditar(){
        let ancho = self.frame.width*0.1;
        let OX = self.frame.width - (ancho+(self.frame.width*0.05));
        let OY = self.frame.height*0.02;
        let frameBot = CGRect(x: OX, y: OY, width: ancho, height: ancho);
        let botEditar = UIButton(frame: frameBot);
        self.addSubview(botEditar);
        DatosB.cont.poneFondoTot(botEditar, fondoStr: "Botón EDITAR Pedido", framePers: nil, identi: nil, scala: true);
        botEditar.addTarget(self, action: #selector(VistaEntregado.pasaTipo), for: .touchDown);
    }
    
    func pasaTipo(){
        let cargaT = CargaTipos();
        cargaT.cargaTipos(self.pedido);
        DatosB.cont.historial.performSegue(withIdentifier: "Tipos", sender: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func formateadorFecha(_ fechai: String)->String{
        let formateador:DateFormatter=DateFormatter();
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="yyyy-MM-dd hh:mm:ss";
        print("fecha i: ", fechai);
        let fechaN = formateador.date(from: fechai);
        print("fecha n: ", fechaN);
        formateador.dateFormat="EEEE dd 'de' MMMM";
        return formateador.string(from: fechaN!);
    }

}
