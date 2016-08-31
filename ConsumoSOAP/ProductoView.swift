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
    //var imagenInterna:UIImage?;
    
    var espacioPadre:CGRect!;
    var Panel2:UIView?; //BASE
    var PanelOrigen:UIView?; //BASE
    var bloquea = false;
    var casillaF:CGRect?;
    var posA:CGRect?;
    var espacio:UIView?; //BASE
    var producto:Producto?;
    var Natural:Bool?;
    var casillasF = [CGRect]();
    var cc : CGRect?;
    var copiaExito: Bool = false;
    
    var timer : NSTimer!;
    var bloqueo2 = false;
    var bloqueo3 = false;
    var timer2 : NSTimer!;
    var timer3 : NSTimer!;
    var moviendo = false;
    
    var bloqueo4 = false;
    var bloqueo5 = false;
    
    var ultToque : UITouch!;
    var acumula : CGPoint?;
    
    required init(frame: CGRect, imagen:UIImage) {
        super.init(frame: frame);
        //self.imagenInterna=imagen;
        let panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(ProductoView.detectPan(_:)));
        self.gestureRecognizers=[panRecognizer];
        let vista=UIImageView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height));
        //print("bloq2: ", bloqueo2);
        vista.image=imagen;
        vista.contentMode=UIViewContentMode.ScaleAspectFit;
        self.addSubview(vista);
        //self.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.0);
        ultimaPosicion=self.center;
        bloqueo2=false;
        bloqueo5=false;
        espacioPadre=self.frame;
        bloquea=false;
        Natural=true;
        acumula = CGPointZero;
        
        //print("tt: ",vista.frame.width," ee: ",vista.image);
        
    }
    /*
    func redibuja(tama: CGRect){
        self.frame=tama;
        
    }
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer: UIPanGestureRecognizer){
        
        //importante cancelar los delays y los cancels para efecto inmediato de las funciones de soltar y de arrastrar
        recognizer.delaysTouchesEnded=false;
        recognizer.cancelsTouchesInView=false;
        let translation=recognizer.translationInView(self.superview);
        if(bloqueo2==true){
            //print("Bloqq: ",bloqueo2);
            
            
            self.center = CGPointMake(ultimaPosicion.x+translation.x, ultimaPosicion.y+translation.y);
        }else{
            
            //retornaCasilla(padre!);
            self.center=ultimaPosicion;
        }
        //ultimaPosicion=self.center;
    }
    
    /*
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        /*
        var vistaToque = self.superview!.hitTest(point, withEvent: event);
        print("VVV: ", vistaToque);
        if(vistaToque == self){
            vistaToque =  nil;
        }
        return vistaToque;
 */
        //timer2 = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(ProductoView.evaMov), userInfo: nil, repeats: false);
        //evaMov();
        print("bloq3: ", bloqueo3);
        if (bloqueo3){
            return self;
        }else{
            return self.superview;
        }
    }
    */
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        ultToque = touches.first;
        evaMov();
        timer3 = NSTimer.scheduledTimerWithTimeInterval(0.09, target: self, selector: #selector(evaMov3), userInfo: nil, repeats: false);
        if(Panel2==nil && PanelOrigen==nil){ // Entra el touch en el panel Normal
            
            ultimaPosicion=self.center;
            print("ult: ", ultimaPosicion);
            self.superview?.superview!.superview!.superview!.bringSubviewToFront(self);
            //print("Normal");
            //padre=self.superview;
        }else{
            ultimaPosicion=self.center;
            print("pos: ", touches.first?.locationInView(espacio));
            eva4();
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ProductoView.informacion), userInfo: nil, repeats: false);
            cc = convertRect(padre!.frame, toView: espacio!);
            var sigue = true;
            var superP = self.superview;
            /*
            while sigue {
                if(superP != nil){
                    //print("pp: ", superP);
                    superP?.bringSubviewToFront(self);
                    superP = superP!.superview;
                }else{
                    sigue = false;
                }
                
            }
            */
            self.layer.zPosition=1;
        }
        
        //print(ultimaPosicion);
        //padre=self.superview;
        //print("padre",padre)
        //VistaGeneral?.view.addSubview(self);
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        acumula!.x = abs(ultimaPosicion.x-self.center.x);
        acumula!.y = abs(ultimaPosicion.y-self.center.y);
        //print("acu: ", acumula);
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //timer2 = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(ProductoView.evaMov2), userInfo: nil, repeats: false);
        evaMov2();
        moviendo = false;
        print("sale????")
        let objetivo = DatosC.contenedor.pantallaSV.casillaBaja;
        var copia : ProductoView?;
        
        if(Panel2==nil && PanelOrigen==nil){        // Sale del touch normal
            print("Sale normal");
            
            if(CGRectContainsPoint(espacioPadre, self.center)){
                print("punto: ", self.center, tipo);
                print("Esta adentro", espacioPadre, self.center);
                if(self.center==CGPoint(x: espacioPadre.width/2, y: espacioPadre.height/2)){
                    if(self.tipo != nil){ // Paso a la alacena
                        print("eeeeee", self.tipo)
                        if(bloqueo2){
                            print("bloqueado");
                        }else{
                            print("NO bloqueado");
                        }
                        //
                    }else{
                        print("oooooo: ");
                        self.center=ultimaPosicion;
                    }
                }
                self.center=ultimaPosicion;
            }else{
                if(bloqueo5==true){
                    elimina();
                    padre?.activo=true;
                }else{
                    //if(DatosC.contenedor.pantallaSV.contenedor.barraBusqueda != nil){
                    
                        
                    //}
                }
                print("elimina?");
                DatosC.contenedor.lonchera.contador?.actua();
            }
        }else{
            
            if(padre != nil){
                copia = ProductoView(frame: padre!.frame, imagen: (padre?.elemeto!.producto!.imagen)!);
                copia!.tipo=self.tipo;
                copia!.producto=self.producto;
                copia!.producto?.imagen=self.producto!
                    .imagen;
                copia!.padre=self.padre;
            }
             //Sale del touch en la selección de ítems
           //print("Sale SV");
            self.center=CGPoint(x: (self.center.x), y: (self.center.y-(padre!.frame.origin.y+espacio!.frame.origin.y+cc!.origin.y-50)));
            let centroNatural=touches.first?.locationInView(espacio);
            if(CGRectContainsPoint(espacioPadre, self.center)){
                
                //retornaCasilla(padre!);
                //print("retorna");
            }else{
              
                let no=CGRectMake((objetivo.frame.origin.x), ((objetivo.frame.origin.y+DatosC.contenedor.pantallaSV.espacioIntercambio.frame.origin.y+(DatosC.contenedor.pantallaSV.LaBarra.frame.height+DatosC.contenedor.pantallaSV.LaBarra.frame.origin.y))), objetivo.frame.width, objetivo.frame.height);
                //print("centro ima: ", centroNatural);
                //print("Objetivo: ", objetivo.frame)
                if(CGRectContainsPoint(no , centroNatural!)){
                    copiaExito=true;
                    
                }
                
                
            }
            if(copiaExito == true && copia!.producto != nil){
                self.frame = CGRectMake((objetivo.frame.width/2)-(self.frame.width/2), 0, objetivo.frame.width, objetivo.frame.height);
                //print("---------x^x---------");
                objetivo.seteaElemento(self, tipo: self.tipo!, ima: self.producto!.imagen, prod: self.producto!);
                copia!.frame=CGRectMake(0, 0, padre!.frame.width, padre!.frame.height);
                padre!.addSubview(copia!);
                /*
                 print("ctipo", copia.tipo);
                 print("cima", copia.producto?.imagen);
                 print("cprod", copia.producto);
                 
                 //padre?.seteaElemento(copia, tipo: copia.tipo!, ima: copia.producto!.imagen, prod: copia.producto!);
 
                print("---------x.x---------");
                print("ele: ", objetivo.elemeto?.producto?.nombre);
                print("tipo: ",DatosC.contenedor.tipo);
                print("qq", DatosC.contenedor.lonchera.id);
                 */
            }else{
                //print("retorna: ", padre);
                retornaCasilla(padre!);
                
            }
            
            //self.removeFromSuperview();
        }
        
        cierraAlacena(copiaExito);
        //print("ultimo padre:", self.superview);
        
    }
    
    func elimina(){
        if(padre != nil){
            padre!.elemeto = nil;
        }
        self.removeFromSuperview();
        
    }
    
    func panelElementos(tipo: Int){
        //print("toca");
        if(Natural==true){
        //print("pasa>?", Natural);
            //DatosC.contenedor.lonchera=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
            /*
            let loncheraActual=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
            for cass in (loncheraActual.subVista?.casillas)!{
                print("ca: ", cass.elemeto?.producto?.nombre);
            }
            print("LA: ",loncheraActual.subVista?.casillas.count);
            */
            //print("Origen Padre: ", self.padre?.lonchera);
            //print("Origen: ", self.padre?.lonchera.id);
            for BotNino in DatosC.contenedor.ninos{
                if(BotNino.activo == true){
                    //print("iact: ", DatosC.contenedor.iActual);
                    //print("lons: ", BotNino.loncheras.count);
                    if(BotNino.loncheras.count == 0){
                        BotNino.loncheras = DatosC.contenedor.loncheras;
                    }
                    DatosC.contenedor.lonchera = BotNino.loncheras[DatosC.contenedor.iActual];
                    //print("Cambia: ");
                }
                
            }
            //DatosC.contenedor.lonchera=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
            
            for _ in DatosC.contenedor.loncheras{
                //print("Posi: ", ll.id);
            }
            
        let posi=convertRect((self.superview!.frame), toView: DatosC.contenedor.Pantallap.view);
            //print("Posi: ",posi);
            DatosC.contenedor.casillaF=posi;
            DatosC.contenedor.tipo=tipo;
            //DatosC.contenedor.lonchera=DatosC.contenedor.loncheras[DatosC.contenedor.iActual];
            for cs in (DatosC.contenedor.lonchera.subVista?.casillas)!{
                cs.elemeto?.Natural=false;
            }
            DatosC.contenedor.Pantallap.performSegueWithIdentifier("Seleccion", sender: nil);
        }
    }
    
    // Método que copia una vista a la casilla donde se origino la actual
    func copiaCasilla(casi: Casilla){
        /*
        print("self: ", self);
        print("self tipo: ", self.tipo);
        print("self imagen: ", self.producto?.imagen);
        print("self producto: ", self.producto);
        */
        //print("pad: ", casi);
        let prodV = self;
        let tipo = self.tipo;
        let ima = self.producto!.imagen;
        let prod = self.producto;
        casi.seteaElemento(prodV, tipo: tipo!, ima: ima, prod: prod!);
        casi.backgroundColor=UIColor.redColor();
        copiaExito = false;
        
    }
    //Método que permite devolver un vista soltada sin objetivo a su casilla original
    func retornaCasilla(casi: Casilla){
        //self.tipo = 0;
        //casi.backgroundColor = UIColor.redColor();
        //print("devuelve: ",casi);
        self.frame = CGRectMake(0, 0, casi.frame.width, casi.frame.height);
        //copiaCasilla(casi);
        casi.addSubview(self);
        //self.removeFromSuperview();
    }
    
    //Este método es llamado para mostrar la informaciñon de un prtoducto
    func informacion(){
        /*
        print("INFO?: ", moviendo);
        print("BLOQUEO4: ", bloqueo4);
        print("toque fase: ", ultToque.phase.rawValue);
        */
        //print("self: ", self.superview);
        //print("ded: ", ultToque.locationInView(padre));
        print("acumula: ", acumula);
        var mov = false;
        if((acumula!.x < 15 && acumula!.y < 15)){
            print("adentro");
            mov = true;
            
        }
        if(bloqueo4 == true && ultToque.phase.rawValue==2 && mov == true){
            print("Muestra: ", DatosC.contenedor.pantallaSV);
            DatosC.contenedor.pantallaSV.iniciaPanelInfo(self.producto!);
        }
        //bloqueo4 = false;
    }
    
    //Método que se ejecuta al final de la seleción de un producto y evalua si se cierra o no la alacena
    func cierraAlacena(pasa: Bool){
        
        if(pasa){
            //print("iAct: ", DatosC.contenedor.iActual);
            print("QQ: ", DatosC.contenedor.lonchera.fechaVisible?.text);
            for cas in (DatosC.contenedor.lonchera.subVista?.casillas)!{
                //print("cas: ", cas.tipo, " cont: ", DatosC.contenedor.tipo);
                if (cas.tipo == DatosC.contenedor.tipo){
                    let cc = copiarse();
                    
                    cc.frame = CGRectMake(0, 0, cas.frame.width, cas.frame.height);
                    cas.addSubview(cc);
                    cas.elemeto=cc;
                    print("cas: ", cas.elemeto?.producto?.nombre);
                }
            }
            
            DatosC.contenedor.lonchera.color = nil;
            DatosC.contenedor.lonchera.contador?.actua(); 
            DatosC.contenedor.pantallaSV.actuaLonch(true);
            
        }else{
            
        }
    }
    
    //Mètodo que permite hacer una copia de si mismo
    func copiarse()->ProductoView{
        
        var copia :ProductoView;
        copia = ProductoView(frame: padre!.frame, imagen: (padre?.elemeto!.producto!.imagen)!);
        copia.tipo=self.tipo;
        copia.producto=self.producto;
        copia.producto?.imagen=self.producto!.imagen;
        copia.padre=self.padre;
        //print("Copia: ", copia);
        return copia;
    }
    
    //Método que evaluará si se aplica movimiento
    func evaMov(){
        //print("bloquea: ", ultimaPosicion);
        //print("Actual: ", self.center);
        bloqueo3 = true;
        //print("Toca: ", bloqueo3);
    }
    
    //Método que evaluará si se aplica movimiento
    func evaMov2(){
        //print("bloquea: ", ultimaPosicion);
        //print("Actual: ", self.center);
        bloqueo2 = false;
        self.userInteractionEnabled=true;
        //self.hidden=false;
        //print("Suelta: ", bloqueo2);
    }
    
    //Método que evaluará si se aplica movimiento
    func evaMov3(){
        //print("eva 3: ", ultToque);
        
        if(CGRectContainsPoint(self.frame, ultToque.locationInView(self)) ){
            if(ultToque.phase.rawValue==2){
                print("Mueve");
                bloqueo2 = true;
                bloqueo5 = true;
                self.center=ultimaPosicion;
            }else if(ultToque.phase.rawValue==3){
                print("Panel");
                bloqueo2=false;
                if(DatosC.contenedor.pantallaSV.contenedor != nil){
                    DatosC.contenedor.pantallaSV.contenedor.cierraBusqueda(self);
                }
                
                if(Panel2 == nil && PanelOrigen == nil){
                    //if(ultToque.phase.rawValue==2){
                        print("Pasa");
                        panelElementos(self.padre!.tipo!);
                    //}else{
                        
                        print("Retorna");
                        self.center=CGPoint(x: padre!.frame.width/2, y: padre!.frame.height/2);
                    //}
                }
            }
            //print("Adentro: ", ultToque.phase.rawValue);
            //bloqueo5 = false;
            
        }else if(Panel2==nil && PanelOrigen==nil){
            //self.hidden=true;
            
            let posR = ultToque.locationInView(self.superview).x - self.center.x;
            /*
            print("Ultima: ", ultToque.locationInView(self.superview));
            print("Centro: ", self.center);
            print("afuera: ", posR);
            */
            let des = DatosC.contenedor.ninoActual?.Lonchera.deslizador;
            
          
                print("Des: ", des);
                
                if (posR > 0){
                    //print("Desplaza Izquierda");
                    des?.rotaLonc(DatosC.contenedor.iActual, siguiente: false);
                }else{
                    //print("Desplaza Derecha");
                    des?.rotaLonc(DatosC.contenedor.iActual, siguiente: true);
                    
                }
            
            
            self.center=CGPoint(x: padre!.frame.width/2, y: padre!.frame.height/2);
            //self.userInteractionEnabled=false;
        }else{
            //print("bloq2: ", bloqueo2);
            //bloqueo2 = true;
            let posR = ultToque.locationInView(self.superview?.superview).x - ultimaPosicion.x ;
            var pags : VistaPestana!;
            
            for pest in DatosC.contenedor.pantallaSV.contenedor.pestanasA{
                if(pest.activo == true){
                    pags = pest.subVista;
                }
            }
            print("ultoque: ",ultToque.locationInView(self.superview?.superview).x)
            print("ultpos: ", ultimaPosicion.x);
            print("Rota ala: ", posR);
            if(posR > 0){
                pags.rotaPestaña(false);
            }else{
                pags.rotaPestaña(true);
            }
        }
        /*
        print("Sigue pres1: ", bloqueo2);
        print("Sigue pres2: ", bloqueo3);
        */
    }
    
    //Método que evalua si se debe mostrar la información del producto
    func eva4(){
        bloqueo4=true;
    }

    
    /*
    // Método que calcula la posición inicial del la imagen relativa a su origen de la casilla desplegable
    func posInicial(){
        var haypadre = true;
        var padre = self.superview;
        while(haypadre){
            
            if(padre == nil){
                haypadre = false;
            }else if padre is ContenedorProductos{
                print("UUU: ", padre);
                haypadre = false;
            }else{
                padre = padre?.superview;
            }
            print("Padre Actual: ",padre);
        }
        
        print("Padre: ",padre, "centro ", self.center);
    }
 
 */
   
}