//
//  SubVista.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 14/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class SubVista: UIView {
    
    var campos: Int=4;
    var casillas = [Casilla]();
    var label: UILabel?;
    var tama: CGRect?;
    var padre: UIView?;
    var frameLonchera: CGRect?;
    var backImg : UIImageView?
    var verde = true;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.label=UILabel(frame: CGRectMake(5,5,100,20));
        self.addSubview(label!);
        
        //print("Padre: ", self.superview?.frame)
    }
    
        
    
    func crea(){
        var casillasAux=[ProductoView]();
        var posee=false;
        //print("casillasView: ", self.subviews.count);
        
        for vv in self.subviews{
            vv.removeFromSuperview();
        }
        
        if(self.casillas.isEmpty){
            self.casillas = [Casilla]();
            //print("vacio");
        }else{
            
            for ima in casillas{
                
                if(ima.elemeto != nil){
                    //print("ima: ",ima.elemeto!.producto?.nombre);
                    //print("ima: ", ima.elemeto);
                    casillasAux.append((ima.elemeto)!);
                    ima.elemeto?.removeFromSuperview();
                    //ima.elemeto!.elimina();

                }
            }
            //print("_____", casillasAux.count);
            self.casillas = [Casilla]();
            //print("_____", casillas.count);
            
            posee=true;
        }
        
        
        //print("tt",DatosC.contenedor.tamaLonchera, " posee: ", posee);
        let res = campos % 2;
        let esp = CGFloat(campos/2);
        var espacioA:CGFloat;
        var espacioB=CGFloat(0);
        var espB=CGFloat(0);
        let alto=(self.frame.height/2);
        var bordelateral = DatosC.contenedor.anchoP*0.01;
        
        //print(res," esp ",esp)
        if res==0{
            espacioA = (DatosC.contenedor.tamaLonchera.width/(CGFloat(self.campos)/2));
            //print(espacioA);
            
        }else{
            espacioA = DatosC.contenedor.tamaLonchera.width/(CGFloat(self.campos+res)/2);
            espB=esp+CGFloat(res);
            espacioB = DatosC.contenedor.tamaLonchera.width/(CGFloat(self.campos-res)/2)
        }
        
        var cc=CGFloat(0);
            if(res==0){//Pares
                var tipo=1;
                var f=CGFloat(0);
                //print("ncas: ", campos);
                if(campos >= 6){
                    bordelateral = bordelateral/2;
                    
                }
                for _ in 0..<2{
                    var p=CGFloat(0);
                    for _ in 0..<Int(esp){
                        
                        let casilla=Casilla(frame: CGRectMake((0+((espacioA+bordelateral*2)*p)), (0+((alto+bordelateral)*f)), espacioA, alto));
                        if(DatosC.contenedor.loncheras.count>0){
                        
                        }
                        //print("cawsilla pos:", casilla.frame);
                       /* 
                        let casilla=Casilla(frame: CGRectMake((0+(espacioA*CGFloat(p))),((self.frame.width)),espacioA,self.frame.height));
                        casilla.backgroundColor=UIColor.init(red: 0+(cc*0.4), green: 1, blue: 1, alpha: 1);
                        */
                        
                        //print("Crea");
                        
                        if(tipo<=6){// Max Tipos
                            casilla.tipo=Int(tipo);
                            tipo+=1;
                        }else{
                            
                        }
                        if(posee==true){
                            var imagen: UIImage;
                            if(Int(cc) < casillasAux.count){
                                let prod = casillasAux[Int(cc)].producto;
                                //print("P: ",casillasAux[Int(cc)].producto!.nombre);
                                imagen=prod!.imagen!;
                                let nn=CGRectMake(0, 0, casilla.frame.width, casilla.frame.height);
                                let icono=ProductoView(frame: nn, imagen: imagen);
                                
                                casilla.elemeto=icono;
                                icono.producto=prod;
                                casilla.elemeto!.tipo=prod!.tipo;
                                /*
                                print("dd:", icono);
                                print("cas tipo", casilla.tipo);
                                print("ima: ",imagen);
                                print("", icono.producto)
                                */
                                if (casilla.tipo == nil) {
                                    casilla.tipo = casillas.count;
                                    print("cas: ",casilla.tipo);
                                }
                                casilla.seteaElemento(icono, tipo: casilla.tipo!, ima: imagen, prod: icono.producto!);
                                //casilla.bringSubviewToFront(icono);
                                //casilla.addSubview(icono);
                                casilla.elemeto?.Natural=true;
                                
                            }
                        
                            
                            
                            for _ in DatosC.contenedor.productos{
                                
                                /*for aux in casillasAux{
                                    if(prod.id==aux.producto?.id && casilla.tipo==prod.tipo){
                                        //print("PROD: ",aux.producto?.nombre);
                                        imagen=prod.imagen;
                                        let nn=CGRectMake(0, 0, casilla.frame.width, casilla.frame.height);
                                        let icono=ProductoView(frame: nn, imagen: imagen);
                                        //print("ico: ",icono);
                                        casilla.elemeto=icono;
                                        casilla.elemeto?.tipo=prod.tipo;
                                        icono.producto=prod;
                                        casilla.bringSubviewToFront(icono);
                                        casilla.addSubview(icono);
                                        
                                    }
                                }*/
                            }
                            if(DatosC.contenedor.loncheras[DatosC.contenedor.iActual].saludable == true){
                                casilla.setFondo(true);
                            }else{
                                casilla.setFondo(false);
                            }
                            //casilla.backgroundColor=UIColor.init(red: (0+(cc*0.2)), green: 1, blue: 1, alpha: 0.5);
                            
                            self.addSubview(casilla);
                            casillas.append(casilla);
                        }else{
                            
                            //print("crea_normal");
                            //casilla.backgroundColor=UIColor.init(red: (0+(cc*0.2)), green: 1, blue: (0+(cc*0.2)), alpha: 0.5);
                            if(DatosC.contenedor.loncheras.count>0){
                            if(DatosC.contenedor.loncheras[DatosC.contenedor.iActual].saludable == true){
                                casilla.setFondo(true);
                            }else{
                                casilla.setFondo(false);
                            }
                            }
                            self.addSubview(casilla);
                            casillas.append(casilla);
                        }
                        cc+=1;
                        p+=1;
                    }
                    f+=1;
                }
                
            }else{// Impares
                var tipo=0;
                let f=CGFloat(0);
                var p=CGFloat(0);
                    bordelateral = bordelateral*0.75;
                    for _ in 0..<Int(espB){
                        let framecas=CGRectMake((0+((espacioA+bordelateral*2)*p)), (0+((alto+bordelateral)*f)), espacioA, alto);
                        let casilla=Casilla(frame: framecas);
                        
                        if(tipo<=5){//Max Tipos
                            casilla.tipo=Int(tipo+1);
                            tipo+=1;
                        }else{
                            
                        }
                        if(posee==true){
                            //print("cas: ",casilla.frame);
                            //print("cc: ", cc, "aux: ", casillasAux.count);
                            var imagen: UIImage;
                            if(Int(cc) < casillasAux.count){
                                let prod = casillasAux[Int(cc)].producto;
                                //print("P: ",casillasAux[Int(cc)].producto!.nombre);
                                imagen=prod!.imagen!;
                                
                                let nn=CGRectMake(0, 0, casilla.frame.width, casilla.frame.height);
                                print("ico: ",nn);
                                if (casilla.tipo == nil) {
                                    casilla.tipo = casillas.count;
                                    print("cas: ",casilla.tipo);
                                }
                                let icono=ProductoView(frame: nn, imagen: imagen);
                                //print("ico: ",casilla.tipo);
                                casilla.elemeto=icono;
                                icono.producto=prod;
                                casilla.elemeto?.tipo=prod!.tipo;
                                casilla.bringSubviewToFront(icono);
                                casilla.seteaElemento(icono, tipo: casilla.tipo!, ima: imagen, prod: icono.producto!);
                                casilla.elemeto?.Natural=true;
                                
                            }
                            
                            

                            /*while (bandera){
                                let aux=;
                                p+=1;
                                for prod in DatosC.contenedor.productos{
                                    if(prod.id==aux.producto?.id){
                                        print("AUX: ",aux.producto!.id," || ",prod.id," :PROD");
                                        bandera=false;
                                    }
                                }
                                if(Int(p)>=casillasAux.count){
                                    bandera=false;
                                }
                            }*/
                            
                            /*
                            for prod in DatosC.contenedor.productos{
                                
                                for aux in casillasAux{
                                    
                                    if(prod.id==aux.producto?.id ){
                                        //print("PROD: ",aux.producto?.nombre);
                                        imagen=prod.imagen;
                                        let nn=CGRectMake(0, 0, casilla.frame.width, casilla.frame.height);
                                        let icono=ProductoView(frame: nn, imagen: imagen);
                                        //print("ico: ",casilla.tipo);
                                        casilla.elemeto=icono;
                                        icono.producto=prod;
                                        casilla.elemeto?.tipo=prod.tipo;
                                        casilla.bringSubviewToFront(icono);
                                        casilla.addSubview(icono);
                                    }
                                }
                            }
                            */
                            //casilla.backgroundColor=UIColor.init(red: 1, green: 1, blue: (0+(cc*0.2)), alpha: 1);
                            
                            self.addSubview(casilla);
                            casillas.append(casilla);
                        }else{
                            //print("crea_normal");
                            //casilla.backgroundColor=UIColor.init(red: (0+(cc*0.2)), green: (0+(cc*0.2)), blue: 1, alpha: 1);
                            self.addSubview(casilla);
                            casillas.append(casilla);
                        }
                        
                        if(DatosC.contenedor.loncheras[DatosC.contenedor.iActual].saludable == true){
                            casilla.setFondo(true);
                        }else{
                            casilla.setFondo(false);
                        }
                        cc+=1;
                        p+=1;
                    }
                
                p=0;
                for _ in 0..<Int(esp){
                    let casilla=Casilla(frame: CGRectMake((0+(espacioB+bordelateral*2)*p), (0+(alto+bordelateral)), espacioB, alto));
                    //casilla.backgroundColor=UIColor.init(red: (0+(cc*0.2)), green: 1, blue: 1, alpha: 1);
                    if(tipo<=5){//Max tipos impares
                        casilla.tipo=Int(tipo+1);
                        tipo+=1;
                    }else{
                        
                    }
                    if(posee==true){
                        //print("cas: ",casilla.frame);
                        var imagen: UIImage;
                        if(Int(cc) < casillasAux.count){
                            let prod = casillasAux[Int(cc)].producto;
                            //print("P: ",casillasAux[Int(cc)].producto!.nombre);
                            imagen=prod!.imagen!;
                            let nn=CGRectMake(0, 0, casilla.frame.width, casilla.frame.height);
                            let icono=ProductoView(frame: nn, imagen: imagen);
                            print("ico: ",nn);
                            casilla.elemeto=icono;
                            icono.producto=prod;
                            casilla.elemeto?.tipo=prod!.tipo;
                            casilla.bringSubviewToFront(icono);
                            casilla.seteaElemento(icono, tipo: casilla.tipo!, ima: imagen, prod: icono.producto!);
                            casilla.elemeto?.Natural=true;
                            if(DatosC.contenedor.loncheras[DatosC.contenedor.iActual].saludable == true){
                                casilla.setFondo(casilla.elemeto!.producto!.salud!)
                            }else{
                                casilla.setFondo(false);
                            }
                        }
                        /*
                        for prod in DatosC.contenedor.productos{
                            
                            for aux in casillasAux{
                                if(prod.id==aux.producto?.id){
                                    //print("PROD: ",aux.producto?.nombre);
                                    imagen=prod.imagen;
                                    let nn=CGRectMake(0, 0, casilla.frame.width, casilla.frame.height);
                                    let icono=ProductoView(frame: nn, imagen: imagen);
                                    //print("ico: ",casilla.tipo);
                                    casilla.elemeto=icono;
                                    icono.producto=prod;
                                    casilla.elemeto?.tipo=prod.tipo;
                                    casilla.bringSubviewToFront(icono);
                                    casilla.addSubview(icono);
                                    
                                }
                            }
                        }
                        */
                        //casilla.backgroundColor=UIColor.init(red: 1, green: 1, blue: (0+(cc*0.2)), alpha: 1);
                        if(DatosC.contenedor.loncheras[DatosC.contenedor.iActual].saludable == true){
                            casilla.setFondo(true);
                        }else{
                            casilla.setFondo(false);
                        }
                        
                        self.addSubview(casilla);
                        casillas.append(casilla);
                    }else{
                        //print("crea_normal");
                        //casilla.backgroundColor=UIColor.init(red: 1, green: (0+(cc*0.2)), blue: 1, alpha: 1);
                        self.addSubview(casilla);
                        casillas.append(casilla);
                    }
                    
                    cc+=1;
                    p+=1;
                }
                
            }
        
        //print("Casillas: ",casillas.count);
        setFondo2();
        
    }
    
    func text(){
        label?.text=String(campos);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que establece el fondo de la lonchera
    func setFondo2(){
        //print("se tama. ", self.frame);
        
        for vista in self.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        
        //let OX = -((DatosC.contenedor.tamaLonchera.width*0.3)/2);
        
        //let OY = -((DatosC.contenedor.tamaLonchera.height*0.25)/2);
        
        let ancho = DatosC.contenedor.tamaLonchera.width*1.12;
        let OX = -CGFloat(ancho-self.frame.width)/2;
        let alto = DatosC.contenedor.tamaLonchera.height*1.2;
        let OY = -CGFloat(alto-self.frame.height)/2;
        frameLonchera = CGRectMake(OX, OY, ancho, alto);
        //print("Tama BackLon: ", frameLonchera);
        backImg = UIImageView(frame: frameLonchera!);
        //backImg!.contentMode = UIViewContentMode.ScaleAspectFit;
        
        
        cambiaFondo(self.verde);
        self.addSubview(backImg!);
        self.sendSubviewToBack(backImg!);
    }
    
    //Método qye cambia el tamaño del fondo
    
    /*
    func tamañoFondo(frame: CGRect){
        //print("se tama2. ", self.frame)
        //print("flon: ", frameLonchera!);
        
        
        //let ancho = frame.width*1.3;
        let ancho = frameLonchera!.width*0.6;
        let alto = frameLonchera!.height*0.6;
        
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let OY = CGFloat(0);
        
        //let frameNuevo = CGRectMake(frame.origin.x, 0, frame.width, frame.height);
        let frameNuevo = CGRectMake(OX, OY, ancho, alto);
        for vista in self.subviews{
            if vista is UIImageView{
                let vv = vista as! UIImageView;
                //vv.frame = frameLonchera!;
                vv.frame = frameNuevo;
                //print("vv: ", vv.frame);
            }
        }
        
    }
    */

    // Método que cambia entre os dos fondos dependeindo del parámetro
    
    func cambiaFondo(verde: Bool){
        self.verde=verde;
        let fondo: UIImage?;
        if(verde){
            fondo = UIImage(named: "LoncheraVerde");
        }else{
            fondo = UIImage(named: "LoncheraBlanca");
        }
        //backImg!.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg!.image = fondo;
        self.sendSubviewToBack(backImg!);
    }
    
    //Método que pone un fondo de colres la primera vez que se elige una lonchera predeterminada
    func fondoColores(ncolor: Int){
        

        let fondo: UIImage?;
        switch ncolor {
        case 1:
            fondo = UIImage(named: "LoncheraVerde");
            break;
        case 2:
            fondo = UIImage(named: "LoncheraRoja");
            break;
        case -2:
            fondo = UIImage(named: "LoncheraAzul");
            break;
        case 3:
            fondo = UIImage(named: "LoncheraAmarilla");
            break;
        default:
            fondo = UIImage(named: "LoncheraRoja");
            break;
        }
        CasillasColores(ncolor);
        //backImg!.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg!.image = fondo;
        self.sendSubviewToBack(backImg!);
    }
    
    //Método que pone los colores de las casillas la primera vez
    func CasillasColores(ncolor: Int){
        let lonc = DatosC.contenedor.lonchera;
        
            for cas in (lonc.subVista?.casillas)!{
                for vista in cas.subviews{
                    if vista is UIImageView{
                        vista.removeFromSuperview();
                    }
                }
                
                var imagen: UIImage;
                switch  ncolor {
                case 1:
                    imagen = UIImage(named: "CasillaVerde")!;
                    break;
                case 2:
                    imagen = UIImage(named: "CasillaRoja")!;
                    break;
                case -2:
                    imagen = UIImage(named: "CasillaAzul")!;
                    break;
                case 3:
                    imagen = UIImage(named: "CasillaAmarilla")!;
                    break;
                default:
                    imagen = UIImage(named: "CasillaVerde")!;
                    break;
                }
                
                let frame = CGRectMake(0, 0, cas.frame.width, cas.frame.height);
                let backImg = UIImageView(frame: frame);
                //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
                backImg.image = imagen;
                cas.addSubview(backImg);
                cas.sendSubviewToBack(backImg);
            }
        
    }

}
