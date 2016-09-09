//
//  AnoScroll.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 14/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class AnoScroll: UIScrollView, UIScrollViewDelegate {
    
    var padre:Calendario!;
    //var años = [An_o]();
    var Nino : Ninos!;
    var proyeccion = 6;
    var meses = [Mes]();
    var slide = UIView();
    var primera = true;
    private var posMeses = [(CGFloat, CGFloat, Mes)]();
    
    required init(frame: CGRect, nino: Ninos) {
        super.init(frame: frame);
        self.delegate = self;
        //self.backgroundColor = UIColor.orangeColor();
        padre = DatosD.contenedor.calendario;
        self.Nino=nino;
        iniciaTiempo();
        //print("meses: ", primera);
        if (primera){
            iniciaEspacioDias();
            primera = false;
        }
        CalposMeses();
        cargaSemanaActual();
        cargaDiasPosteriores();
        diaActual();
        diaEntrega();
        offsetVisible();
        self.contentOffset.y=posicionaDiaActual();
        //DatosD.contenedor.calendario.iniciaTextoMes();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que calcula los meses siguientes a ser pintados
    func iniciaTiempo(){
        let ff=padre.fechaActual;
        let calendar=NSCalendar.currentCalendar();
        
        var AñoActual = calendar.component(.Year, fromDate: ff!);
        var mesActual=calendar.component(.Month, fromDate: ff!);
        //Armo año nuevo
        
        for _ in mesActual ... (mesActual+proyeccion){
            if(mesActual > 12){
                //Armo año siguiente
                mesActual = 1;
                AñoActual += 1;
            }
            let mes = Mes(frame: self.frame, nmes: mesActual, nAño: AñoActual);
            meses.append(mes);
            
            //print("mes: ", mes.nombreMes, " - ", mesActual);
            mesActual += 1;
        }
    }
    
    func iniciaEspacioDias(){
        let anchoD = self.frame.width/7;
        let altoD = self.frame.height/4;
        
        var fila = 0;
        var X = (meses.first?.dias.first?.diaSenama)!-1;
        for mes in meses{
            for dia in mes.dias{
                
                if(X > 6){
                    X = 0;
                    fila += 1;
                }
                let frameDia = CGRectMake(anchoD*CGFloat(X), altoD*CGFloat(fila), anchoD, altoD);
                dia.frame=frameDia;
                dia.ano=self;
                dia.mes = mes;
                if(dia.diaSenama==7){
                    //dia.setFondo2(3);
                }else{
                    
                }
                dia.setFondo2(1);
                dia.addSubview(dia.diaTit!);
                //print("nn: ", dia.diaSenama);
                slide.bringSubviewToFront(dia);
                slide.addSubview(dia);
                
                X += 1;
            }
        }
        let frameSlide = CGRectMake(0, 0, self.frame.width, (CGFloat(fila+1)*(altoD)));
        //print("frame: ", frameSlide);
        slide.frame=frameSlide;
        //slide.backgroundColor=UIColor.yellowColor();
        self.contentSize = CGSizeMake(slide.frame.width, slide.frame.height);
        self.addSubview(slide);
    }
    

    
    //Método que inicia el año con 6 meses adentro
    func iniciaAñoactual(){
            print("Carga");
            /*for nn in DatosD.contenedor.ninos{
                print("nn: ", nn.id, "NINO: ", Nino.id);
                if (nn.id == Nino.id){
                    self.años = nn.añoActual!.años;
                }
            }
        */
        //cargaSemanaActual();
        //self.addSubview(añoActual);
        //padre.textoMes!.text = calcuaMes(0);

        
        print("Año de : ", Nino.nombre);
    }
    
    //Método que carga las loncheras de la semana que se está modificando
    func cargaSemanaActual(){
        
        for loncherasN in DatosC.contenedor.ninos{
            let loncherasS = loncherasN.loncheras;
            for lonc in loncherasS{
                
            
            let fecha = lonc.fecha;
            let formateador:NSDateFormatter=NSDateFormatter();
            formateador.locale = NSLocale.init(localeIdentifier: "es_CO");
            formateador.dateFormat="yyyy";
            let año = Int(formateador.stringFromDate(fecha!));
            formateador.dateFormat="MM";
            let mes = Int(formateador.stringFromDate(fecha!));
            formateador.dateFormat="dddd";
            let dia = Int(formateador.stringFromDate(fecha!));
            //print ("Año: ", año);
            //print ("Mes: ", mes);
            //f.id = idNino;print ("Día: ", dia);
            //print("Padre: ", self.padre);
            var pasa = true;
            var cantNuls = 0;
            for cas in (lonc.subVista?.casillas)!{
                if(cas.elemeto == nil){
                    cantNuls += 1;
                }
            }
            if(cantNuls >= lonc.subVista?.casillas.count){
                pasa = false;
            }
            
            if(pasa){
                //print("NNN: ", Nino);
                //print("Lonc: ", loncherasN.nino.id);
                if (loncherasN.nino.id == Nino.id){
                    //print("Nino: ", loncherasN.nombreNino, "CC: ", Nino.nombre);
                    /*if(traeDia(año!, Mes: mes!, DiaN: dia!)!.nSemana == 7){
                        traeDia(año!, Mes: mes!, DiaN: dia!)!.setFondo2(3);
                    }*/
                    traeDia(año!, Mes: mes!, DiaN: dia!)!.seteaLonchera(lonc);
                    
                }
                
            }
                
            }
            //print("Cambia Niño........");
        }
        
        
        
    }
    //Método que trae un día del calendario
    func traeDia(año: Int, Mes: Int, DiaN: Int)->Dia?{
        var diaR : Dia?;
        //for nino in (añoActual.padre.padre.pestañasNinos?.ninos)!{
            //print("Nino: ",nino.activo, "NN: ", nino.ninoInt?.nombreNino);
        //}
        //print("AñoActual: ",añoActual.nino?.nombre);
        
        for mes in meses{
            //print("Nmes: ", mes.NumeroMes, " mes: ", Mes);
            if(mes.NumeroMes == Mes){
                //print("mes: ", mes.NumeroMes);
                for dia in mes.dias{
                    if(dia.numDia==DiaN){
                        //print("Dia: ", dia.numDia);
                        diaR = dia;
                    }
                    
                }
            }
            
        }
        return diaR;
    }
    
    
    func cargaDiasPosteriores(){
        /*
        for nn in DatosD.contenedor.ninos{
            if (nn.id == Nino.id){
                //print("self.A: ", self, " vs ", nn.añoActual);
                //self.añoActual = nn.añoActual?.añoActual;
            }
        }
        */
        for mes in self.meses{
            for dia in mes.dias{
                //print("dia: ", dia.numDia," - ", dia.lonchera)
                if(dia.lonchera != nil){
                    //print("posee: ", dia.numDia);
                    
                    dia.seteaLonchera(dia.lonchera!);
                }
            }
        }
        meses.last?.dias.last?.bloqueaDiasAnteriores();
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        if(self.contentOffset.y > 0){
            //padre.textoMes!.text =
            calcuaMes(self.contentOffset.y);
            //print("nin: ", self.Nino.nombre);
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        //print("CCCC: ", self.contentOffset, "ppp: ", padre.textoMes);
        if(self.contentOffset.y > 0){
            //padre.textoMes!.text =
            calcuaMes(self.contentOffset.y);
        }
        
    }
    
    func calcuaMes(posY: CGFloat)->String{
        //print("calcula: ", posY);
        var ret:String!;
        ret = "";
        //ret = posMeses.first!.2.nombreMes;
        var p = 0;
        var continua = true;
        while(continua){
            var Ma = false;
            var Me = false;
            if(posY > self.posMeses[p].0){
                //print("mayor del mes");
                Ma = true;
            }
            if(posY < self.posMeses[p].1){
                //print("menor del mes");
                Me = true;
            }
            if(Ma && Me){
                //print("EN Rango: ", self.posMeses[p].2.nombreMes);
                ret = self.posMeses[p].2.nombreMes;
            }
            p += 1;
            
            if(p >= self.posMeses.count){
                continua = false;
            }
            
        }
        //DatosD.contenedor.calendario.eliminaTextoMes();
        if(DatosD.contenedor.calendario.textoMes == nil){
            //print(" DD nulo text: ", padre.textoMes!.frame);
            //print("Nuevo");
            //
            DatosD.contenedor.calendario.iniciaTextoMes();
            
            padre.textoMes = DatosD.contenedor.calendario.textoMes;
            DatosD.contenedor.calendario.textoMes.text = ret;
            
        }else{
            //print("Viejo");
            padre.textoMes.text = ret;
            //print("text: ", padre.textoMes!.frame);
            //print("hhh: ", ret);
        }
        
        
        //padre.textoMes.textColor = UIColor.redColor();
        return ret;
    }
    
    //Método que calcula los rangos de los meses
    func CalposMeses(){
        var pos = [(CGFloat, CGFloat, Mes)]();
        
        for mes in meses{
            let primero = mes.dias.first?.frame.origin.y;
            let ultimo = mes.dias.last?.frame.origin.y;
            let fila = (primero!, ultimo!, mes);
            pos.append(fila);
        }
        self.posMeses = pos;
        print("Calpos");
    }
    
    //Método que pinta el día de donde vengo
    func diaActual(){
        /*
        var lonc : NSDate!;
        for nino in DatosC.contenedor.ninos{
            if(nino.activo == true){
                lonc = nino.loncheras[DatosC.contenedor.iActual].fecha;
                //print("dia Actual: ", lonc);
            }
        }
        */
        
        let año = NSCalendar.currentCalendar().component(.Year, fromDate: NSDate());
        let mes = NSCalendar.currentCalendar().component(.Month, fromDate: NSDate());
        let dia = NSCalendar.currentCalendar().component(.Day, fromDate: NSDate());
        print("tt: ",self.traeDia(año, Mes: mes, DiaN: dia)?.fecha);
        self.traeDia(año, Mes: mes, DiaN: dia)?.setFondo2(4);
    }
    
    //Mmétodo que evalua y pinta el día de la entrega si existen loncheras en una o varias semanas
    func diaEntrega(){
        //print("Evalua");
        
        for mes in self.meses{
            
            let lim = mes.nSemanas;
            //print("mes: ", mes.nombreMes, " n sema: ", lim);
            var posee = false;
            for numeSema in 0 ... lim!{
                
                for dia in mes.dias{
                    if(dia.nSemana == numeSema){
                        //print("Dia: ", dia.numDia, " de Semana: ", numeSema);
                        if(dia.lonchera == nil){
                            //print("no tiene");
                        }else{
                            //print("tiene");
                            posee=true;
                        }
                    }
                    
                }
                if(posee == true){
                    //print("mes: ",mes.nombreMes, "dia: ", numeSema," Posee: ", posee);
                    pintaDiaEntrega(mes, semana: numeSema);
                    posee = false;
                }
            }
            
        }
    }
    
    //Método que pinta el dia de la entrega de acuerdo a la semana
    func pintaDiaEntrega(mes: Mes, semana: Int){
        var mesT = mes;
        var semanaT = semana;
        //print("sema: ", semanaT, " messema: ", mes.nSemanas);
            if((semanaT)>mes.nSemanas){
                var m = 0;
                for mes2 in meses{
                    if(mes.NumeroMes == mes2.NumeroMes){
                        if((m+1)>12){
                            mesT = meses[0];
                        }else{
                            mesT = meses[m+1];
                        }
                        
                    }
                    m += 1;
                }
                semanaT=1;
            }
           
        
        //print("Mes: ", mesT.nombreMes, " semana: ", semanaT)
        var totsema=0;
        for dia in mesT.dias{
            if(dia.nSemana == (semanaT)){
                totsema += 1;
            }
        }
        /*
        if(totsema<7){
            semanaT += 1;
        }else{
            semanaT += 1;
        }*/
        
        for dia in mesT.dias{
            
            if(dia.nSemana == (semanaT) && dia.diaSenama==1){
                
                //print("Este: ", dia.numDia);
                
                    dia.setFondo2(3);
                
                
                
            }
        }
    }
    
    func offsetVisible(){
        //calcuaMes(self.contentOffset.y);
        let mascara = UIView(frame: CGRectMake(0, self.frame.origin.y, DatosC.contenedor.anchoP, self.frame.height));
        mascara.alpha = 1;
        mascara.backgroundColor=UIColor.redColor();
        //self.padre.view.maskView=mascara;
        //self.layer.mask?.bounds = CGRectMake(0, self.frame.origin.y, DatosC.contenedor.anchoP, self.frame.height);
        //print("mak: ", self.layer.mask!.bounds);
        //self.layer.masksToBounds = false;
    }
    
    //Método que ubica el scroll en el día Actual
    func posicionaDiaActual()->CGFloat{
        let año = NSCalendar.currentCalendar().component(.Year, fromDate: NSDate());
        let mes = NSCalendar.currentCalendar().component(.Month, fromDate: NSDate());
        let dia = NSCalendar.currentCalendar().component(.Day, fromDate: NSDate());
        print("tt: ",self.traeDia(año, Mes: mes, DiaN: dia)?.fecha);
        return (self.traeDia(año, Mes: mes, DiaN: dia)?.frame.origin.y)!
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
