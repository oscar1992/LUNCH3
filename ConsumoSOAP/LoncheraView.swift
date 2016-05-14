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
    var padre: UIView?;
    var areaDesplazamiento : UIView?;
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LoncheraView.detectPan(_:)));
        self.gestureRecognizers=[panRecognizer];
        self.addTarget(self, action: #selector(LoncheraView.desactivaScroll(_:)), forControlEvents: .TouchDown);
        padre=self.superview;
        areaDesplazamiento=self.superview;
        ultimaPosicion=self.center;
    }
    
    func detectPan(recognizer: UIPanGestureRecognizer){
        recognizer.delaysTouchesEnded=false;
        recognizer.cancelsTouchesInView=false;
        
        
        let translation=recognizer.translationInView(areaDesplazamiento);
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
        
        print("padre posi", self.superview?.frame);
        print("padre padre posi", self.superview?.superview?.frame);
        print("padre padre padre posi", self.superview?.superview?.superview?.frame);
        print("padre padre padre padre posi", self.superview?.superview?.superview?.superview?.frame);
        */
        posFinales();
        let con = convertRect(self.frame, toView: DatosC.calendario.view);
        //print("conv: ",con);
        self.center = CGPointMake(self.center.x+con.origin.x-(self.frame.width/2), self.center.y+con.origin.y-(self.frame.height/2));
        DatosC.calendario.view.addSubview(self);
        areaDesplazamiento=DatosC.calendario.view;
        ultimaPosicion=CGPointMake(con.origin.x, con.origin.y);
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //print("mm: ",self.center);
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //let con = convertRect(self.frame, toView: padre);
        //self.center = CGPointMake(self.center.x-con.origin.x-(self.frame.width/2), self.center.y-con.origin.y-(self.frame.height/2));
        padre?.addSubview(self);
        DatosC.calendario.mesScroll.userInteractionEnabled = true;
        print("centro F: ",self.center);

        //print("sale");
    }
    
    func desactivaScroll(sender: AnyObject){
        DatosC.calendario.mesScroll.userInteractionEnabled = false;
        
    }
    
    func posFinales(){
        print("pos:");
        for semana in DatosC.contenedor.mesActual.semanas{
            print("add: ",semana.frame.origin.y);
            print("add: ",semana.superview?.frame.origin.y);
            print("add: ",semana.superview?.superview?.frame.origin.y);
            print("add: ",semana.superview?.superview?.superview?.frame.origin.y);
            print("add: ",semana.superview?.superview?.superview?.superview?.frame.origin.y);
            print("add: ",semana.superview?.superview?.superview?.superview?.superview?.frame.origin.y);
            //var add = semana.frame.origin.y;
            var add = (semana.superview?.frame.origin.y)!;
            for dia in semana.dias{
                let pi=dia.superview;
                /*
                print("POS dia: ",dia.numDia, " - ", dia.frame);
                
                var con = convertRect(dia.frame, toView: DatosC.calendario.view);
                
                var con2 = convertRect(con, toView: semana.superview);
                con2.origin.y += add;
                */
                DatosC.calendario.view.addSubview(dia);
                //let con2 = convertRect(dia.frame, toView: semana.superview);
                
                print("POS dia: ",dia.numDia," - ",dia.frame);
                pi?.addSubview(dia);
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

}
