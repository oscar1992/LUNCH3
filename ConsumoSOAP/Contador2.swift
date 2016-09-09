//
//  Contador2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 5/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Contador2: UIView {
    
    var valor : UILabel!;
    var calorias : UILabel!;
    var azucar : UILabel!;
    var proteina: UILabel!;
    var saludable = true;
    
    override init(frame: CGRect){
        super.init(frame:frame);
        iniciaLabels();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que inicia los labels
    func iniciaLabels(){
        
        var frames = [CGRect]();
        let ancho = self.frame.width/4;
        let alto = self.frame.height/2;
        for i in 0...3{
            for j in  0...1{
                let OX = (ancho*CGFloat(i));
                let OY = (alto*CGFloat(j));
                let framelab = CGRectMake(OX, OY, ancho, alto);
                frames.append(framelab);
            }
        }
        var p = 0;
        for frame in frames{
            //print("frame: ", frame, "p ", p);
            
                switch p {
                case 0:
                    let label = UILabel(frame: frame);
                    label.text="Valor";
                    seteaLabel(label);
                    break;
                case 4:
                    let label = UILabel(frame: frame);
                    label.text="Calorias";
                    seteaLabel(label);
                    break;
                case 1:
                    let label = UILabel(frame: frame);
                    label.text="Azúcar";
                    seteaLabel(label);
                    break;
                case 5:
                    let label = UILabel(frame: frame);
                    label.text="Proteina";
                    seteaLabel(label);
                    break;
                
                case 2:
                    valor = UILabel(frame: frame);
                    valor.text="-----";
                    seteaLabel(valor);
                    break;
                case 6:
                    calorias = UILabel(frame: frame);
                    calorias.text="-----";
                    seteaLabel(calorias);
                    break;
                case 3:
                    azucar = UILabel(frame: frame);
                    azucar.text="-----";
                    seteaLabel(azucar);
                    break;
                case 7:
                    proteina = UILabel(frame: frame);
                    proteina.text="-----";
                    seteaLabel(proteina);
                    break;
                default:
                    break;
                }
            
            p += 1 ;
        }
    }
    
    func seteaLabel(lab: UILabel){
        lab.textColor=UIColor.whiteColor();
        lab.textAlignment=NSTextAlignment.Center;
        self.addSubview(lab);
    }
    
    //Método que evalua si la lonchera solo contiene productos saludables
    func esSaludable(){
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
