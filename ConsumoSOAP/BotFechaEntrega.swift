//
//  BotFechaEntrega.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 25/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BotFechaEntrega: UIButton {


    var texto: String;
    var text2: String;
    var id: Int;
    var fecha: FechasEntrega!;
    
    init(frame: CGRect, texto: String, texto2: String, id: Int, fecha: FechasEntrega) {
        self.text2=texto2;
        self.texto=texto;
        self.id=id;
        self.fecha=fecha;
        super.init(frame: frame);
        let frameLab = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
        let label = UILabel(frame:frameLab);
        label.text=texto+"         $"+String(fecha.valor);
        label.textAlignment=NSTextAlignment.center;
        label.font=UIFont(name: "SansBeam Head", size: label.frame.height/3);
        self.addTarget(self, action: #selector(BotFechaEntrega.poneMetodoTimer(_:)), for: .touchDown);
        label.isUserInteractionEnabled=false;
        label.adjustsFontSizeToFitWidth=true;
        self.backgroundColor=UIColor.white;
        self.addSubview(label);
    }
    
    func poneMetodoTimer(_ seneder: UIButton){
        self.backgroundColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
         _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BotFechaEntrega.poneMetodo), userInfo: nil, repeats: false);
    }
    
    func poneMetodo(){
        DatosB.cont.datosPadre.texto.text=self.texto;
        DatosB.cont.datosPadre.fecha=self.text2;
        DatosB.cont.datosPadre.idFecha=self.id;
        DatosB.cont.datosPadre.fechaSeleccionada=self.fecha;
        DatosB.cont.datosPadre.envio?.text="Domicilio:      "+String(fecha.valor);
        var precio = 0;
        for lonch in DatosB.cont.listaLoncheras{
            precio += lonch.0.valor;
        }
        DatosB.cont.datosPadre.total.text="Valor Pedido:     "+String((precio+fecha.valor));
        //DatosB.cont.datosPadre.listaDesplegable2();
        self.superview?.removeFromSuperview();
        DatosB.cont.datosPadre.desbloqueador();
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
