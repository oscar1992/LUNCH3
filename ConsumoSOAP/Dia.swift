//
//  Dia.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Dia: UIButton{
    
    var numDia:Int?;
    var diaSenama:Int?;
    var nSemana:Int?
    var diaTit:UILabel?;
    var lonchera : LoncheraO?;
    var mes: Mes!;
    var activo = false;
    var timer:NSTimer!;
    var tocado = false;
    var ano: AnoScroll?;
    var fecha: NSDate!;
    var bloqueoCambioDia = false;
    
    init(frame: CGRect, nDia: Int, mes: Mes) {
        super.init(frame: frame);
        let calendar = NSCalendar.currentCalendar();
        let fecha = NSDateComponents();
        numDia=nDia;
        fecha.year = mes.ano;
        fecha.month=mes.NumeroMes;
        fecha.day=nDia;
        self.fecha = NSCalendar.currentCalendar().dateFromComponents(fecha);
        self.mes = mes;
        let ds = calendar.component(.Weekday, fromDate: self.fecha);
        let sm = calendar.component(.WeekOfMonth, fromDate: self.fecha);
        //print("ff: ", ds);
        diaSenama = ds;
        nSemana = sm;
        //iniciaFecha(mes.ano, Mes: mes.NumeroMes, Dia: nDia);
        self.activo=true;
    }
    
    //Método que inicia le fecha del día cuando se crea el día
    func iniciaFecha(Año: Int, Mes: Int, Dia: Int){
        let arma = NSDateComponents();
        //print("Año: ", Año);
        arma.year = Año;
        arma.month = Mes;
        arma.day = Dia;
        fecha = NSCalendar.currentCalendar().dateFromComponents(arma);
        
    }
    
    //Método que establece el fondo de desta vista
    func setFondo2(qq : Int){
        diaTit=UILabel(frame: CGRectMake(0,0,self.frame.width,self.frame.height/2));
        diaTit!.textColor=UIColor.whiteColor();
        diaTit!.font = UIFont(name: "SansBeam Head", size: 35);
        diaTit!.textAlignment=NSTextAlignment.Center;
        diaTit!.text=String(numDia);
        //print("nn: ", numDia);
        self.addSubview(diaTit!);
        for vista in self.subviews{
            if vista is UIImageView && vista.accessibilityIdentifier == "Fondo"{
                vista.removeFromSuperview();
            }
        }
        let tt = String(numDia!);
        diaTit!.text = tt;
        var fondo : UIImage;
        //print("QQ: ", qq);
        switch qq {
        case 1:
            fondo = UIImage(named: "DiaA")!;
            break;
        case 2:
            fondo = UIImage(named: "DiaI")!;
            break;
        case 3:
            fondo = UIImage(named: "DiaE")!;
            break;
        default:
            fondo = UIImage(named: "DiaSe")!;
            break;
        }
        //print("Fondo dia: ", self.frame);
        
        let backImg = UIImageView(frame: CGRectMake(0,0,self.frame.width-(self.frame.width*0.01),self.frame.height-(self.frame.height*0.01)));
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = fondo;
        backImg.accessibilityIdentifier = "Fondo";
        //backImg.userInteractionEnabled = false;
        self.addSubview(backImg);
        self.sendSubviewToBack(backImg);
        
        
    }
    
    func Activa (sender : AnyObject){
        //print("Activo despues: ", tocado);
        tocado = true;
    }
    
    func Activa2(sender : AnyObject){
        if(tocado){
            if(self.activo==true){
                barraOpciones();
                bloqueaDiasAnteriores();
                bloquePasoDia(true);
            }
            print("bloquea");
        }else{
            if(self.activo==true && bloqueoCambioDia == false){
                semanaFutura();
            }
            
            if (self.lonchera != nil){
                print("Tiene Lonchera");                
            }else{
                print("No tiene Lonchera");
            }
            
        }
    }
    
    //Método que establece la lonchera del día
    func seteaLonchera(lonc: LoncheraO){
        self.lonchera=lonc;
        var imagen : UIImage;
        var nombre = "";
        for vista in self.subviews{
            if (vista is UIImageView && vista.accessibilityValue == "locheraIcono"){
                //print("Remueve Lonchera");
                vista.removeFromSuperview();
            }
        
        }
        if(self.lonchera?.saludable == true){
            nombre = "MiniV";
        }else{
            nombre = "MiniR";
        }
        /*
        if(self.lonchera?.color == nil){
            
        }else{
            switch  self.lonchera!.color! {
            case 2:
                nombre = "MiniR";
                break;
            case 3:
                nombre = "MiniA";
                break;
            case 1:
                nombre = "MiniV";
                break;
            case -2:
                nombre = "MiniAZ";
                break;
            default:
                nombre = "MiniV";
                break;
            }
        }
         */
        let alto = self.frame.height*0.5;
        let ancho = self.frame.width*0.7;
        let frameCaja = CGRectMake(self.frame.width-ancho, alto, ancho, alto);
        imagen = UIImage(named: nombre)!;
        let back = UIImageView(frame: frameCaja);
        back.accessibilityValue = "locheraIcono";
        back.image=imagen;
        //print("ima: ", nombre);
        //back.userInteractionEnabled=false;
        //self.setFondo2(3);
        self.addSubview(back);
        self.bringSubviewToFront(back);
        //print("copia lonchera: ", back.image);
        //self.addTarget(self, action: #selector(Dia.Activa(_:)), forControlEvents: .TouchDown);
    }
    
    //Método que reconoce el touch del Día
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("tocando: ", tocado);
        //tocado = true;
        Activa(self);
        timer = NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(Dia.Activa2(_:)), userInfo: nil, repeats: false);
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("fin tocado");
        timer = nil;
        tocado = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que inicia la barra de las opciones
    func barraOpciones(){
        if(self.lonchera != nil){
            let ancho = DatosC.contenedor.anchoP*0.5;
            let alto = DatosC.contenedor.altoP*0.05;
            let OX = (self.frame.origin.x+(self.frame.width/2))-(ancho/2);
            if (OX < 0 || (OX+ancho) > self.superview?.superview?.frame.width){
                print("Se sale");
            }
            let OY = self.frame.origin.y - alto;
            let barraFrame=CGRectMake(OX, OY, ancho, alto);
            let barra = BarraOpciones(frame: barraFrame);
            barra.dia=self;
            //barra.backgroundColor = UIColor.redColor();
            barra.fondoBarra();
            self.superview?.addSubview(barra);
            bloqueadesbloqueaDias(true);
        }
    }
  
    //Método que bloquea los días del calendario
    func bloqueadesbloqueaDias(bloquea: Bool){
        mes.BloqueaDias(bloquea);
    }
    
    //Método que establece el cìrculo de selección de la copia
    func seleccionCirculo(){
        let OX = self.frame.width*0.6;
        let OY = self.frame.height*0.6;
        let ancho = self.frame.width*0.4;
        let alto = self.frame.height*0.4;
        let frameCirculo = CGRectMake(OX, OY, ancho, alto);
        let circulo = UIView(frame: frameCirculo);
        self.superview!.addSubview(circulo);
    }
    
    //Método que vacía una lonchera en el home de la semana actual
    func BorraLonchera(){
        self.lonchera = nil;
        for vista in self.subviews{
            if (vista is UIImageView && vista.accessibilityValue == "locheraIcono"){
                //print("Remueve Lonchera");
                vista.removeFromSuperview();
                for nino in DatosC.contenedor.ninos{
                    if(nino.activo == true){
                        //print("Nino Activo");
                        for lonc in nino.loncheras{
                            let fechaArma = NSDateComponents();
                            fechaArma.year = self.mes.ano;
                            fechaArma.month = self.mes.NumeroMes!;
                            fechaArma.day = self.numDia!;
                            
                            
                            let fechaCompara = NSCalendar.currentCalendar().dateFromComponents(fechaArma);
                            if(fechaCompara == lonc.fecha){
                                //print("Fecharama: ", fechaCompara);
                                //print("Fecha: ",lonc.fecha);
                                lonc.limpia();
                                lonc.contador?.actua();
                            }
                            
                            
                        }
                    }
                }
            }
            
        }
    }
    
    //Método que copia una lonchera en la semana nueva
    func traeLoncheraSemanaActual(){
        let DatosOrigen = self.lonchera;
        //for cas in (DatosOrigen?.subVista?.casillas)!{
            //print("prodo: ", cas.elemeto);
        //}
        DatosD.contenedor.diasCopia.append(self);
        DatosD.contenedor.diasCopia.sortInPlace({$0.numDia<$1.numDia});
        DatosD.contenedor.diasCopia.sortInPlace({$0.mes.NumeroMes<$1.mes.NumeroMes});
        for dia in DatosD.contenedor.diasCopia{
            
            print("EE: ", dia.numDia);
        }
        
        var sobrePaso = false;
        for nino in DatosC.contenedor.ninos{
                if(nino.activo == true){
                    //print("Nino act", nino.nombreNino);
                    //var sobrePases = 0;
                    for diaC in DatosD.contenedor.diasCopia{
                        let fechaArma = NSDateComponents();
                        fechaArma.year = self.mes.ano;
                        fechaArma.month = self.mes.NumeroMes!;
                        fechaArma.day = diaC.numDia!;
                        
                        var fechaCompara = NSCalendar.currentCalendar().dateFromComponents(fechaArma);
                        print("FechaComp: ", fechaCompara, " pasa: ", sobrePaso);
                        for lonc in nino.panelNino.Lonchera.deslizador.paginas{
                            
                            //print("ultimo: ", (self.mes.dias.last?.numDia), " diaC: ", diaC.numDia);
                            
                            /*
                            if (sobrePaso){
                                fechaArma.month += 1;
                                if(fechaArma.month > 12){
                                    fechaArma.year += 1;
                                }
                                fechaCompara = NSCalendar.currentCalendar().dateFromComponents(fechaArma);
                                
                            }
                             */
                            //print("FECHACCOP: ", fechaCompara, " FECHALONC: ", lonc.fecha);
                            if(sobrePaso){
                                fechaArma.month = self.mes.NumeroMes!;
                                fechaArma.month += 1;
                                //print("Se pasa: ", fechaArma.month);
                                fechaCompara = NSCalendar.currentCalendar().dateFromComponents(fechaArma);
                                //print("FEcha Nueva: ", fechaCompara);
                                //sobrePaso=false;
                            }
                            if(fechaCompara == lonc.fecha){
                                
                                //print("PASA: FECHACCOP: ", fechaCompara, " FECHALONC: ", lonc.fecha);
                                if(self.lonchera?.subVista?.casillas.count > lonc.subVista?.casillas.count){
                                    let ccuantas = (self.lonchera?.subVista?.casillas.count)! - (lonc.subVista?.casillas.count)!;
                                    for _ in 0 ..< ccuantas{
                                        lonc.addcasilla(self);
                                    }
                                    
                                }
                                //print("ff: ", lonc.fecha);
                                copiaLonchera(lonc, fuente: DatosOrigen!);
                                lonc.contador?.actua();
                            }
                            
                        }
                        //print("diaC: ", diaC.numDia, " ultimo: ", self.mes.dias.last?.numDia);
                        if(diaC.numDia == (self.mes.dias.last?.numDia)){
                            //print("PASA");
                            sobrePaso=true;
                        }
                        /*
                        if ((self.mes.dias.last?.numDia) > diaC.numDia && sobrePaso == false){
                            print("Sobrepaso");
                            sobrePaso = true;
                        }
                        */
                    }
                    
            }
        }
        
    }
    //Método que copia los productos que estan dentro de la lonchera
    func copiaLonchera(objetivo: LoncheraO, fuente: LoncheraO){
        var p = 0;
        //for cas in (fuente.subVista?.casillas)!{
            //print("cas 2: ", cas.elemeto?.producto);
        //}
        if(fuente.subVista?.casillas.count>objetivo.subVista?.casillas.count){
            for _ in 0...((fuente.subVista?.casillas.count)!-(objetivo.subVista?.casillas.count)!){
                objetivo.addcasilla(self);
            }
        }
        
        
        for casO in (objetivo.subVista?.casillas)!{
            if (casO.elemeto != nil){
                casO.elemeto?.removeFromSuperview();
            }
            //let ele = ProductoView(frame: CGRectMake(0, 0, casO.frame.width, casO.frame.height), imagen: (fuente.subVista?.casillas[p].elemeto!.producto!.imagen)!);
            
            if (fuente.subVista?.casillas[p].elemeto != nil){
                let ele = fuente.subVista?.casillas[p].elemeto!.copiarse();
                ele!.frame = CGRectMake(0, 0, casO.frame.width, casO.frame.height);
                /*
                print("ele", ele);
                print("ele.tipo",casO.tipo);
                print("ele.prod", ele!.producto);
                print("ele.ima", ele!.producto!.imagen);
                */
                casO.seteaElemento(ele!, tipo: casO.tipo!, ima: (ele!.producto?.imagen)!, prod: ele!.producto!);
            }
            
            p += 1;
            
        }
        self.ano?.diaEntrega();
    }
    
    //Método que retorna al home dependiendo de si se develve a la semana actual o a una semana futura
    func semanaFutura(){
        //print("Vuelve");
        var cambia = false;
        var semanaNueva = [LoncheraO]();
        let fechaArma = NSDateComponents();
        fechaArma.year = self.mes.ano;
        fechaArma.month = self.mes.NumeroMes!;
        fechaArma.day = self.numDia!;
        let fechaCompara = NSCalendar.currentCalendar().dateFromComponents(fechaArma);
        let calendar = NSCalendar.currentCalendar();
        let nsemana = calendar.components(.WeekOfMonth, fromDate: fechaCompara!);
        DatosD.contenedor.calendario.volver(self);
        for nino in DatosC.contenedor.ninos{
            if(nino.activo == true){
                for lonc in nino.panelNino.Lonchera.deslizador.paginas{
                    
                    print("FECHAC: ", fechaCompara, " FECHALONC: ", lonc.fecha);
                    if (lonc.fecha == fechaCompara){
                        
                        //print("Semana Actual");
                        cambia=false;
                        break;
                    }else{
                        cambia = true;
                    }
                }
                
            }
        }
        if(cambia){
            //print("cambia");
            for dia in self.mes.dias{
                //print("dd: ", dia.diaSenama, " dia: ", dia.numDia);
                if(dia.diaSenama == 1){
                    
                }else{
                    //print("dia: ", dia.nSemana, " - ", nsemana.weekOfMonth);
                    var p = 0;
                    if(dia.nSemana! == Int(nsemana.weekOfMonth)){
                        //print("DiaA: ", dia.numDia);
                        //print("Año: ", fechaArma.year);
                        //print("Mes: ", fechaArma.month);
                        //print("Dia: ", fechaArma.day);
                        //let scrol = ano;
                        let recuDia = ano!.traeDia(fechaArma.year, Mes: fechaArma.month, DiaN: dia.numDia!);
                        let loncheraVacia = LoncheraO();
                        loncheraVacia.inicia(p);
                        fechaArma.day = dia.numDia!;
                        let fechaCompara = NSCalendar.currentCalendar().dateFromComponents(fechaArma);
                        let diasemana = calendar.components(.Weekday, fromDate: fechaCompara!);
                        //print("ff: ", dia.numDia, " - ", self.mes.dias.last?.numDia);
                        if(recuDia?.lonchera != nil){
                            copiaLonchera(loncheraVacia, fuente: (recuDia?.lonchera)!);
                            //print("Añade: ", recuDia?.lonchera?.fecha);
                            //loncheraVacia.subVista.
                        }else{
                            //recuDia?.lonchera = LoncheraO();
                        }
                        //loncheraVacia.fecha=fechaCompara;
                        loncheraVacia.cambiaFecha(fechaCompara!);
                        //print("añade: ", p);
                        semanaNueva.append(loncheraVacia);
                        if(dia.numDia == self.mes.dias.last?.numDia && diasemana.weekday != 7){
                            //print("posterior");
                            semanaNueva = semanaNueva+mesPartidoPosterior(fechaArma, fechaCompara2: fechaCompara!, calendar: calendar, p: p, anterior: true);
                        }else if(dia.numDia == self.mes.dias.first?.numDia && diasemana.weekday != 0){
                            //print("anterior");
                            let semAux = semanaNueva;
                            semanaNueva = mesPartidoPosterior(fechaArma, fechaCompara2: fechaCompara!, calendar: calendar, p: p, anterior: false)+semAux;
                            //print("NMES: ", fechaArma.month);
                            fechaArma.month+1;
                        }
                        p += 1;
                    }
                }
                
            }
            let diaSemana = calendar.components(.Weekday, fromDate: fechaCompara!);
            
            
            cambiaSemana(semanaNueva, diaSemana: (diaSemana.weekday-1));
        }else{
            for nino in DatosC.contenedor.ninos{
                if(nino.activo == true){
                    
                    let des = nino.panelNino.Lonchera.deslizador;
                    print("QQ: ", self.diaSenama!-1);
                    des.mueveAPosicion(self.diaSenama!-1);
                }
            }
            
        }
        print("termina correcatmente?");
    }
    
    
    // Método que completa la semana ciuando el mes no termina un sábado (7)
    func mesPartidoPosterior(fechaArma : NSDateComponents, fechaCompara2: NSDate, calendar: NSCalendar, p: Int, anterior: Bool)->[LoncheraO]{
        var semanaRetorna = [LoncheraO]();
        //print("aaaa: ",anterior);
        if(anterior){
            fechaArma.month = self.mes.NumeroMes!+1;
            fechaArma.day = 1;
            var fechaCompara = fechaCompara2;
            let diasemana = calendar.components(.Weekday, fromDate: fechaCompara);
            //print("diasemana: ", diasemana.weekday);
            for rest in diasemana.weekday ... 6 {
                fechaCompara = NSCalendar.currentCalendar().dateFromComponents(fechaArma)!;
                let recuDia = ano!.traeDia(fechaArma.year, Mes: fechaArma.month, DiaN: (fechaArma.day));
                let loncheraVacia = LoncheraO();
                loncheraVacia.inicia(p);
                if(recuDia?.lonchera != nil){
                    copiaLonchera(loncheraVacia, fuente: (recuDia?.lonchera)!);
                    //print("agrega: ", recuDia?.lonchera?.fecha);
                }else{
                    //print("Excede Nula")
                }
                //print("queda: ", fechaCompara);
                loncheraVacia.cambiaFecha(fechaCompara);
                semanaRetorna.append(loncheraVacia);
                fechaArma.day += 1;
                
            }
        }else{
            fechaArma.month = self.mes.NumeroMes!-1;
            var ultimoDia : Dia!;
            var p = 0;
            for meses in ano!.meses{
                //print("NMES: ", meses.NumeroMes, " - mes: ", self.mes.NumeroMes)
                if (meses.NumeroMes == self.mes.NumeroMes!-1){
                    ultimoDia = ano!.meses[p].dias.last
                }
                p += 1;
            }
            var fechaCompara = fechaCompara2;
            let diasemana = calendar.components(.Weekday, fromDate: fechaCompara);
            fechaArma.day = ultimoDia!.numDia! - (diasemana.weekday-2);
            //print("Dia: ", fechaArma.day);
            //print("Week day: ", diasemana.weekday);
            for _ in 0 ... diasemana.weekday-2{
                fechaCompara = NSCalendar.currentCalendar().dateFromComponents(fechaArma)!;
                let recuDia = ano!.traeDia(fechaArma.year, Mes: fechaArma.month, DiaN: (fechaArma.day));
                let loncheraVacia = LoncheraO();
                loncheraVacia.inicia(p);
                if(recuDia?.lonchera != nil){
                    copiaLonchera(loncheraVacia, fuente: (recuDia?.lonchera)!);
                    
                    //print("agrega: ", recuDia?.lonchera?.fecha);
                }else{
                    //print("Excede Nula");
                }
                //print("queda: ", fechaCompara);
                loncheraVacia.cambiaFecha(fechaCompara);
                semanaRetorna.append(loncheraVacia);
                fechaArma.day += 1;
                
                
            }
            fechaArma.month += 1;
            //print("nmes: ", fechaArma.month);
        }
        /*
        for ll in semanaRetorna{
            print("lonc fech: ", ll.fecha);
        }
        */
        return semanaRetorna;
    }
    
    //Método que permitirá reemplazar los valores del home por los de una semana nueva
    func cambiaSemana(semanaN: [LoncheraO], diaSemana: Int){
        
        for nino in DatosC.contenedor.ninos{
            if(nino.activo == true){
                var p = 0;
                nino.loncheras.removeAll();
                nino.loncheras = semanaN;
                nino.panelNino.Lonchera.deslizador.reemplazaLonchera(semanaN, diaSemana: diaSemana);
                /*for lonc in nino.panelNino.Lonchera.deslizador.paginas{
                    var ll = lonc;
                    ll = semanaN[p];
                    
                    p += 1;
                }*/
            }
        }
        
    }
    
    //Método que bloqueará los días anteriores a la semana actual
    func bloqueaDiasAnteriores(){
        let fechaAct = NSDate();
        let cal = NSCalendar.currentCalendar();
        let fechaComp = NSDateComponents();
        fechaComp.year = cal.component(.Year, fromDate: fechaAct);
        fechaComp.month = cal.component(.Month, fromDate: fechaAct);
        let diaS = cal.component(.Weekday, fromDate: NSCalendar.currentCalendar().dateFromComponents(fechaComp)!);
        print("diaS: ", diaS);
        fechaComp.day = cal.component(.Day, fromDate: fechaAct)+(diaS);
        print("aña: ",(7-diaS));
        if(fechaComp.isValidDateInCalendar(cal)){
            
        }else{
            fechaComp.day=1;
            fechaComp.month += 1;
            if(fechaComp.month > 12){
                fechaComp.year += 1;
                fechaComp.month = 1;
            }
            
        }
        
        let fechaLim = NSCalendar.currentCalendar().dateFromComponents(fechaComp);
        //print("Fecha COmp: ", fechaComp);
        
       
        
        //print("años", ano!.años.count);
        //print("mes", ano!.meses.count);
        
            for mes in ano!.meses{
                for dia in mes.dias{
                    
                    let compara = dia.fecha.compare(fechaLim!);
                    //print("COMP: ", compara.rawValue);
                    
                    if(compara.rawValue <= 0){
                        dia.setFondo2(2);
                        dia.activo=false;
                        //print("menor");
                    }else{
                        //print("mayor");
                    }
                    
                }
            }
        
    }
    
    func bloquePasoDia(bloq: Bool){
        for mes in ano!.meses{
            for dia in mes.dias{
                dia.bloqueoCambioDia=bloq;
            }
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
}
