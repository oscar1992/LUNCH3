//
//  VistaTut.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 8/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class VistaTut: UIViewController {
    
    //var nomb: String;
    var orden:Int!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicia();
    }
    
    func inicia() {
        self.view.backgroundColor=UIColor.gray;
       // DatosB.cont.poneFondoTot(self.view, fondoStr: nomb, framePers: nil, identi: nil, scala: false);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
