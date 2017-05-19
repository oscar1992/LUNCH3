//
//  Calendario.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 10/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Calendario: UIViewController {
/*
    //var mesScroll:MesScroll!;
    var subPanel:UIView?;
    var fechaActual: Date?;
    var pestañasNinos : CalendarioNinos?;
    
    var textoMes:UILabel!;
    //var diasLab = [UIView]();
    
    
    @IBOutlet weak var laBarra: UIView!
    
    
    override func viewDidLoad() {
        
        DatosD.contenedor.calendario = self;
        Fondo();
        iniciafechaActual();
        iniciaPestanas();
        //iniciaTextoMes();
        iniciaDiasLab();
        iniciaVistaPedido();
        iniciaBotonPedido();
        //self.view.bringSubviewToFront(laBarra);
        inciaVolver();
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Método que permite continuar a la pantalla del Reporte-Factura
    func avanza(_ sender: AnyObject){
        //leeMes();
        //DatosC.contenedor.ninoActual!.mesActual=DatosC.mesActual;
        //print("NN: ", DatosC.contenedor.ninoActual?.padre?.nombreNino);
        self.performSegue(withIdentifier: "Factura", sender: nil);
    }

    
    // Método que inicia las pestañas de los niños disponibles
    func iniciaPestanas(){
        let OY = DatosC.contenedor.altoP*0.06;
        let alto = DatosC.contenedor.altoP*0.04;
        let ancho = DatosC.contenedor.anchoP*0.8;
        let frame = CGRect(x: 0, y: OY, width: ancho, height: alto);
        
        
        pestañasNinos = CalendarioNinos();
        pestañasNinos!.frame = frame;
        //print("pestana: ", pestañasNinos?.frame);
        pestañasNinos!.inicia();
        self.view.addSubview(pestañasNinos!);
    }
    
    // Método que inicia el calendario con al fecha actual
    func iniciafechaActual(){
        fechaActual=Date();
        
         
        /// Fecha simulada 
        /*
        let fecha2 = NSDateComponents();
        fecha2.year = 2016;
        fecha2.month = 9;
        fecha2.day = 5;
        fechaActual = NSCalendar.currentCalendar().dateFromComponents(fecha2);
        */
        
        //let calendar=NSCalendar.currentCalendar();
        //LΩos años deben empesar en la primera compra del cliente en el historial
        //let añoActual=calendar.component(.Year, fromDate: fechaActual!);
        //let mesActual=calendar.component(.Month, fromDate: fechaActual!);
        let formateador:DateFormatter=DateFormatter();
        formateador.locale = Locale.init(identifier: "es_CO");
        formateador.dateFormat="yyyy-MM-dd";
        print("fecha Actual: ", formateador.string(from: fechaActual!));
    }
    
    //Método que inicia el botón de devolver
    func inciaVolver(){
        let ancho = DatosC.contenedor.anchoP*0.1;
        let alto = ancho;
        let OX = CGFloat(0);
        let OY = CGFloat(0);
        let frameBot = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let volver = UIButton(frame: frameBot);
        let frameFondo = CGRect(x: (ancho/2)-((ancho*0.5)/2), y: (alto/2)-((alto*0.5)/2), width: ancho*0.5, height: alto*0.5);
        let img = UIImage(named: "Volver");
        let backImg=UIImageView(frame: frameFondo);
        backImg.image=img;
        backImg.contentMode=UIViewContentMode.scaleAspectFit;
        volver.addSubview(backImg);
        //volver.backgroundColor=UIColor.redColor();
        //volver.backgroundColor = UIColor.redColor();
        volver.addTarget(self, action: #selector(Calendario.volver(_:)), for: .touchDown);
        self.view.addSubview(volver);
        self.view.bringSubview(toFront: volver);
    }
    
    //Método que devuelve a la vista del home
    func volver(_ sender: UIButton){
        //print("volv");
        for nino in DatosC.contenedor.ninos{
            if (nino.activo==true){
                for ninoInt in (pestañasNinos?.ninos)!{
                    if (ninoInt.id == nino.nino.id){
                        nino.año = ninoInt.Ano;
                    }
                }
            }
        }
        
        self.dismiss(animated: true, completion: nil);
    }
    
    func Fondo(){
        let img = UIImage(named: "FondoCalendario");
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
        let back = UIImageView(frame: frame);
        back.image=img;
        self.view.addSubview(back);
        self.view.sendSubview(toBack: back);
    }
    
    //Método que inicia el labl del mes actual
    func iniciaTextoMes(){
        print("crea");
        let ancho = DatosC.contenedor.anchoP*0.5;
        let alto = DatosC.contenedor.altoP*0.09;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = DatosC.contenedor.altoP*0.1;
        let frameTexto = CGRect(x: OX, y: OY, width: ancho, height: alto);
        textoMes = UILabel(frame: frameTexto);
        //textoMes.backgroundColor=UIColor.redColor();
        for nino in (pestañasNinos?.ninos)!{
            if (nino.activo==true){
                textoMes.text = nino.Ano!.meses.first?.nombreMes;
            }
        }
        textoMes.textColor=UIColor.init(red: 0.02, green: 0.58, blue: 0.29, alpha: 1);
        textoMes.textAlignment=NSTextAlignment.center;
        textoMes.font=UIFont(name: "SansBeaM Head", size: alto);
        textoMes.accessibilityIdentifier = "Mes";
        self.view.addSubview(textoMes);
        self.view.bringSubview(toFront: textoMes);
    }
    
    //Método que remueve el label del mes
    func eliminaTextoMes(){
        for vv in self.view.subviews{
            if(vv.accessibilityIdentifier == "Mes"){
                print("Posee");
                let text = vv as! UILabel;
                text.textColor=UIColor.red;
                //vv.removeFromSuperview();
            }
        }
        //textoMes.removeFromSuperview();
    }
    
    //Método que inicia los labels de los dias del calendario
    func iniciaDiasLab(){
        let ancho = (self.view.frame.width)*0.9;
        let alto = DatosC.contenedor.altoP*0.04;
        let OX =  ancho/7;
        let OY = DatosC.contenedor.altoP*0.1 + DatosC.contenedor.altoP*0.09;
        //let OY = textoMes.frame.origin.y+textoMes.frame.height;
        let espacio = (DatosC.contenedor.anchoP/2)-(ancho/2);
        //print("VistaActual: ", OY);
        for i in 0...7{
            let labFrame = CGRect(x: (OX*CGFloat(i))+espacio, y: OY, width: OX, height: alto);
            //print("ff: ", labFrame);
            let lab = UILabel(frame: labFrame);
            switch i {
            case 0:
                lab.text = "DOM";
                break
            case 1:
                lab.text = "LUN";
                break
            case 2:
                lab.text = "MAR";
                break
            case 3:
                lab.text = "MIE";
                break
            case 4:
                lab.text = "JUE";
                break
            case 5:
                lab.text = "VIE";
                break
            case 6:
                lab.text = "SAB";
                break
            default:
                break;
            }
            lab.textAlignment=NSTextAlignment.center;
            lab.textColor=UIColor.init(red: 0.02, green: 0.58, blue: 0.29, alpha: 1);
            lab.font=UIFont(name: "SansBeam Head", size: alto*0.8);
            self.view.addSubview(lab);
        }
    }
    
    //Método que ubicará la imagen de la convención de la entrega del pedido
    func iniciaVistaPedido(){
        let ancho = DatosC.contenedor.anchoP*0.16;
        let alto = DatosC.contenedor.altoP*0.07;
        
        let OY = DatosC.contenedor.altoP*0.77;
        let altoMsg = DatosC.contenedor.anchoP*0.23;
        let OX = (DatosC.contenedor.anchoP/2)-((alto+altoMsg)/2);
        let framePed = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let frameMesg = CGRect(x: OX+ancho, y: OY, width: altoMsg, height: alto);
        let msg = UILabel(frame: frameMesg);
        msg.text = "En este día recibiras tu pedido";
        msg.font=UIFont(name: "SansBeamHead-Medium", size: alto/4);
        //msg.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        msg.textColor=UIColor.gray;
        msg.numberOfLines=0;
        let img = UIImage(named: "Convencion");
        let backImg = UIImageView(frame: framePed);
        backImg.image=img;
        backImg.contentMode=UIViewContentMode.scaleAspectFit;
        self.view.addSubview(backImg);
        self.view.addSubview(msg);
    }
    
    //Método que pinta el botón de confirmar el pedido
    func iniciaBotonPedido(){
        let ancho = DatosC.contenedor.anchoP*0.67;
        let alto = DatosC.contenedor.altoP*0.06;
        let OY = DatosC.contenedor.altoP*0.88;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let frameBot = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let bot = UIButton(frame: frameBot);
        let frameback = CGRect(x: 0, y: 0, width: ancho, height: alto);
        let img = UIImage(named: "ConfirmarPedido");
        let backimg = UIImageView(frame: frameback);
        backimg.image=img;
        backimg.contentMode=UIViewContentMode.scaleAspectFit;
        bot.addSubview(backimg);
        self.view.addSubview(bot);
    }
    
    //Mètodo que oculta la barra en este viewcontroller
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for nino in (pestañasNinos?.ninos)!{
            if (nino.activo==true){
                print("fin tocado: ", nino.Ano.contentOffset);
            }
        }
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
*/
}
