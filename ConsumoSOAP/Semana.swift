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
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor=UIColor.cyanColor();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func casillas(){
        let anchoM=self.frame.width-pestana;
        let anchoC=anchoM/5;
        
        for p in 0..<5{
            let posi = CGRectMake((pestana+(anchoC*CGFloat(p))), 0, anchoC, self.frame.height);
            pos.append(posi);
            //print("Posi: ",posi);
        }
    }
    
    func addDia(dia: Dia){
        //print("dia: ", dia.diaSenama);
        dias.append(dia);
        dia.frame=pos[dia.diaSenama!-2];
        self.addSubview(dia);
        dia.diaTit?.text=String(dia.numDia!);
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
