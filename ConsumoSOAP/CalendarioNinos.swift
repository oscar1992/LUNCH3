//
//  CalendarioNinos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 14/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CalendarioNinos: UIView {
    /*
    
    var ninos = [NinoCalendarioBot]();
    
    func inicia(){
        //self.backgroundColor = UIColor.magentaColor();
        let ninos2 = DatosC.contenedor.ninos;
        let ancho = CGFloat(DatosC.contenedor.anchoP*0.2);
        let OX = CGFloat(CGFloat(DatosC.contenedor.anchoP/2)-(ancho * CGFloat(ninos2.count)/2));
        var p = CGFloat(0);
        for nino in ninos2{
            let OXV = OX + (ancho*p);
            let framebot = CGRect(x: OXV, y: 0, width: ancho, height: self.frame.height);
            var botNino : NinoCalendarioBot?;
            print("nino: ", nino.nombreNino);
            //print("pre frame", nino.año);
            if(nino.año != nil){
                botNino = NinoCalendarioBot(frame: framebot, idNIno: nino.nino, primera: false);
                botNino!.Ano=nino.año;
                botNino?.Ano?.cargaSemanaActual();
                botNino?.Ano?.cargaDiasPosteriores();
                botNino?.Ano?.diaEntrega();
                
                DatosD.contenedor.calendario.view.addSubview((botNino?.Ano)!);
            }else{
                botNino = NinoCalendarioBot(frame: framebot, idNIno: nino.nino, primera: true);
            }
            
            let texto = UILabel(frame : CGRect(x: 0, y: 0, width: botNino!.frame.width, height: botNino!.frame.height));
            botNino!.frame=framebot;
            botNino!.ninoInt=nino;
            botNino!.id = Int(nino.nino.id!);
            //print("Envia ID: ", nino.nino.id!);
            botNino!.setID(Int(nino.nino.id!));
            texto.textAlignment = NSTextAlignment.center;
            texto.font = UIFont(name: "SansBeamHead-Medium", size: botNino!.frame.height*0.5);
            texto.textColor = UIColor.white;
            texto.text = nino.nombreNino;
            botNino!.addSubview(texto);
            //botNino.backgroundColor = UIColor.lightGrayColor();
            botNino!.Fondo(false, quien: botNino!);
            self.addSubview(botNino!);
            if(nino.activo == true){
                //botNino.activa(self);
                botNino!.activo=true;
                botNino!.Fondo(true, quien: botNino!);
                //botNino.backgroundColor = UIColor.cyanColor();
            }
            
            botNino?.Ano?.CalposMeses();
            botNino?.Ano?.calcuaMes(0);
            ninos.append(botNino!);
            
            p += 1;
        }
        for nino in ninos{
            if(nino.activo == true){
                nino.activa(self);
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
