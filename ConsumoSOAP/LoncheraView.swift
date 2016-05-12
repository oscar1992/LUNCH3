//
//  LoncheraView.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class LoncheraView: UIView {
    
    var imagen: UIImageView?;
    var lonchera: LoncheraO?;
    var ultimaPosicion:CGPoint=CGPointMake(0,0);
    
    override required init(frame: CGRect) {
        super.init(frame: frame);
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(LoncheraView.detectPan(_:)));
        self.gestureRecognizers=[panRecognizer];
        ultimaPosicion=self.center;
    }
    
    func detectPan(recognizer: UIPanGestureRecognizer){
        recognizer.delaysTouchesEnded=false;
        recognizer.cancelsTouchesInView=false;
        
        var translation=recognizer.translationInView(self.superview);
        self.center = CGPointMake(ultimaPosicion.x+translation.x, ultimaPosicion.y+translation.y)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
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
