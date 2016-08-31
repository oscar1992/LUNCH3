//
//  BarraOpciones.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 28/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BarraOpciones: UIView {
    
    var dia : Dia!;
    var timer = NSTimer();
    var mensajeC : UIView!;
    var barra2 : UIView!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        iniciaBotones();
        traaAlFrente();
    }
    
    //Método que inicia los botones
    func iniciaBotones(){
        
        let anchos = self.frame.width/3;
        for nbot in 0...3{
            let OX = anchos * CGFloat(nbot);
            let OY = CGFloat(0);
            let frameBot = CGRectMake(OX, OY, anchos, self.frame.height);
            let bot = UIButton(frame: frameBot);
            let frameLabel = CGRectMake(0, 0, anchos, self.frame.height);
            let label = UILabel(frame: frameLabel);
            switch nbot {
            case 0:
                label.text = "Copiar";
                bot.addTarget(self, action: #selector(BarraOpciones.Copiar(_:)), forControlEvents: .TouchDown);
                break;
            case 1:
                label.text = "Eliminar";
                bot.addTarget(self, action: #selector(BarraOpciones.Eliminar(_:)), forControlEvents: .TouchDown);
                break;
            case 2:
                label.text = "Cancelar";
                bot.addTarget(self, action: #selector(BarraOpciones.Cancelar(_:)), forControlEvents: .TouchDown);
                break;
            default:
                break;
            }
            label.textAlignment=NSTextAlignment.Center;
            label.textColor=UIColor.whiteColor();
            label.font=UIFont(name: "SansBeam Head", size: self.frame.height*0.5);
            bot.addSubview(label);
            self.addSubview(bot);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que cierra la pestaña de las opciones (esta)
    func Cancelar(sender: UIButton){
        dia.bloqueadesbloqueaDias(false);
        for nino in (DatosD.contenedor.calendario.pestañasNinos!.ninos){
            if(nino.activo==true){
                //print("Nino Activo");
                
                for vista in nino.Ano!.slide.subviews{
                    if (vista.accessibilityValue == "Circulo"){
                        vista.removeFromSuperview();
                    }else{
                        //print("qq: ", vista);
                    }
                }
 
                
            }
        }
        if(barra2 != nil){
            barra2.removeFromSuperview();
        }
        self.removeFromSuperview();
        self.dia.ano?.diaActual();
        self.dia.bloquePasoDia(false);
    }
    
    func Copiar(sender: UIButton){
        if(dia.lonchera != nil){
            //muestraMensaje();
            for nino in (DatosD.contenedor.calendario.pestañasNinos?.ninos)!{
                if(nino.activo==true){
                    //print("Nino Activo");
                    
                    for mes in nino.Ano!.meses{
                        
                        for dia in mes.dias{
                            if(dia != self.dia && dia.activo==true && dia.diaSenama != 1){ //Solo se pone en los dias activos y en los que no son domingos
                                let ancho = DatosC.contenedor.anchoP*0.05;
                                let alto = DatosC.contenedor.altoP*0.05;
                                let OX = (dia.frame.width-ancho)+dia.frame.origin.x;
                                let OY = (dia.frame.height-alto)+dia.frame.origin.y;
                                let frameCirculo = CGRectMake(OX, OY, ancho, alto);
                                let circulo = Circulo(frame: frameCirculo);
                                //circulo.backgroundColor = UIColor.purpleColor();
                                circulo.dia=dia;
                                
                                dia.superview?.addSubview(circulo);
                                //print("CirculoPadre", circulo.superview);
                                dia.bringSubviewToFront(circulo);
                                //dia.userInteractionEnabled = true;
                            }
                            
                        }
                        
                    }
                    
                }else{
                    //print("Nino no Activo");
                }
            }
            self.hidden=true;
            BarraCopiar();
        }
    }
    
    //Método que muestra el mensaje
    func muestraMensaje(){
        let ancho = DatosC.contenedor.anchoP*0.4;
        let alto = DatosC.contenedor.altoP*0.2;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = (DatosC.contenedor.altoP/2)-(alto/2);
        let frameMensaje = CGRectMake(OX, OY, ancho, alto);
        mensajeC = UIView(frame: frameMensaje);
        mensajeC.backgroundColor = UIColor.greenColor();
        let mensajeL = UILabel(frame: CGRectMake(0,0,ancho,alto));
        mensajeL.text = "Selecciona los días en que quieres copiar la lonchera";
        mensajeC.addSubview(mensajeL);
        DatosD.contenedor.calendario.view.addSubview(mensajeC);
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(BarraOpciones.cierraMensaje), userInfo: nil, repeats: false);
    }
    
    //Método que cierra el mensaje
    func cierraMensaje(){
        print("CIerra");
        mensajeC.removeFromSuperview();
    }
    
    //Método que establece la barra de copiado
    func BarraCopiar(){
        let ancho = self.frame.width*0.6;
        let alto = self.frame.height;
        let OX = (((self.frame.width/2)-(ancho/2)))+self.frame.origin.x;
        print("OX: ", OX);
        let OY = self.frame.origin.y;
        let frameBarra = CGRectMake(OX, OY, ancho, alto);
        barra2 = UIView(frame: frameBarra);
        let botCopiar = UIButton(frame: CGRectMake(0, 0, ancho/2, alto));
        let botCancelar = UIButton(frame: CGRectMake(ancho/2, 0, ancho/2, alto));
        let labelCopiar = UILabel(frame: CGRectMake(0, 0, ancho/2, alto));
        let labelCancelar = UILabel(frame: CGRectMake(0, 0, ancho/2, alto));
        let frameFondo = CGRectMake(0, 0, ancho, alto);
        let ima = UIImage(named: "pegar");
        let backImg = UIImageView(frame: frameFondo);
        backImg.image=ima;
        barra2.addSubview(backImg);
        barra2.sendSubviewToBack(backImg);
        //barra2.backgroundColor=UIColor.grayColor();
        botCopiar.addSubview(labelCopiar);
        botCancelar.addSubview(labelCancelar);
        labelCancelar.text = "Cancelar";
        labelCancelar.textAlignment=NSTextAlignment.Center;
        labelCancelar.textColor=UIColor.whiteColor();
        labelCancelar.font=UIFont(name: "SansBeam Head", size: alto*0.5);
        labelCopiar.text = "Pegar";
        labelCopiar.textAlignment=NSTextAlignment.Center;
        labelCopiar.textColor=UIColor.whiteColor();
        labelCopiar.font=UIFont(name: "SansBeam Head", size: alto*0.5);
        barra2.addSubview(botCopiar);
        barra2.addSubview(botCancelar);
        botCancelar.addTarget(self, action: #selector(BarraOpciones.Cancelar(_:)), forControlEvents: .TouchDown);
        botCopiar.addTarget(self, action: #selector(BarraOpciones.Copiar2(_:)), forControlEvents: .TouchDown);
        dia.superview?.addSubview(barra2);
    }
    
    //Método que copia la lonchera seleccionada en los días chuleados
    func Copiar2 (sender: UIButton){
        
        for dia in DatosD.contenedor.diasCopia{
            for nino in (DatosD.contenedor.calendario.pestañasNinos!.ninos){
                if(nino.activo==true){
                    for mes in (nino.Ano?.meses)!{
                        for dia2 in mes.dias{
                            if(dia.numDia == dia2.numDia && dia.mes.NumeroMes == dia2.mes.NumeroMes && dia.mes.ano == dia2.mes.ano){
                                dia2.seteaLonchera(self.dia.lonchera!);
                                print("DD: ", dia.numDia, " mes: ", dia.mes.NumeroMes );
                            }
                        }
                    }
                }
                
            }
            
            
        }
        self.dia.traeLoncheraSemanaActual();
        DatosD.contenedor.diasCopia.removeAll();
        Cancelar(sender);
        
    }
    
    //Método que elimina una lonchrea de un día
    func Eliminar(sender: UIButton){
        dia.BorraLonchera();
        Cancelar(sender);
    }
    
    //Método que establece el fondo de la barra
    func fondoBarra(){
        let frameFondo = CGRectMake(0, 0, self.frame.width, self.frame.height);
        let ima = UIImage(named: "cancelar");
        let backImg = UIImageView(frame: frameFondo);
        backImg.image=ima;
        self.addSubview(backImg);
        self.sendSubviewToBack(backImg);
    }
    
    //Método que deja la barra por encima de todo
    func traaAlFrente(){
        self.layer.masksToBounds = false;
        //self.layer.zPosition=1;
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
