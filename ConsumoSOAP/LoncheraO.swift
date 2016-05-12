//
//  LoncheraO.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 14/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class LoncheraO: UIViewController {

    var id:Int?;
    var label:UILabel?;
    var botadd:UIButton?;
    var botrem:UIButton?;
    var subVista:SubVista?;
    var padre:VistaLonchera?;
    var contador : Contador?;
    var fecha: NSDate?;
    var fechaVisible: UILabel?;
    var saludable:Bool?;
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil);
        
        subVista = SubVista();
        subVista!.padre=self.view;
        botadd=UIButton();
        botrem=UIButton();
        botadd?.titleLabel?.text="ADD";
        botrem?.titleLabel?.text="REM";
        botadd?.addTarget(self, action: #selector(self.addcasilla(_:)), forControlEvents: .TouchDown);
        botrem?.addTarget(self, action: #selector(self.remcasilla(_:)), forControlEvents: .TouchDown);
        
    }
    
    func ordena(){
        let ancho=self.view.frame.width*0.6;
        
        let alto=(DatosC.contenedor.altoP*0.6)*0.6;
        let alto2=alto*0.8;
        
        let OX=(self.view.frame.width/2)-(ancho/2);
        let OY=(self.view.frame.origin.y)+((alto-alto2)/2);
        //print("OX ->",((self.view.frame.width/2)-(ancho/2)));
        subVista?.frame=CGRectMake(OX, OY, ancho, alto2);
        subVista?.backgroundColor=UIColor.purpleColor();
        DatosC.contenedor.tamaLonchera=CGRectMake(OX, OY, ancho, alto2);
        self.view.addSubview(subVista!);
        let BAOX=(OX+ancho);
        let BAOY=(OY);
        let Bancho=(self.view.frame.width*0.2);
        let Balto=(alto*0.1);
        botadd?.frame=CGRectMake(BAOX, BAOY, Bancho, Balto);
        botadd?.backgroundColor=UIColor.brownColor();
        self.view.addSubview(botadd!);
        let BROY=(alto2+OY)-Balto;
        botrem?.frame=CGRectMake(BAOX, BROY, Bancho, Balto);
        botrem?.backgroundColor=UIColor.blueColor()
        contador=Contador(frame: CGRectMake(subVista!.frame.origin.x, (subVista!.frame.height+subVista!.frame.origin.y), subVista!.frame.width, alto*0.3));
        contador!.id=self.id;
        
        
        self.view.addSubview(contador!);
        //self.view.addSubview(botrem!);
    }
    
    func inicia(id: Int){
        
        ordena();
        self.id=id;
        self.label=UILabel();
        self.label!.text=("Id: "+String(id));
        self.label!.frame=CGRectMake(5, 5, 100, 20);
        self.view.addSubview(self.label!);
        self.subVista?.crea();
        fechaActual(self.id!);
        fechaVisible?.frame=CGRectMake(subVista!.frame.origin.x, 0, (subVista?.frame.width)!, 20);
        self.view.addSubview(fechaVisible!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addcasilla(button: UIButton){
        //limpia();
        if(self.subVista!.campos<6){
            //print("Campos: ",self.subVista!.campos);
            self.subVista!.campos+=1;
            self.subVista!.text();
            self.subVista?.crea();
        }
        //print(self.subVista!.campos);
    }
    
    func remcasilla(button: UIButton){
        //limpia();
        if(self.subVista!.campos>4){
            self.subVista!.campos-=1
            self.subVista!.text();
            self.subVista?.crea();
        }
        //print(self.subVista!.campos);
    }
    
    func limpia (){
        if((self.subVista?.casillas.isEmpty) != nil){
            for cas in (self.subVista?.casillas)!{
                cas.elemeto?.elimina();
            }
        }else{
            
        }
    }
    
    func fechaActual(id: Int){
        let fecha=NSDate();
        let fechac=NSDateComponents();
        let calendar=NSCalendar.currentCalendar();
        let añoS=calendar.components(.Year , fromDate: fecha);
        let mesS=calendar.components(.Month , fromDate: fecha);
        let diaS=calendar.components(.Day , fromDate: fecha);
        let diaSemana=calendar.components(.Weekday, fromDate: fecha);
        let rest = diaSemana.weekday - (id+2);
        
        
        fechac.year=añoS.year;
        fechac.month=mesS.month;
        fechac.day=(diaS.day-rest);
        
        
        
        let fechaf=NSCalendar.currentCalendar().dateFromComponents(fechac);
        self.fecha=fechaf;
        
        //print("num día: ", diaS.year);
        let formateadpr:NSDateFormatter=NSDateFormatter();
        formateadpr.locale = NSLocale.init(localeIdentifier: "es_CO");
        formateadpr.dateFormat = "EEEE d MMMM";
        fechaVisible=UILabel();
        fechaVisible?.text=formateadpr.stringFromDate(fechaf!);
    }
}
