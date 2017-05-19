//
//  ProductoView.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 1/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class ProductoView: UIButton {
    
    var ultimaPosicion:CGPoint=CGPoint(x: 0,y: 0);
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
    
    var timer : Timer!;
    var bloqueo2 = false;
    var bloqueo3 = false;
    var timer2 : Timer!;
    var timer3 : Timer!;
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
        let vista=UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height));
        //print("bloq2: ", bloqueo2);
        vista.image=imagen;
        vista.contentMode=UIViewContentMode.scaleAspectFit;
        //print("imagen: ", vista.image);
        self.addSubview(vista);
        self.bringSubview(toFront: vista);
        //self.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.0);
        ultimaPosicion=self.center;
        bloqueo2=false;
        bloqueo5=false;
        espacioPadre=self.frame;
        bloquea=false;
        Natural=true;
        acumula = CGPoint.zero;
        
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
    
    func detectPan(_ recognizer: UIPanGestureRecognizer){
        
        //importante cancelar los delays y los cancels para efecto inmediato de las funciones de soltar y de arrastrar
        recognizer.delaysTouchesEnded=false;
        recognizer.cancelsTouchesInView=false;
        let translation=recognizer.translation(in: self.superview);
        if(bloqueo2==true){
            //print("Bloqq: ",bloqueo2);
            
            
            self.center = CGPoint(x: ultimaPosicion.x+translation.x, y: ultimaPosicion.y+translation.y);
        }else{
            
            //retornaCasilla(padre!);
            self.center=ultimaPosicion;
        }
        self.center = CGPoint(x: ultimaPosicion.x+translation.x, y: ultimaPosicion.y+translation.y);
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        ultToque = touches.first;
        evaMov();
        evaMov2();
        
        //timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ProductoView.informacion), userInfo: nil, repeats: false);
        
        if(Panel2==nil && PanelOrigen==nil){ // Entra el touch en el panel Normal
            ultimaPosicion=self.center;
            //print("ult: ", ultimaPosicion);
            self.superview?.superview!.superview!.superview!.bringSubview(toFront: self);
            //print("Normal");
            //padre=self.superview;
            eva4();
            informacion();
        }else{
            timer3 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(evaMov3), userInfo: nil, repeats: false);
            
            ultimaPosicion=self.center;
            print("pos: ", touches.first?.location(in: espacio));
            
            cc = convert(padre!.frame, to: espacio!);
            _ = true;
            _ = self.superview;
            self.layer.zPosition=1;
        }
        
        //print(ultimaPosicion);
        //padre=self.superview;
        //print("padre",padre)
        //VistaGeneral?.view.addSubview(self);
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        acumula!.x = abs(ultimaPosicion.x-self.center.x);
        acumula!.y = abs(ultimaPosicion.y-self.center.y);
        //print("acu: ", acumula);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //timer2 = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(ProductoView.evaMov2), userInfo: nil, repeats: false);
        //evaMov2();
        moviendo = false;
        //print("sale????")
        let objetivo = DatosC.contenedor.pantallaSV.casillaBaja;
        var copia : ProductoView?;
        
        if(Panel2==nil && PanelOrigen==nil){       // Sale del touch normal
            //print("Sale normal");
            //print("espacio P: ", espacioPadre, " centro: ", self.center);
            if(espacioPadre.contains(self.center)){
                //print("punto: ", self.center, tipo);
                //print("Esta adentro", espacioPadre, self.center);
                if(bloqueo4==false){
                    print("entra");
                    //panelElementos(self.padre!.tipo!);
                }
                
                /*
                if(self.center==CGPoint(x: espacioPadre.width/2, y: espacioPadre.height/2)){
                    panelElementos(self.padre!.tipo!);

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
                */
                self.center=ultimaPosicion;
            }else{
                elimina();
                padre?.activo=true;
                if(bloqueo5==true){
                    
                }else{
                    //if(DatosC.contenedor.pantallaSV.contenedor.barraBusqueda != nil){
                    
                        
                    //}
                }
                print("elimina?");
                //DatosC.contenedor.lonchera.contador?.actua();
                DatosB.cont.home2.lonchera.actualizaContador();
            }
        }else{
            //print("sale?")
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
            let centroNatural=touches.first?.location(in: espacio);
            if(espacioPadre.contains(self.center)){
                
                //retornaCasilla(padre!);
                //print("retorna");
            }else{
              
                let no=CGRect(x: (objetivo?.frame.origin.x)!, y: (((objetivo?.frame.origin.y)!+DatosC.contenedor.pantallaSV.espacioIntercambio.frame.origin.y+(DatosC.contenedor.pantallaSV.LaBarra.frame.height+DatosC.contenedor.pantallaSV.LaBarra.frame.origin.y))), width: (objetivo?.frame.width)!, height: (objetivo?.frame.height)!);
                //print("centro ima: ", centroNatural);
                //print("Objetivo: ", objetivo.frame)
                if(no.contains(centroNatural!)){
                    copiaExito=true;
                    
                }
                
                
            }
            if(copiaExito == true && copia!.producto != nil){
                self.frame = CGRect(x: ((objetivo?.frame.width)!/2)-(self.frame.width/2), y: 0, width: (objetivo?.frame.width)!, height: (objetivo?.frame.height)!);
                //print("---------x^x---------");
                objetivo?.seteaElemento(self, tipo: self.tipo!, ima: self.producto!.imagen!, prod: self.producto!);
                copia!.frame=CGRect(x: 0, y: 0, width: padre!.frame.width, height: padre!.frame.height);
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
        DatosB.cont.home2.lonchera.actualizaContador();
    }
    
    func elimina(){
        
        if(padre != nil){
            padre!.elemeto = nil;
        }
        //DatosB.cont.home2.lonchera.actualizaContador();
        self.removeFromSuperview();
        padre?.setFondo((DatosB.cont.home2.lonchera.salud)!);
    }
    
    //Método que llama al home y inicia el Pop Up del chulo
    func poneChulo(){
        DatosB.cont.home2.chulo();
    }
    
    func panelElementos(_ tipo: Int){
        
        if(Natural==true){
            if(self.producto!.tipo != nil){
                let tipo = self.tipo;
                print("toca prod: ", self.producto?.tipo);
                DatosC.contenedor.tipo=tipo!
            }else{
                print("toca cas: ", tipo);
                DatosC.contenedor.tipo=tipo;
            }
            print("iactu: ", DatosC.contenedor.tipo);
            DatosB.cont.home2.performSegue(withIdentifier: "Seleccion", sender: nil);
            
        }
    }
    
    // Método que copia una vista a la casilla donde se origino la actual
    func copiaCasilla(_ casi: Casilla){
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
        casi.seteaElemento(prodV, tipo: tipo!, ima: ima!, prod: prod!);
        casi.backgroundColor=UIColor.red;
        copiaExito = false;
        
    }
    //Método que permite devolver un vista soltada sin objetivo a su casilla original
    func retornaCasilla(_ casi: Casilla){
        //self.tipo = 0;
        //casi.backgroundColor = UIColor.redColor();
        //print("devuelve: ",casi);
        self.frame = CGRect(x: 0, y: 0, width: casi.frame.width, height: casi.frame.height);
        //copiaCasilla(casi);
        casi.addSubview(self);
        //self.removeFromSuperview();
    }
    
    //Este método es llamado para mostrar la informaciñon de un prtoducto
    func informacion(){
        
        //print("INFO?: ", moviendo);
        //print("BLOQUEO4: ", bloqueo4);
        //print("toque fase: ", ultToque.phase.rawValue);
 
        //print("self: ", self.superview);
        //print("ded: ", ultToque.locationInView(padre));
        //print("acumula: ", acumula);
        var mov = false;
        if((acumula!.x < 15 && acumula!.y < 15)){
            //print("adentro");
            mov = true;
            
        }
        print("mov: ", mov);
        if(Panel2==nil && PanelOrigen==nil){
            DatosB.cont.home2.iniciaPanelInfo(self.producto!);
            DatosB.cont.home2.panelInfo.setTipo(self.tipo!);
            DatosB.cont.home2.panelInfo.BotonesEleccion();
            DatosB.cont.home2.panelInfo.iniciaBotonEliminar(self);
        }else{
            print("info panSV");
            if(bloqueo4 == true && ultToque.phase.rawValue==2 && mov == true){
                DatosC.contenedor.pantallaSV.iniciaPanelInfo(self.producto!);
                
            }
        }
        
        bloqueo4 = false;
    }
    
    //Método que se ejecuta al final de la seleción de un producto y evalua si se cierra o no la alacena
    func cierraAlacena(_ pasa: Bool){
        
        if(pasa){
            /*
            //
            //print("QQ: ", DatosC.contenedor.lonchera.fechaVisible?.text);
            for cas in (DatosB.cont.home2.lonchera.casillas){
                //print("cas: ", cas.tipo, " cont: ", DatosC.contenedor.tipo);
                if (cas.tipo == DatosC.contenedor.tipo){
                    let cc = copiarse();
                    
                    cc.frame = CGRectMake(0, 0, cas.frame.width, cas.frame.height);
                    print("casilla: ", cas.frame);
                    print("frame: ", cc.frame);
                    cas.addSubview(cc);
                    cas.elemeto=cc;
                    print("cas: ", cas.elemeto?.producto?.nombre);
                }
            }
            */
            poneChulo()
            print("iAct: ", DatosC.contenedor.tipo);
            
            DatosB.cont.home2.lonchera.setCasilla(DatosC.contenedor.tipo, prod: self.producto!, salud: false);
            self.Natural=true;
            DatosB.cont.home2.lonchera.nombr="Personalizada";
            //DatosC.contenedor.lonchera.color = nil;
            //DatosC.contenedor.lonchera.contador?.actua();
            DatosC.contenedor.pantallaSV.actuaLonch(true);
            
        }else{
            
        }
    }
    
    //Mètodo que permite hacer una copia de si mismo
    func copiarse()->ProductoView{
        
        var copia :ProductoView;
        copia = ProductoView(frame: padre!.frame, imagen: (padre?.elemeto!.producto!.imagen)!);
        print("copia");
        //copia.frame = (padre?.frame)!;
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
        self.isUserInteractionEnabled=true;
        //self.hidden=false;
        //print("Suelta: ", bloqueo2);
    }
    
    //Método que evaluará si se aplica movimiento
    func evaMov3(){
        print("eva 3: ", ultToque.phase.rawValue);
        if(self.frame.contains(ultToque.location(in: self)) ){
            if(ultToque.phase.rawValue==2){
                print("Mueve");
                bloqueo2 = true;
                bloqueo5 = true;
                //self.center=ultimaPosicion;
                if(Panel2 == nil && PanelOrigen == nil){
                    print("Pasa");
                    self.center=CGPoint(x: padre!.frame.width/2, y: padre!.frame.height/2);
                    eva4();
                    informacion();
                }else{
                    eva4();
                    informacion();
                }
            }else if(ultToque.phase.rawValue==3){
                print("Panel");
                bloqueo2=false;
                if(Panel2 == nil && PanelOrigen == nil){
                    panelElementos(self.padre!.tipo!);
                }else if(DatosC.contenedor.pantallaSV.contenedor != nil){
                    DatosC.contenedor.pantallaSV.cierraBusqueda(self);
                }
            }
            //print("Adentro: ", ultToque.phase.rawValue);
            //bloqueo5 = false;
            
        
        /*}else if(Panel2==nil && PanelOrigen==nil){
            //self.hidden=true;
            
            let posR = ultToque.locationInView(self.superview).x - self.center.x;
            
            print("Ultima: ", ultToque.locationInView(self.superview));
            print("Centro: ", self.center);
            print("afuera: ", posR);
 
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
            //self.userInteractionEnabled=false;*/
        }/*else{
            print("bloq2: ", bloqueo2);
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
        */*/
    }
    
    //Método que evalua si se debe mostrar la información del producto
    func eva4(){
        bloqueo4=true;
    }
    
    func actuaImagen(){
        self.imagen?.image = self.producto?.imagen;
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
