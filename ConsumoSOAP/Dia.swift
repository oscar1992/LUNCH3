//
//  Dia.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Dia: UIView {
    
    var numDia:Int?;
    var diaSenama:Int?;
    var diaTit:UILabel?;
    var lonchera : LoncheraO?;
    
    
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        diaTit=UILabel(frame: CGRectMake(0,0,30,30));
        //diaTit?.font = UIFont(name: "HelveticaNeue-UltraLight", size: 10);
        self.addSubview(diaTit!);
        self.backgroundColor=UIColor.lightGrayColor();
        
        
    }
    
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLonchera(lonch: LoncheraO){
        lonchera=lonch;
        let lonchView=LoncheraView(frame: CGRectMake(10, 10, self.frame.width*0.5, self.frame.height*0.5));
        lonchView.lonchera=lonch;
        if(lonch.saludable == true){
            lonchView.backgroundColor=UIColor.greenColor();
        }else{
            lonchView.backgroundColor=UIColor.whiteColor();
        }
        
        self.addSubview(lonchView);
        self.bringSubviewToFront(diaTit!);
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
