//
//  CalendarioViewController.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 10/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CalendarioViewController: UIViewController {
    
    
    var espacioSemanas : EspacioSemanas?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let espacioSup = CGFloat(20);
        let bordes = CGFloat(20);
        let alto = self.view.frame.height*0.8;
        
        let RectSemanas = CGRectMake(espacioSup, bordes, (self.view.frame.width-(bordes*2)), alto);
        espacioSemanas=EspacioSemanas(frame: RectSemanas);
        espacioSemanas!.backgroundColor=UIColor.redColor();
        self.view.addSubview(espacioSemanas!);
        */
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
