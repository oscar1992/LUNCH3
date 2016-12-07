//
//  ContenedorProductos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 20/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ContenedorProductos: UIView {
    
    var pestanasA = [PestanasProductos]();
    let barraInformacion = UIView();
    var activo : PestanasProductos?;
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        var c = CGFloat(0);
        //IniciaBarraInformacion();
        
        for _ in 0..<4{
            
            let ancho=CGFloat(self.frame.width/4);
            
            let pestanas=PestanasProductos(frame: CGRectMake((0+(c*(ancho))), (barraInformacion.frame.origin.y+barraInformacion.frame.height), ancho, (DatosC.contenedor.altoP*0.156)), padre: self);
            if(c<4){
                //print("Tipo: ",c);
                pestanas.tipo=(1+Int(c));
            }
            pestanas.padre=self;
            pestanas.Fondo();
            self.addSubview(pestanas.iniSlide().view);
            pestanasA.append(pestanas);
            /*
            let deslizador=VistaPestana();
            pestanas.subVista=deslizador;
            deslizador.view.frame=CGRectMake(0, (self.frame.height*0.2), self.frame.width, self.frame.height*0.8);
            //pestanas.addSubview(deslizador.view);
             */
            c+=1;
            //self.bringSubviewToFront(pestanas);
            self.addSubview(pestanas);
        }
        
            if(DatosC.contenedor.tipo>4){
                pestanasA[0].FondoActivo();
                pestanasA[0].activo=true;
                pestanasA[0].subVista?.view.hidden=false;
            }else{
                for pest in pestanasA{
                    if(DatosC.contenedor.tipo==pest.tipo){
                        pest.FondoActivo();
                        pest.backgroundColor=UIColor.redColor();
                        //print("rojo");
                        pest.activo=true;
                        pest.subVista?.view.hidden=false;
                    }else{
                        pest.activo=false;
                    }
                }
            }
        DatosC.contenedor.Pestanas=pestanasA;
    }
    
    //Método que inicia la bara de la información
    func IniciaBarraInformacion(){
        let frameInformacion = CGRectMake(0, 0, DatosC.contenedor.anchoP, (DatosC.contenedor.altoP*0.04));
        barraInformacion.frame=frameInformacion;
        //barraInformacion.backgroundColor=UIColor.yellowColor();
        var nomb = "";
        for nn in DatosC.contenedor.ninos{
            if(nn.activo == true){
                nomb=nn.nombreNino;
            }
            //print("nn: ", nn.nombreNino, " accc: ", nn.activo);
        }
        let framePestaña = CGRectMake(DatosC.contenedor.anchoP*0.587, (0), DatosC.contenedor.anchoP*0.28, barraInformacion.frame.height);
        let frameLupa = CGRectMake(DatosC.contenedor.anchoP*0.88, 0, DatosC.contenedor.anchoP*0.11, barraInformacion.frame.height);
        
        
        
        let pestaña = UIView(frame: framePestaña);
        let lupa = UIButton(frame: frameLupa);
        let nombre = UILabel(frame: CGRectMake(0,0,framePestaña.width, framePestaña.height));
        fondoPestaña(pestaña);
        fondoLupa(lupa);
        nombre.text=nomb;
        nombre.font=UIFont(name: "SansBeam Head", size: 20);
        nombre.textColor=UIColor.whiteColor();
        nombre.textAlignment=NSTextAlignment.Center;
        
        
        pestaña.addSubview(nombre);
        barraInformacion.addSubview(lupa);
        //pestaña.backgroundColor=UIColor.orangeColor();
        barraInformacion.addSubview(pestaña);
        self.addSubview(barraInformacion);
    }
    //Método que establece el fondo de la pestaña
    func fondoPestaña(pest: UIView){
        let image = UIImage(named: "TabNombre");
        let backImg = UIImageView(frame: CGRectMake(0,0,pest.frame.width, pest.frame.height));
        backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image=image;
        pest.addSubview(backImg);
    }
    
    //Método que establece el fondo de la lupa
    func fondoLupa(lupa: UIView){
        let image = UIImage(named: "TabBuscar");
        let backImg = UIImageView(frame: CGRectMake(0,0,lupa.frame.width, lupa.frame.height));
        backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image=image;
        lupa.addSubview(backImg);

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
