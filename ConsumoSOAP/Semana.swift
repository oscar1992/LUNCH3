//
//  Semana.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Semana: UIView {
    /*
    var numSemanaMes:Int?;
    let pestana=CGFloat(30);
    var pos = [CGRect]();
    var dias = [Dia]();
    var mes: Mes?;
    var topsemana = 7;
    
    var ultimaPosicion = CGPoint(x: 0, y: 0);
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor=UIColor.cyan;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detecPan(_ recognizer: UIPanGestureRecognizer){
        recognizer.delaysTouchesEnded=false;
        recognizer.cancelsTouchesInView=false;
        
        let translation = recognizer.translation(in: self.superview);
        ultimaPosicion=CGPoint(x: ultimaPosicion.x+translation.x, y: ultimaPosicion.y+translation.y);
    }
    

    func casillas(){
        let anchoM=self.frame.width-pestana;
        let anchoC=anchoM/CGFloat(topsemana);
        
        for p in 0..<topsemana{
            let posi = CGRect(x: (pestana+(anchoC*CGFloat(p))), y: 0, width: anchoC, height: self.frame.height);
            pos.append(posi);
            //print("Posi: ",posi);
        }
    }
    
    func addDia(_ dia: Dia){
        print("dia: ", dia.diaSenama);
        dias.append(dia);
        dia.frame=pos[dia.diaSenama!-1];
        self.addSubview(dia);
        dia.diaTit?.text=String(dia.numDia!);
        dia.mes=mes
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Toca");
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
