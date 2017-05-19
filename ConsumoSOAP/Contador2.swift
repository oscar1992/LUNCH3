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
        puntos();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
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
    }*/
    
    //Método que inicia los labels
    func iniciaLabels(){
        let ancho = self.frame.width*0.4;
        let alto = self.frame.height*0.3;
        let frameLV = CGRect(x: 0, y: 15, width: ancho, height: alto);
        let frameValo = CGRect(x: 0, y: (alto), width: ancho, height: alto*1.3);
        let OX = self.frame.width*0.5;
        let ancho2 = self.frame.width*0.3;
        let alto2 = self.frame.height/3;
        //print("OX: ", OX);
        let frameLA = CGRect(x: OX, y: 10, width: ancho2, height: alto2);
        let frameLC = CGRect(x: OX, y: frameLA.height, width: ancho2, height: alto2);
        let frameLP = CGRect(x: OX, y: (frameLC.height+frameLC.origin.y-10), width: ancho2, height: alto2);
        let OX2 = OX+(ancho2/2);
        let frameAzu=CGRect(x: OX2, y: frameLA.origin.y, width: ancho2, height: alto2);
        let frameCal=CGRect(x: OX2, y: frameLC.origin.y, width: ancho2, height: alto2);
        let framePro=CGRect(x: OX2, y: frameLP.origin.y, width: ancho2, height: alto2);
        
        let labelV = UILabel();
        let labelA = UILabel();
        let labelC = UILabel();
        let labelP = UILabel();
        labelV.frame=frameLV;
        labelA.frame=frameLA;
        
        labelC.frame=frameLC;
        labelP.frame=frameLP;
        labelA.text="Azúcar:";
        labelV.text="Valor:";
        labelP.text="Proteína:";
        labelC.text="Calorías:";

        valor = UILabel();
        azucar = UILabel();
        calorias = UILabel();
        proteina = UILabel();
        valor.frame = frameValo;
        azucar.frame = frameAzu;
        calorias.frame = frameCal;
        proteina.frame = framePro;
        valor.text="----";
        azucar.text="----";
        calorias.text="----";
        proteina.text="----";
        seteaLabel3(valor);
        seteaLabel2(azucar);
        seteaLabel2(calorias);
        seteaLabel2(proteina);
        //seteaLabel3(labelV);
        seteaLabel1(labelA);
        seteaLabel1(labelC);
        seteaLabel1(labelP);
        valor.textAlignment=NSTextAlignment.center;
        labelV.textAlignment=NSTextAlignment.center;
    }
    
    func seteaLabel1(_ lab: UILabel){
        lab.textColor=UIColor.white;
        lab.font=UIFont(name: "SansBeamBody-Heavy", size: lab.frame.height/2);
        lab.textAlignment=NSTextAlignment.left;
        self.addSubview(lab);
    }
    
    
    func seteaLabel2(_ lab: UILabel){
        lab.textColor=UIColor.white;
        lab.textAlignment=NSTextAlignment.right;
        lab.font=UIFont(name: "Gotham Book", size: lab.frame.height/2);
        self.addSubview(lab);
    }
    
    func seteaLabel3(_ lab: UILabel){
        lab.textColor=UIColor.white;
        lab.font=UIFont(name: "SansBeamBody-Heavy", size: lab.frame.height*0.7);
        lab.textAlignment=NSTextAlignment.left;
        self.addSubview(lab);
    }
    
    //Método que pone el divisor
    func puntos(){
        let ancho = CGFloat(5);
        let alto = self.frame.height*0.5;
        let OX = self.frame.width*0.4;
        let OY = (self.frame.height/2)-(alto/2);
        let frameD=CGRect(x: OX, y: OY, width: ancho, height: alto);
        let divisor = UIView(frame: frameD);
        self.addSubview(divisor);
        DatosB.cont.poneFondoTot(divisor, fondoStr: "Dots", framePers: nil, identi: nil, scala: true);
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
