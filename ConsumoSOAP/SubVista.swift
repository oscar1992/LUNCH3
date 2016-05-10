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
        
        if(casillas.isEmpty){
            casillas = [Casilla]();
        }else{
            
            for ima in casillas{
                //print("ima: ",ima.elemeto?.producto?.nombre);
                if(ima.elemeto != nil){
                    casillasAux.append((ima.elemeto)!);
                    ima.elemeto?.removeFromSuperview();
                    //ima.elemeto!.elimina();

                }
                            }
            //print("_____", casillasAux.count);
            casillas = [Casilla]();
            //print("_____", casillas.count);
            
            posee=true;
        }
        
        
        //print("tt",DatosC.contenedor.tamaLonchera);
        let res = campos % 2;
        let esp = CGFloat(campos/2);
        var espacioA:CGFloat;
        var espacioB=CGFloat(0);
        var espB=CGFloat(0);
        let alto=(self.frame.height/2);
        
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
                for _ in 0..<2{
                    var p=CGFloat(0);
                    for _ in 0..<Int(esp){
                        
                        let casilla=Casilla(frame: CGRectMake((0+(espacioA*p)), (0+(alto*f)), espacioA, alto));
                        
                        //print("cawsilla pos:", casilla.frame);
                       /* 
                        let casilla=Casilla(frame: CGRectMake((0+(espacioA*CGFloat(p))),((self.frame.width)),espacioA,self.frame.height));
                        casilla.backgroundColor=UIColor.init(red: 0+(cc*0.4), green: 1, blue: 1, alpha: 1);
                        */
                        
                        //print("Crea");
                        
                        if(tipo<=4){// Max Tipos
                            casilla.tipo=Int(tipo);
                            tipo+=1;
                        }else{
                            
                        }
                        if(posee==true){
                            var imagen: UIImage;
                            if(Int(cc) < casillasAux.count){
                                let prod = casillasAux[Int(cc)].producto;
                                //print("P: ",casillasAux[Int(cc)].producto!.nombre);
                                imagen=prod!.imagen;
                                let nn=CGRectMake(0, 0, casilla.frame.width, casilla.frame.height);
                                let icono=ProductoView(frame: nn, imagen: imagen);
                                //print("ico: ",casilla.tipo);
                                casilla.elemeto=icono;
                                icono.producto=prod;
                                casilla.elemeto?.tipo=prod!.tipo;
                                casilla.bringSubviewToFront(icono);
                                casilla.addSubview(icono);
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
                            casilla.backgroundColor=UIColor.init(red: (0+(cc*0.2)), green: 1, blue: 1, alpha: 1);
                            self.addSubview(casilla);
                            casillas.append(casilla);
                        }else{
                            //print("crea_normal");
                            casilla.backgroundColor=UIColor.init(red: (0+(cc*0.2)), green: 1, blue: (0+(cc*0.2)), alpha: 1);
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
                    for _ in 0..<Int(espB){
                        let framecas=CGRectMake((0+(espacioA*p)), (0+(alto*f)), espacioA, alto);
                        let casilla=Casilla(frame: framecas);
                        
                        if(tipo<=4){//Max Tipos
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
                                imagen=prod!.imagen;
                                let nn=CGRectMake(0, 0, casilla.frame.width, casilla.frame.height);
                                let icono=ProductoView(frame: nn, imagen: imagen);
                                //print("ico: ",casilla.tipo);
                                casilla.elemeto=icono;
                                icono.producto=prod;
                                casilla.elemeto?.tipo=prod!.tipo;
                                casilla.bringSubviewToFront(icono);
                                casilla.addSubview(icono);
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
                            casilla.backgroundColor=UIColor.init(red: 1, green: 1, blue: (0+(cc*0.2)), alpha: 1);
                            self.addSubview(casilla);
                            casillas.append(casilla);
                        }else{
                            //print("crea_normal");
                            casilla.backgroundColor=UIColor.init(red: (0+(cc*0.2)), green: (0+(cc*0.2)), blue: 1, alpha: 1);
                            self.addSubview(casilla);
                            casillas.append(casilla);
                        }
                        
                        
                        cc+=1;
                        p+=1;
                    }
                
                p=0;
                for _ in 0..<Int(esp){
                    let casilla=Casilla(frame: CGRectMake((0+(espacioB*p)), (0+(alto)), espacioB, alto));
                    casilla.backgroundColor=UIColor.init(red: (0+(cc*0.2)), green: 1, blue: 1, alpha: 1);
                    if(tipo<=4){//Max tipos impares
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
                            imagen=prod!.imagen;
                            let nn=CGRectMake(0, 0, casilla.frame.width, casilla.frame.height);
                            let icono=ProductoView(frame: nn, imagen: imagen);
                            //print("ico: ",casilla.tipo);
                            casilla.elemeto=icono;
                            icono.producto=prod;
                            casilla.elemeto?.tipo=prod!.tipo;
                            casilla.bringSubviewToFront(icono);
                            casilla.addSubview(icono);
                            casilla.elemeto?.Natural=true;
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
                        casilla.backgroundColor=UIColor.init(red: 1, green: 1, blue: (0+(cc*0.2)), alpha: 1);
                        self.addSubview(casilla);
                        casillas.append(casilla);
                    }else{
                        //print("crea_normal");
                        casilla.backgroundColor=UIColor.init(red: 1, green: (0+(cc*0.2)), blue: 1, alpha: 1);
                        self.addSubview(casilla);
                        casillas.append(casilla);
                    }
                    
                    cc+=1;
                    p+=1;
                }
                
            }
        
        //print("Casillas: ",casillas.count);
        
    }
    
    func text(){
        label?.text=String(campos);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
