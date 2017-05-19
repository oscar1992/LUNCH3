//
//  BarraOpciones.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 28/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class BarraOpciones: UIView {
    /*
    var dia : Dia!;
    var timer = Timer();
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
            let frameBot = CGRect(x: OX, y: OY, width: anchos, height: self.frame.height);
            let bot = UIButton(frame: frameBot);
            let frameLabel = CGRect(x: 0, y: 0, width: anchos, height: self.frame.height);
            let label = UILabel(frame: frameLabel);
            switch nbot {
            case 0:
                label.text = "Copiar";
                bot.addTarget(self, action: #selector(BarraOpciones.Copiar(_:)), for: .touchDown);
                break;
            case 1:
                label.text = "Eliminar";
                bot.addTarget(self, action: #selector(BarraOpciones.Eliminar(_:)), for: .touchDown);
                break;
            case 2:
                label.text = "Cancelar";
                bot.addTarget(self, action: #selector(BarraOpciones.Cancelar(_:)), for: .touchDown);
                break;
            default:
                break;
            }
            label.textAlignment=NSTextAlignment.center;
            label.textColor=UIColor.white;
            label.font=UIFont(name: "SansBeam Head", size: self.frame.height*0.5);
            bot.addSubview(label);
            self.addSubview(bot);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que cierra la pestaña de las opciones (esta)
    func Cancelar(_ sender: UIButton){
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
    
    func Copiar(_ sender: UIButton){
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
                                let frameCirculo = CGRect(x: OX, y: OY, width: ancho, height: alto);
                                let circulo = Circulo(frame: frameCirculo);
                                //circulo.backgroundColor = UIColor.purpleColor();
                                circulo.dia=dia;
                                
                                dia.superview?.addSubview(circulo);
                                //print("CirculoPadre", circulo.superview);
                                dia.bringSubview(toFront: circulo);
                                //dia.userInteractionEnabled = true;
                            }
                            
                        }
                        
                    }
                    
                }else{
                    //print("Nino no Activo");
                }
            }
            self.isHidden=true;
            BarraCopiar();
        }
    }
    
    //Método que muestra el mensaje
    func muestraMensaje(){
        let ancho = DatosC.contenedor.anchoP*0.4;
        let alto = DatosC.contenedor.altoP*0.2;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = (DatosC.contenedor.altoP/2)-(alto/2);
        let frameMensaje = CGRect(x: OX, y: OY, width: ancho, height: alto);
        mensajeC = UIView(frame: frameMensaje);
        mensajeC.backgroundColor = UIColor.green;
        let mensajeL = UILabel(frame: CGRect(x: 0,y: 0,width: ancho,height: alto));
        mensajeL.text = "Selecciona los días en que quieres copiar la lonchera";
        mensajeC.addSubview(mensajeL);
        DatosD.contenedor.calendario.view.addSubview(mensajeC);
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(BarraOpciones.cierraMensaje), userInfo: nil, repeats: false);
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
        let frameBarra = CGRect(x: OX, y: OY, width: ancho, height: alto);
        barra2 = UIView(frame: frameBarra);
        let botCopiar = UIButton(frame: CGRect(x: 0, y: 0, width: ancho/2, height: alto));
        let botCancelar = UIButton(frame: CGRect(x: ancho/2, y: 0, width: ancho/2, height: alto));
        let labelCopiar = UILabel(frame: CGRect(x: 0, y: 0, width: ancho/2, height: alto));
        let labelCancelar = UILabel(frame: CGRect(x: 0, y: 0, width: ancho/2, height: alto));
        let frameFondo = CGRect(x: 0, y: 0, width: ancho, height: alto);
        let ima = UIImage(named: "pegar");
        let backImg = UIImageView(frame: frameFondo);
        backImg.image=ima;
        barra2.addSubview(backImg);
        barra2.sendSubview(toBack: backImg);
        //barra2.backgroundColor=UIColor.grayColor();
        botCopiar.addSubview(labelCopiar);
        botCancelar.addSubview(labelCancelar);
        labelCancelar.text = "Cancelar";
        labelCancelar.textAlignment=NSTextAlignment.center;
        labelCancelar.textColor=UIColor.white;
        labelCancelar.font=UIFont(name: "SansBeam Head", size: alto*0.5);
        labelCopiar.text = "Pegar";
        labelCopiar.textAlignment=NSTextAlignment.center;
        labelCopiar.textColor=UIColor.white;
        labelCopiar.font=UIFont(name: "SansBeam Head", size: alto*0.5);
        barra2.addSubview(botCopiar);
        barra2.addSubview(botCancelar);
        botCancelar.addTarget(self, action: #selector(BarraOpciones.Cancelar(_:)), for: .touchDown);
        botCopiar.addTarget(self, action: #selector(BarraOpciones.Copiar2(_:)), for: .touchDown);
        dia.superview?.addSubview(barra2);
    }
    
    //Método que copia la lonchera seleccionada en los días chuleados
    func Copiar2 (_ sender: UIButton){
        
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
    func Eliminar(_ sender: UIButton){
        dia.BorraLonchera();
        Cancelar(sender);
    }
    
    //Método que establece el fondo de la barra
    func fondoBarra(){
        let frameFondo = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        let ima = UIImage(named: "cancelar");
        let backImg = UIImageView(frame: frameFondo);
        backImg.image=ima;
        self.addSubview(backImg);
        self.sendSubview(toBack: backImg);
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
*/
}
