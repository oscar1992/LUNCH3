//
//  BotonNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class BotonNino: UIButton {
    
    var panelNino:VistaNino!;
    var activo:Bool!;
    var imagen:UIImage!;
    var nombreNino:String!;
    var fecha:NSDate!;
    var genero:Bool!;
    var nino: Ninos!;
    var loncheras = [LoncheraO]();
    var año: AnoScroll?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        activo=false;
        self.addTarget(self, action: #selector(BotonNino.accionM(_:)), forControlEvents: .TouchDown)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func accionM(button:UIButton){
        cambia();
    }
    
    func cambia(){
        let vistaS=DatosC.contenedor.ninos;
        //print("Tama en Cambia: ", DatosC.contenedor.ninos.count);
        
        for btn in vistaS{
            let bb=btn;
            print("q: ", btn.nombreNino);
            
            
            if(bb.activo==true){
                //print("pasa",bb.nombreNino);
                //print("NOMB: ", nombreNino);
                bb.activo=false;
                bb.panelNino.hidden=true;
                //bb.backgroundColor=UIColor.lightGrayColor();
                bb.cambiaFondo(false);
            }else{
                //print("NOMB: ", btn.nombreNino);
            }
            
        }
        
        self.activo=true;
        //self.panelNino.hidden=false;
        DatosC.contenedor.loncheras = panelNino.Lonchera.deslizador.paginas;
        DatosC.contenedor.iActual = 0;
        if(panelNino.mesActual != nil){
            //DatosC.mesActual = panelNino!.mesActual!;
        }else{
            //DatosC.mesActual=Mes();
        }
        DatosC.contenedor.ninoActual = panelNino;
        self.cambiaFondo(true);
        panelNino.hidden=false;
        //print("FIN-------------------");
        
/*
        if(activo==true){
            //print("desactiva");
            activo=false;
        cambiaFondo(false);
            panelNino.hidden=true;
        }else{
            activo=true;
            //self.backgroundColor=UIColor.blueColor();
            //Cambio de datos niño en el Singleton
            DatosC.contenedor.loncheras = panelNino.Lonchera.deslizador.paginas;
            DatosC.contenedor.iActual = panelNino.Lonchera.deslizador.quien;
            if(panelNino.mesActual != nil){
                //DatosC.mesActual = panelNino!.mesActual!;
            }else{
                //DatosC.mesActual=Mes();
            }
            DatosC.contenedor.ninoActual = panelNino;
            cambiaFondo(true);
            panelNino.hidden=false;
        }
        */
        
        
    }
    
    //Método que Cambia el fondo de la pestaña del niño
    func cambiaFondo(activ: Bool){
        for vista in self.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        
        var imagen: UIImage;
        if(activ){
            imagen = UIImage(named: "Pestana1")!;
            //print("Activo");
        }else{
            imagen = UIImage(named: "Pestana2")!;
            //print("No Activo");
        }
        let frame = CGRectMake(0, 0, self.frame.width, self.frame.height);
        let backImg = UIImageView(frame: frame);
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
        self.addSubview(backImg);
        self.sendSubviewToBack(backImg);

    }
    
    
    
}
