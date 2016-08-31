//
//  LoginView.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 25/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    
    @IBOutlet weak var ingresa: UIButton!
    
    var aprueba:Bool=false;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ingresa(sender: UIButton) {
        ingresa.enabled=false;
        if(email.text != nil && pass.text != nil){
            let login = ConsultaLogin();
            login.PLogin=self;
            
            login.consulta(email.text!, pass: pass.text!);
           // print("t1");
            
        }
    }
    
    func pasa(){
        if(aprueba == true){
            //print("Proceda Señor");
            self.performSegueWithIdentifier("Ingresa", sender: nil);
            
        }else{
            self.performSegueWithIdentifier("Ingresa2", sender: nil);
            //print("No Proceda Señor");
        }
        
        
        
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
