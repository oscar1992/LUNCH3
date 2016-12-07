//
//  Despliega.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 20/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Despliega: UIScrollView , UIScrollViewDelegate{
    
    var alto: CGFloat!;
    var bot = [UIButton]();
    var qq:Int!;
    var padre:DatosPadre!;
    
    init(frame: CGRect, tipo: AnyObject!, fecha: FechaEntrega?) {
        super.init(frame: frame);
        self.delegate=self;
        let alto = self.frame.height;
        self.frame = CGRectMake(0, self.frame.origin.y, self.frame.width, (alto*3.5));
        var p = 0;
        self.backgroundColor=UIColor.blueColor();
        if(object_getClassName(tipo) == object_getClassName(FechaEntrega)){
            //print("es fecha");
            for fecha in DatosB.cont.FechasEntrega{
                let frame = CGRectMake(0, alto*CGFloat(p), self.frame.width, alto-10);
                let vistaAux = BotDespliega(frame: frame, fecha: fecha, hora: nil);
                vistaAux.backgroundColor=UIColor.redColor();
                vistaAux.addTarget(self, action: #selector(Despliega.botEli(_:)), forControlEvents: .TouchDown);
                self.bringSubviewToFront(vistaAux);
                let fechaL = UILabel(frame: CGRectMake(0, 0, self.frame.width, alto));
                fechaL.text=fecha.fecha;
                vistaAux.addSubview(fechaL);
                bot.append(vistaAux);
                self.addSubview(vistaAux);
                p += 1;
            }
        }else if(object_getClassName(tipo) == object_getClassName(HoraEntrega)){
            //print("es hora");
            if(fecha != nil){
                for hora in DatosB.cont.HorasEntrega{
                    if(hora.fechaEntrega.idFecha==fecha?.idFecha){
                        let frame = CGRectMake(0, alto*CGFloat(p), self.frame.width, alto-10);
                        let vistaAux = BotDespliega(frame: frame, fecha: nil, hora: hora);
                        vistaAux.backgroundColor=UIColor.redColor();
                        vistaAux.addTarget(self, action: #selector(Despliega.botEli2), forControlEvents: .TouchDown);
                        self.bringSubviewToFront(vistaAux);
                        let fechaL = UILabel(frame: CGRectMake(0, 0, self.frame.width, alto));
                        fechaL.text=hora.horaInicial+" - "+hora.horaFinal;
                        vistaAux.addSubview(fechaL);
                        bot.append(vistaAux);
                        self.addSubview(vistaAux);
                        p += 1;
                    }
                }
                print("bot: ", bot.count);
                if(bot.count==0){
                    self.frame = CGRectMake(0, self.frame.origin.y, self.frame.width, (0));
                    self.removeFromSuperview();
                }
            }else{
                //print("vacio");
                self.removeFromSuperview();
                self.frame = CGRectMake(0, self.frame.origin.y, self.frame.width, (0));
                p=0;
            }
            
        }
        
        let altoC = alto*CGFloat(p);
        //print("altoc: ", altoC);
        self.contentSize=CGSizeMake(self.frame.width, altoC);
        //print("alto: ", self.contentSize," vers ", self.frame.height);
    }
    
    
    
    func botEli(sender:BotDespliega){
        //print("mata: ", sender.fecha!.fecha);
        //padre.fecha=sender.fecha;
        padre.texto.text=sender.fecha!.fecha;
        padre.texto2.text="--------";
        self.removeFromSuperview();
    }
    
    func botEli2(sender:BotDespliega){
        //padre.fecha=nil;
        
        padre.texto2.text=(sender.hora?.horaInicial)!+" - "+(sender.hora?.horaFinal)!;
        padre.hora=(sender.hora?.horaInicial)!+" - "+(sender.hora?.horaFinal)!;
        self.frame = CGRectMake(0, self.frame.origin.y, self.frame.width, (0));
        self.removeFromSuperview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
