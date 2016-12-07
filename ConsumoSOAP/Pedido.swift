//
//  File.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 25/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Pedido: NSObject {
    var id: Int?;
    var idPadre:Int;
    var fechaPedido:String;
    var fechaEntrega:String;
    var horaEntrega:String;
    var valor:Double;
    var cantidad:Int;
    var metodo: String;
    var entregado: Bool;
    var cancelado:Bool;
    
    init(id: Int?, idPadre: Int, fechaPedido: String, fechaEntrega: String, horaEntrega: String, valor: Double, cantidad: Int, metodo: String, entregado: Bool, cancelado:Bool) {
        self.id=id;
        self.idPadre=idPadre;
        self.fechaPedido=fechaPedido;
        self.fechaEntrega=fechaEntrega;
        self.horaEntrega=horaEntrega;
        self.valor=valor;
        self.cantidad=cantidad;
        self.metodo=metodo;
        self.entregado=entregado;
        self.cancelado=cancelado;
    }
}
