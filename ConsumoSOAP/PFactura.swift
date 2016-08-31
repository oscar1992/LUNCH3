//
//  PFacturaViewController.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 18/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class PFactura: UIViewController {
    
    var fscroll : FacturaScroll!;
    var ninos = [BotonNino]();
    var navegacion: UIView?;
    var regresa: UIButton?;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.blueColor();
        let scrollFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*0.85);
        fscroll = FacturaScroll(frame: scrollFrame);
        leeNinos();
        
        self.view.addSubview(fscroll);
        navegacion = UIView(frame: CGRectMake(0, (self.view.frame.height*0.85), self.view.frame.width, (self.view.frame.height*0.15)));
        navegacion!.backgroundColor=UIColor.brownColor();
        regresa = UIButton(frame: CGRectMake(0, 0, navegacion!.frame.width/2, navegacion!.frame.height));
        regresa?.backgroundColor=UIColor.redColor();
        regresa?.addTarget(self, action: #selector(PFactura.regresa(_:)), forControlEvents: .TouchDown);
        navegacion?.addSubview(regresa!);
        self.view.addSubview(navegacion!);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leeNinos(){
        for nino in DatosC.contenedor.ninos{
            print("NN: ",nino.nombreNino);
            ninos.append(nino);
            /*
            for semana in nino.panelNino.mesActual!.semanas{
                for dia in semana.dias{
                    print("DD: ",dia.lonchera);
                    if(dia.lonchera != nil){
                        for ele in (dia.lonchera?.subVista?.casillas)!{
                            print("ELE: ", ele.elemeto?.producto?.nombre);
                        }
                    }
                }
            }
            */
        }
        fscroll.pintaNinos(ninos);
    }
    
    func regresa(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil);
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
