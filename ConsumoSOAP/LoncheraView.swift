//
//  LoncheraView.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class LoncheraView: UIButton {
    
    var imagen: UIImageView?;
    var lonchera: LoncheraO?;
    var ultimaPosicion:CGPoint=CGPointMake(0,0);
    var padre: Dia?;
    var areaDesplazamiento : UIView?;
    var diasFinales = [CGRect]();
    var diasDatos = [Dia]();
    var conver:CGRect?;
    var frameI: CGRect?;
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LoncheraView.detectPan(_:)));
        self.gestureRecognizers=[panRecognizer];
        self.addTarget(self, action: #selector(LoncheraView.desactivaScroll(_:)), forControlEvents: .TouchDown);
        //padre=self.superview;
        
        areaDesplazamiento=self.superview;
        ultimaPosicion=self.center;
        frameI=self.frame;
    }
    
    func detectPan(recognizer: UIPanGestureRecognizer){
        recognizer.delaysTouchesEnded=false;
        recognizer.cancelsTouchesInView=false;
        
        
        let translation=recognizer.translationInView(DatosC.calendario.view);
        //print("detecta?", translation);
        self.center = CGPointMake(ultimaPosicion.x+translation.x, ultimaPosicion.y+translation.y)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /*
        print("posi:", self.frame);
        print("pant: ",DatosC.calendario.view.frame );
        print("centro I: ",self.center);
        let conPoint = convertPoint(self.center, toView: DatosC.calendario.view);
        print("centro I conv: ",conPoint);
        
        
        print("padre padre posi", self.superview?.superview?.frame);
        print("padre padre padre posi", self.superview?.superview?.superview?.frame);
        print("padre padre padre padre posi", self.superview?.superview?.superview?.superview?.frame);
         print("padre posi", self.superview?.frame);
         print("padre posi", self.superview);
        */
       // print("qq: ",self.areaDesplazamiento);
        //padre=self.superview as! Dia;
        posFinales();
        conver = convertRect(self.frame, toView: DatosC.calendario.view);
        //print("conv: ",con);
        self.center = CGPointMake(self.center.x+conver!.origin.x-(self.frame.width/2), self.center.y+conver!.origin.y-(self.frame.height/2));
        DatosC.calendario.view.addSubview(self);
        areaDesplazamiento=DatosC.calendario.view;
        ultimaPosicion=CGPointMake(conver!.origin.x, conver!.origin.y);
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //print("mm: ",self.center);
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        posFinales();
        //let con = convertRect(self.frame, toView: padre);
        //self.center = CGPointMake(self.center.x-con.origin.x-(self.frame.width/2), self.center.y-con.origin.y-(self.frame.height/2));
        //padre?.addSubview(self);
        
        DatosC.calendario.mesScroll.userInteractionEnabled = true;
        //print("centro F: ",self.center);
        var para=true;
        var p=0;
        //print("OFF: ",DatosC.calendario.mesScroll.contentOffset.y);
        let off=DatosC.calendario.mesScroll.contentOffset.y;
        self.center=CGPointMake(self.center.x, self.center.y+DatosC.calendario.mesScroll.contentOffset.y);
        //var elimina = false;
        while(para){
            let compara2 = CGPointMake(self.center.x, self.center.y+off);
            if(diasFinales[p].contains(compara2)){
                para=false;
                self.backgroundColor=UIColor.orangeColor();
                //print("dentro!!", diasDatos[p].numDia);
                //DatosC.calendario.mesAux=diasDatos[p].mes;
                diasDatos[p].backgroundColor=UIColor.yellowColor();
                let copia=LoncheraView(frame: CGRectMake(10, 10, self.frameI!.width, self.frameI!.height));
                copia.lonchera=self.lonchera;
                //print("fe copia: ", copia.lonchera!.fecha);
                copia.lonchera!.id = self.lonchera!.id;
                
                //copia.backgroundColor=UIColor.redColor();
                //padre!.addLonchera(copia.lonchera!, id: copia.lonchera!.id!);
                //print("posee: ",diasDatos[p].vista);
                diasDatos[p].vista=self;
                self.lonchera?.cambiaFecha(diasDatos[p].numDia!);
                //print("fe IDD: ", self.lonchera!.id!-2);
                if(diasDatos[p].diaSenama>2){
                    self.lonchera!.id = diasDatos[p].diaSenama!-2;
                }else{
                    self.lonchera!.id = diasDatos[p].diaSenama;
                }
                
                //diasDatos[p].addLonchera(self.lonchera!, id: self.lonchera!.id!);
                self.removeFromSuperview();
                
                //print("padreNN: ",padre?.numDia);
                //copia.lonchera?.cambiaFecha((padre?.numDia)!);
                //print("copia: ",copia.lonchera?.fechaVisible?.text);
                
                //DatosC.calendario.repintaMes(diasDatos[p].mes);
                //actuaMesActual(diasDatos[p], lonch: self.lonchera!);
            }else{
                p += 1;
            }
            if(p>=diasFinales.count){
                print("sale solo?", (padre)!.numDia);
                padre!.addSubview(self);
                print("Padre:", self.padre);
                self.frame=CGRectMake(10, 10, self.frameI!.width, self.frameI!.height);
                para=false;
            }
        }
        ultimaPosicion=CGPointMake(self.center.x-conver!.origin.x, self.center.y-conver!.origin.y);
        //print("sale");
        
    }
    
    func desactivaScroll(sender: AnyObject){
        DatosC.calendario.mesScroll.userInteractionEnabled = false;
        
    }
    
    func posFinales(){
        diasFinales  = [CGRect]();
        //print("pos:", DatosC.contenedor.mesActual.semanas.count);
        /*for semana in DatosC.mesActual.semanas{
            //print("add: ",semana.frame.origin.x);
            //print("add: ",semana.superview?.frame.origin.x);
            //print("add: ",semana.superview?.superview?.frame.origin.x);
            //print("add: ",semana.superview?.superview?.superview?.frame.origin.x);
            //print("add: ",semana.superview?.superview?.superview?.superview?.frame.origin.x);
            //print("add: ",semana.superview?.superview?.superview?.superview?.superview?.frame.origin.x);
            var add = semana.frame.origin.y;
            var add2 = semana.frame.origin.x+CGFloat(DatosC.contenedor.anchoP*0.08);
            add += (semana.superview?.frame.origin.y)!+CGFloat(DatosC.contenedor.altoP*0.15);
            //print("ADD: ", add2);
            let off=DatosC.calendario.mesScroll.contentOffset.y;
            //print("pos: ",DatosC.calendario.mesScroll.contentOffset.y);
            for dia in semana.dias{
                let pi=dia.superview;
                /*
                print("POS dia: ",dia.numDia, " - ", dia.frame);
                
                var con = convertRect(dia.frame, toView: DatosC.calendario.view);
                */
                //var con2 = convertRect(con, toView: semana.superview);
                //dia.frame.origin.y += add;
 
                DatosC.calendario.view.addSubview(dia);
                //let con2 = convertRect(dia.frame, toView: semana.superview);
                var posF = dia.frame;
                posF.origin.y += add;
                posF.origin.y += off;
                
                //var posC = convertRect(posF, toView: DatosC.calendario.view);
                posF.origin.x += add2;
                //print("POS dia: ",dia.numDia, " add: ",posF);
                pi?.addSubview(dia);
                diasFinales.append(posF);
                diasDatos.append(dia);
            }
        }*/
    }
    
    func actuaMesActual(dia: Dia, lonch: LoncheraO){
        /*
        for semana in DatosC.mesActual.semanas{
            for ddia in semana.dias{
                if(ddia.numDia == dia.numDia){
                    //ddia.addLonchera(lonch);
                }
            }
        }
        */
        
    }



    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    

}