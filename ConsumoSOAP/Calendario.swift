//
//  Calendario.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 10/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Calendario: UIViewController {

    var mesScroll:MesScroll!;
    var subPanel:UIView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.greenColor();
        let frameScroll=CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*0.9);
        let frameSubPanel=CGRectMake(0, self.view.frame.height*0.9, self.view.frame.width, self.view.frame.height*0.1);
        subPanel=UIView(frame: frameSubPanel);
        subPanel?.backgroundColor=UIColor.blackColor();
        
        let devbot=UIButton(frame: CGRectMake(0,0, frameSubPanel.width/2, frameSubPanel.height));
        let prueba=UIButton(frame: CGRectMake(frameSubPanel.width/2,0, frameSubPanel.width/2, frameSubPanel.height));
        devbot.addTarget(self, action: #selector(Calendario.devuelve(_:)), forControlEvents: .TouchDown);
        prueba.addTarget(self, action: #selector(Calendario.leeMes(_:)), forControlEvents: .TouchDown);
        devbot.titleLabel?.text="HOME";
        devbot.backgroundColor=UIColor.orangeColor();
        prueba.backgroundColor=UIColor.brownColor();
        subPanel?.addSubview(devbot);
        subPanel?.addSubview(prueba);
        mesScroll = MesScroll(frame: frameScroll);
        mesScroll.backgroundColor=UIColor.blueColor();
        self.view.addSubview(mesScroll);
        self.view.addSubview(subPanel!);
        let fecha=NSDate();
        let calendar=NSCalendar.currentCalendar();
        //Los años deben empesar en la primera compra del cliente en el historial
        let añoActual=calendar.component(.Year, fromDate: fecha);
        let mesActual=calendar.component(.Month, fromDate: fecha);
        let año = An_o();
        let añoFrame = CGRectMake(0, self.view.frame.height*0.1, self.view.frame.width, (self.view.frame.height*0.8)*6);
        año.frame=añoFrame;
        
        let formateador:NSDateFormatter=NSDateFormatter();
        formateador.locale = NSLocale.init(localeIdentifier: "es_CO");
        formateador.dateFormat="yyyy";
        //print("año: ",formateador.stringFromDate(fecha));
        //año.añoTit!.text=formateador.stringFromDate(fecha);
        año.añoString=formateador.stringFromDate(fecha);
        año.setAño();
        var p = CGFloat(0);
        for nmes in mesActual..<(mesActual+6){
            
            let mes = Mes();
            let fecha2=NSDateComponents();
            fecha2.year=añoActual
            fecha2.month=nmes;
            let fecha3=NSCalendar.currentCalendar().dateFromComponents(fecha2);
            formateador.dateFormat = "MMMM";
            let borde = CGFloat(35);
            let espaciado = CGFloat(10);
            let alto = CGFloat(((año.frame.height)/6)-(espaciado*2));
            //print("alto", borde+(alto*p)+espaciado*2);
            let mesFrame = CGRectMake(borde, (borde+((alto+espaciado)*p)), año.frame.width-(borde*2), alto);
            mes.año=añoActual;
            mes.numeroMes=nmes;
            mes.NombreMes=formateador.stringFromDate(fecha3!);
            mes.frame=mesFrame;
            mes.organizaMes();
            
            if(p==0){
                DatosC.contenedor.ninoActual!.mesActual=mes;
                DatosC.contenedor.mesActual=mes;
                semanaActual(mes);
            }
            
            mes.mesTit!.text=formateador.stringFromDate(fecha3!);
            año.meses.append(mes);
            año.addSubview(mes);
            
            
            p += 1;
            //print("mes: ", mes.NombreMes);
        }
        mesScroll.años.append(año);
        mesScroll.ordenaAño();
        //self.view.addSubview(año);
        DatosC.calendario=self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func semanaActual(mes: Mes){
        let fecha=NSDate();
        let calendar=NSCalendar.currentCalendar();
        let semanaA=calendar.component(.WeekOfMonth, fromDate: fecha);
        //print("semanaA: ",mes.semanas.count);
        let semanaActual=mes.semanas[semanaA-1];
        var p=0;
        
        for lonch in DatosC.contenedor.loncheras{
            var min=0;
            for cas in (lonch.subVista?.casillas)!{
                //print("ele: ", cas.elemeto?.producto?.nombre);
                if(cas.elemeto != nil){
                    min += 1;
                }else{
                    //print("NULOOO");
                }
            }
            print("min: ",min)
            if(min>=1){
                semanaActual.dias[p].addLonchera(lonch);
            }
            p += 1;
        }
    }
    
    func devuelve(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil);
        //self.performSegueWithIdentifier("DevHome", sender: nil);
    }
    
    func leeMes(sender: AnyObject){
        /*for semana in (DatosC.contenedor.ninoActual.mesActual?.semanas)!{
            for dia in semana.dias{
                print("dd: ",dia.lonchera);
            }
        }*/
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
