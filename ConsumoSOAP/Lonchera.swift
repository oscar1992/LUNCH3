//
//  Lonchera.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 4/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Lonchera: UIViewController {
    
    var casillas:[Casilla]!;
    var id:UILabel?;
    var deslizador:DeslizadorViewController!;
    var id2:Int?;
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil);
        
        
        //crea_casillas();
        Label();
        self.id?.text=String(id);
        self.view.backgroundColor=UIColor.greenColor();
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func crea_casillas(){
        var p=0;
        for _ in 0..<3{
            let casilla:Casilla;
            let pos = CGFloat((0+CGFloat(10))*CGFloat(p+1));
            if(p==0){
                casilla=Casilla(frame: CGRectMake(0, 10, 0, 0));
            }else{
                casilla=Casilla(frame: CGRectMake(pos, 10, 0, 0));
            }
            
            casilla.tipo=(p+1);
            //casilla.lonchera=self;
            deslizador?.posiciones.append(casilla.frame);
            self.view.addSubview(casilla);
            casillas?.append(casilla);
            DatosC.contenedor.arreglo.append(casilla);
            //DatosC.contenedor.arreglo.append(casilla.frame);
            p+=1;
        }
    }
    
    func Label(){
        id=UILabel(frame: CGRectMake(((self.view.frame.width/2-50)),0,15,100));
        self.view.addSubview(id!);
    }
    
}
