//
//  VistaNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit
class VistaNino: UIView {
    
    var titulo:UILabel!;
    var EspacioLoncheras:Predeterminadas!;
    var Lonchera:Contenedor!;
    var mesActual:Mes?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.accessibilityIdentifier="VN";
        titulo=UILabel(frame: CGRectMake(10, 10, 100, 20));
        self.addSubview(titulo);
        titulo.text="Vista";
        titulo.textColor=UIColor.blackColor();
        EspacioLoncheras = Predeterminadas(frame: CGRectMake(0, 0, DatosC.contenedor.anchoP, (DatosC.contenedor.altoP*0.2)));
        EspacioLoncheras.backgroundColor=UIColor.init(colorLiteralRed: 0.83, green: 0.94, blue: 0.82, alpha: 1);
        self.addSubview(EspacioLoncheras);
        Lonchera=Contenedor(frame: CGRectMake(0, (EspacioLoncheras.frame.origin.y+EspacioLoncheras.frame.height), DatosC.contenedor.anchoP, (DatosC.contenedor.altoP*0.5)));
        Lonchera.backgroundColor=UIColor.greenColor();
        self.addSubview(Lonchera);
        let bot=UIButton(frame: CGRectMake(0, (Lonchera.frame.height+Lonchera.frame.origin.y), 100, 30));
        bot.backgroundColor=UIColor.blueColor();
        bot.addTarget(self, action: #selector(VistaNino.lee(_:)), forControlEvents: .TouchDown)
        self.addSubview(bot);
        let calendario = UIButton(frame: CGRectMake(0, (Lonchera.frame.height+Lonchera.frame.origin.y), (DatosC.contenedor.anchoP*0.4), (DatosC.contenedor.altoP*0.1)));
        calendario.addTarget(self, action: #selector(VistaNino.pasaCalendario(_:)), forControlEvents: .TouchDown);
        calendario.setTitle("Calendario", forState: .Normal);
        calendario.backgroundColor=UIColor.cyanColor();
        self.addSubview(calendario);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lee(sender: UIButton){
        print("QUIEN: ",DatosC.contenedor.iActual);
        for cas in (DatosC.contenedor.loncheras[DatosC.contenedor.iActual].subVista?.casillas)!{
            print("cas: ",cas.elemeto?.producto?.nombre);
        }
    }
    
    func pasaCalendario(sender: AnyObject){
        DatosC.contenedor.PantallaP.performSegueWithIdentifier("Calendario", sender: nil);
    }
    
}
