//
//  ProductoView.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 1/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ProductoView: UIButton {
    
    var ultimaPosicion:CGPoint=CGPointMake(0,0);
    //var imagen:UIImage!;
    var VistaGeneral:ViewController?;
    var padre:Casilla?; //BASE
    var tipo:Int?;
    var imagen: UIImageView?;
    
    var espacioPadre:CGRect!;
    var Panel2:UIView?; //BASE
    var PanelOrigen:UIView?; //BASE
    var bloquea:Bool?;
    var casillaF:CGRect?;
    var posA:CGRect?;
    var espacio:UIView?; //BASE
    var producto:Producto?;
    var Natural:Bool?;
    var casillasF = [CGRect]();
    
    
    required init(frame: CGRect, imagen:UIImage) {
        super.init(frame: frame);
        let panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(ProductoView.detectPan(_:)));
        self.gestureRecognizers=[panRecognizer];
        let vista=UIImageView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height));
        
        vista.image=imagen;
        vista.contentMode=UIViewContentMode.ScaleAspectFit;
        self.addSubview(vista);
        self.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.0);
        ultimaPosicion=self.center;
        
        espacioPadre=self.frame;
        bloquea=false;
        Natural=true;
        
        
        //print("tt: ",vista.frame.width," ee: ",vista.image);
        
    }
    
    func redibuja(tama: CGRect){
        self.frame=tama;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer: UIPanGestureRecognizer){
        recognizer.delaysTouchesEnded=false;
        //importante cancelar los delays y los cancels para efecto inmediato de las funciones de soltar y de arrastrar
        recognizer.cancelsTouchesInView=false;
        var translation=recognizer.translationInView(self.superview);
        //print("translation: ", translation);
        if(padre != nil){
            if(Panel2==nil && PanelOrigen==nil){
                //translation=CGPoint(x: (translation.x+padre!.frame.origin.x), y: (translation.y+padre!.frame.origin.y));
            }else{
                
                let add = padre!.frame.origin.y+(self.frame.height/2);
                translation=CGPoint(x: (translation.x+padre!.frame.origin.x), y: (translation.y+add));
            }
            
        }
        //print("Trans: ",translation);

        self.center = CGPointMake(ultimaPosicion.x+translation.x, ultimaPosicion.y+translation.y);
        //ultimaPosicion=self.center;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //ultimaPosicion=self.center;
       
        if(Panel2==nil && PanelOrigen==nil){ // Entra el touch en el panel Normal
            
            self.superview?.superview!.superview!.superview!.bringSubviewToFront(self);
            //print("Normal");
            //padre=self.superview;
        }else{                              // Entra el touch en el panel de Selección
            //print("Por Panel");
            //let rr=convertRect((casillaF)!, toView: Panel2);
            //print("add: ",padre!.frame.origin.y);
            let cc = convertRect(padre!.frame, toView: espacio!);
            //print("cov :", cc);
            self.center=CGPoint(x: (self.center.x+(padre!.frame.origin.x+padre!.superview!.frame.origin.x)), y: (cc.origin.y+(self.frame.height/2)));
            //padre=self.superview as! Casilla;
            espacio!.addSubview(self);
            espacio!.bringSubviewToFront(self);
            espacio!.bringSubviewToFront(espacio!);
            //print(espacio);
            
            //posA=casillaF;
            //posA=CGRectMake(casillaF!.origin.x, (casillaF!.origin.y+(DatosC.contenedor.altoP*0.5)), casillaF!.width, (casillaF!.height+40));
            //posA=convertRect(posA!, toCoordinateSpace: UIScreen.mainScreen().coordinateSpace);
            //PanelOrigen?.bringSubviewToFront(self.superview!);
            
            //print("caass",posA);
            //self.superview?.bringSubviewToFront(self);
            
        }
        
        //print(ultimaPosicion);
        //padre=self.superview;
        //print("padre",padre)
        //VistaGeneral?.view.addSubview(self);
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        if(Panel2==nil && PanelOrigen==nil){
            //print("movi",self.center);
        }else{
            
            //print("select: ",self.center);
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print("Toca????")
        if(Panel2==nil && PanelOrigen==nil){        // Sale del touch normal
            //print("Sale normal");
            
            if(CGRectContainsPoint(espacioPadre, self.center)){
                //print("punto: ", self.center, tipo);
                //print("Esta adentro", espacioPadre, self.center);
                if(self.center==CGPoint(x: espacioPadre.width/2, y: espacioPadre.height/2)){
                    if(self.tipo != nil){
                        //print("eeeeee")

                        panelElementos(self.tipo!);
                    }else{
                        //print("oooooo")
                        self.center=ultimaPosicion;
                    }
                }
                self.center=ultimaPosicion;
            }else{
                elimina();
                
            }
        }else{                                      // Sale del touch en la selección de ítems
            //PanelOrigen?.addSubview(self);
            
            //padre?.addSubview(self);
            //DatosC.contenedor.pantallaSV.Lonchera.addSubview(self);
            //self.center=convertPoint(self.center, toView: espacio);
            let centroNatural=self.center;
            self.center=CGPoint(x: (self.center.x-padre!.frame.origin.x), y: (self.center.y-padre!.frame.origin.y));
            if(CGRectContainsPoint(espacioPadre, self.center)){
                self.center=ultimaPosicion;
            }else{
                
                //print("última pos: ", centroNatural);
                //print("casilla ",posA);
                //print("Panel2: ",Panel2?.frame);
                //print("Origen: ",DatosC.contenedor.pantallaSV.Lonchera.frame);
                
                
                self.center=ultimaPosicion
                //print("referencia: ", DatosC.contenedor.pantallaSV.Lonchera.frame);
                //let panelLegada=DatosC.contenedor.pantallaSV;
                
                var flag=true;
                var i=0;
                
                while(flag){
                    
                    let cassF=DatosC.lonchera.subVista?.casillas[i];
                    //print("-----------------------------------------------------------------------");
                    //print("Elemento: ",cassF!.elemeto?.producto?.nombre);
                    i+=1;
                    if(i>=DatosC.contenedor.casillasF.count){
                        flag=false;
                    }
                    let no=CGRectMake(cassF!.frame.origin.x, (cassF!.frame.origin.y+DatosC.contenedor.pantallaSV.Lonchera.frame.origin.y), cassF!.frame.width, cassF!.frame.height);
                        //print("CASS: ",cassF!.frame," || ",no);
                    if(CGRectContainsPoint(no, centroNatural)){
                        cassF!.elemeto?.removeFromSuperview();
                        cassF!.elemeto=self;
                        DatosC.contenedor.pantallaSV.actuaLonch(false);
                        //print("Dentro!! ", cassF!.elemeto?.producto?.nombre);
                        flag=false;
                        //break;
                    }else{
                        //print("fuera");
                    }
                    //elimina();
                }
                
                /*
                for cassF in DatosC.contenedor.casillasF{
                    print("-----------------------------------------------------------------------");
                    print("Elemento: ",cassF.elemeto?.producto?.nombre);
                    let no=CGRectMake(cassF.frame.origin.x, (cassF.frame.origin.y+DatosC.contenedor.pantallaSV.Lonchera.frame.origin.y), cassF.frame.width, cassF.frame.height);
                    print("CASS: ",cassF.frame," || ",no);
                    if(CGRectContainsPoint(no, centroNatural)){
                        cassF.elemeto?.removeFromSuperview();
                        cassF.elemeto=self;
                        DatosC.contenedor.pantallaSV.actuaLonch(false);
                        print("Dentro!! ", cassF.elemeto?.producto?.nombre);

                        //break;
                    }else{
                        print("fuera");
                    }
                    print("sale");
                    elimina();
                    casillasF.append(no);
                }
                */
                
            }
        }
        
        
        
        DatosC.lonchera.contador?.actua();

        
        //print(self.superview?.superview);
    }
    
    func elimina(){
        
        //self.padre?.elemeto=nil;
        //print("ID: ",self.producto!.id);
        let lonch=DatosC.lonchera.subVista!.casillas
        /*
        for ele in DatosC.lonchera.subVista!.casillas{
            print("PRODUTO: ",ele.elemeto?.producto?.id);
        }
         */
        for cas in lonch{
            //print("cas: ",cas);
            //print("ele: ",cas.elemeto?.producto?.nombre);
            if(cas.elemeto?.producto?.id==self.producto?.id && cas.elemeto?.tipo == self.tipo){
                //print("QUIEN: ",cas.elemeto?.padre?.tipo);
                cas.elemeto?.producto=nil;
                cas.elemeto=nil;
                /*
                for vista in cas.subviews{
                    print("contiene: ",vista)
                }
                 */
                cas.elemeto?.removeFromSuperview();
                //print("actua");
                
            }
        }
        DatosC.lonchera.subVista!.casillas=lonch;
        for _ in DatosC.lonchera.subVista!.casillas{
            //print("cass: ",cas.elemeto?.producto?.nombre);
            /*
            for vista in cas.subviews{
                //print("contiene: ",vista);
            }
            */
        }
        //self.frame=CGRectZero;
        self.removeFromSuperview();
        
    }
    
    func panelElementos(tipo: Int){
        if(Natural==true){
        //print("pasa>?");
            //DatosC.contenedor.lonchera=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
            /*
            let loncheraActual=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
            for cass in (loncheraActual.subVista?.casillas)!{
                print("ca: ", cass.elemeto?.producto?.nombre);
            }
            print("LA: ",loncheraActual.subVista?.casillas.count);
            */
        let posi=convertRect((self.superview?.frame)!, toView: DatosC.contenedor.PantallaP.view);
            //print("Posi: ",posi);
            DatosC.contenedor.casillaF=posi;
            DatosC.contenedor.tipo=tipo;
            for cs in (DatosC.lonchera.subVista?.casillas)!{
                cs.elemeto?.Natural=false;
            }
            DatosC.contenedor.PantallaP.performSegueWithIdentifier("Seleccion", sender: nil);
        }
    }
    
   
}