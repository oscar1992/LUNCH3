//
//  Contador.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 4/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Contador: UIView {
    
    
    var cal:UILabel?;
    var pre:UILabel?;
    var id:Int?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        let borde=CGFloat(10);
        cal=UILabel();
        pre=UILabel();
        cal?.frame=CGRectMake(borde, 0, self.frame.width/2, 30);
        pre?.frame=CGRectMake(self.frame.width/2, 0, self.frame.width/2, 30);
        cal?.text="0000";
        pre?.text="0000";
        self.addSubview(cal!);
        self.addSubview(pre!);
        self.backgroundColor=UIColor.redColor();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func actua(){
        let lonc=DatosC.lonchera;
        var sum=0;
        var sum2:Float=0;
        var verdes=0;
        var blancas=0;
        for cas in lonc.subVista!.casillas{
            
            
            if(cas.elemeto != nil){
                if((cas.elemeto?.producto?.salud) == true){
                    //print("saludable");
                    verdes += 1;
                }else{
                    blancas += 1;
                }
                //print("pre: ",cas.elemeto?.producto?.nombre);
                for tinfo in (cas.elemeto?.producto?.listaDatos)!{
                    if(tinfo.id==1){
                        /*
                        print("idT: ",tinfo.id);
                        print("nom: ",tinfo.tipo);
                        print("val: ",tinfo.valor);
                        */
                        sum2 += tinfo.valor;
                    }
                }
            }
            if(cas.elemeto?.producto?.precio != nil){
                sum += cas.elemeto!.producto!.precio!;
            }
        }
        //print("verdes: ", verdes);
        //print("blancas: ", blancas);

        if(blancas==0){
            for cas2 in lonc.subVista!.casillas{
                cas2.backgroundColor=UIColor.greenColor();
            }
            lonc.saludable=true;
        }else{
            for cas2 in lonc.subVista!.casillas{
                cas2.backgroundColor=UIColor.whiteColor();
            }
            lonc.saludable=false;
        }
        pre?.text=String(sum);
        cal?.text=String(sum2);
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
