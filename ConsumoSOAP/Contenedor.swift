//
//  Contenedor.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 14/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Contenedor: UIView {
    
    var deslizador:VistaLonchera!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        deslizador=VistaLonchera(transitionStyle: UIPageViewControllerTransitionStyle.scroll,
                                 navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal,
                                 options: nil);
        deslizador.view.frame=CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        self.addSubview((deslizador?.view)!);
        //print("Cont: ",self.frame.height);
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
