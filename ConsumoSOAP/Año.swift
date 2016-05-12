//
//  Año.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class An_o: UIView {
    
    var meses = [Mes]();
    var añoTit:UILabel?;
    var añoString:String?;
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        
        
        self.backgroundColor=UIColor.whiteColor();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAño(){
        
        añoTit=UILabel(frame: CGRectMake((self.frame.width/2)-25,(10), 100, 30));
        añoTit?.text=añoString;
        self.addSubview(añoTit!);
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
