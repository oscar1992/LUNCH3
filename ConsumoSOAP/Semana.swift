//
//  Semana.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Semana: UIView {
    
    var numSemanaMes:Int?;
    let pestana=CGFloat(30);
    var pos = [CGRect]();
    var dias = [Dia]();
    var mes: Mes?;
    var topsemana = 7;
    
    var ultimaPosicion = CGPointMake(0, 0);
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor=UIColor.cyanColor();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detecPan(recognizer: UIPanGestureRecognizer){
        recognizer.delaysTouchesEnded=false;
        recognizer.cancelsTouchesInView=false;
        
        let translation = recognizer.translationInView(self.superview);
        ultimaPosicion=CGPointMake(ultimaPosicion.x+translation.x, ultimaPosicion.y+translation.y);
    }
    

    func casillas(){
        let anchoM=self.frame.width-pestana;
        let anchoC=anchoM/CGFloat(topsemana);
        
        for p in 0..<topsemana{
            let posi = CGRectMake((pestana+(anchoC*CGFloat(p))), 0, anchoC, self.frame.height);
            pos.append(posi);
            //print("Posi: ",posi);
        }
    }
    
    func addDia(dia: Dia){
        print("dia: ", dia.diaSenama);
        dias.append(dia);
        dia.frame=pos[dia.diaSenama!-1];
        self.addSubview(dia);
        dia.diaTit?.text=String(dia.numDia!);
        dia.mes=mes
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print("Toca");
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
