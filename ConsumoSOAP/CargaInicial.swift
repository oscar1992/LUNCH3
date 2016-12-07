//
//  CargaInicial.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 8/11/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CargaInicial: NSObject {
    
    var falta1 = false;
    var ss = 0;
    
    var ciclo = 1;
    let tama = 10;
    var cuenta = 0;
    
    var valida = 0;
    //var vista : UIView!;
    //var texto : UILabel?;
    var bloqueapasa = false;
    var errores = [Producto]();
    var plogin : LoginView;
    
    init(log: LoginView){
        self.plogin=log;
        super.init();
        let cargaI=ConsultaProductos();
        cargaI.consulta(self);
        poneCredenciales();
        //DatosB.cont.cargaInicial=self;
    }
    
    func cargaImagenes(){
        print("Inicia Carga Imagenes");
        plogin.iniciamsg();
        //bloqueCarga(0);
        bloqueCarga2();
        
    }

    
    func bloqueCarga2(){
        
        var porcion = [Producto]();
        var ini = 0;
        var fin = 10;
        if(ciclo == 1){
            
        }else{
            ini=(10*(ciclo-1))+1;
            fin=10*ciclo;
        }
        print("ini: ", ini,"fin :", fin);
        for pp in ini ... fin{
            if(pp<DatosC.contenedor.productos.count){
                porcion.append(DatosC.contenedor.productos[pp]);
            }
            
        }
        let hilo = DISPATCH_QUEUE_PRIORITY_HIGH;
        for prod in porcion{
            let ima = NSUserDefaults.standardUserDefaults().objectForKey(String(prod.id));
            if(ima == nil){
                //print("Imagen de red: ", prod.id);
                dispatch_async(dispatch_get_global_queue(hilo, 0)) {
                    var ok = false;
                    let url = NSURL(string: prod.imagenString!)!
                    let data = NSData(contentsOfURL : url);
                    if(data != nil){
                        let imagenD=UIImage(data: data!);
                        prod.imagen=imagenD;
                        NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(imagenD!), forKey: String(prod.id));
                        //self.recoge();
                        //print("ImagenE");
                        ok = true;
                    }else{
                        //print("ImagenI");
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        if(ok == false){
                            self.errores.append(prod);
                        }
                        self.recoge(prod.id!);
                    }
                }
            }else{
                print("Imagen de archivo: ", prod.id);
                let datosIma = ima as! NSData;
                prod.imagen=UIImage(data: datosIma);
                recoge(prod.id!);
            }
            
        }
    }
    
    func recoge(id: Int){
        cant();
        //print("fin sub: ", id);
        valida += 1;
        cuenta += 1;
        if(valida == tama && cuenta < DatosC.contenedor.productos.count){
            //print("fin ciclo: ", cuenta);
            ciclo += 1;
            valida = 0;
            //print("nuevo ciclo");
            bloqueCarga2();
        }else if(cuenta==DatosC.contenedor.productos.count){
            print("fin?");
            print("errores: ", errores.count);
            //plogin.vista.removeFromSuperview();
            let cargaInfo = CargaTinfo2();
            cargaInfo.cargaInformacion(plogin);
            
            //
        }
    }
    
    
    /*
    func bloqueCarga(inicia : Int){
        let divi=parteLista(4);
        var siguiente = true;
        let hilo = DISPATCH_QUEUE_PRIORITY_BACKGROUND;
        var p = inicia;
        //print("Inicia: ",p," tot: ", DatosC.contenedor.productos.count);
        if(p>=DatosC.contenedor.productos.count){
            siguiente=false;
            
        }
        
        while(siguiente){
            
            let prod = DatosC.contenedor.productos[p];
            let ima = NSUserDefaults.standardUserDefaults().objectForKey(String(prod.id));
            if(ima == nil){
                dispatch_async(dispatch_get_global_queue(hilo, 0)) {
                    //print("Hilo de carga de imaganes: ", prod.nombre)
                    
                    let url = NSURL(string: prod.imagenString!)!
                    let data = NSData(contentsOfURL : url);
                    if(data != nil){
                        let imagenD=UIImage(data: data!);
                        prod.imagen=imagenD;
                        NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(imagenD!), forKey: String(prod.id));
                        
                    }else{
                        self.falta1=true;
                        
                        //print("---------------------------------");
                        print("img upd: ",prod.imagenString);
                        //print("null imagen: ", prod.nombre);
                        //print("---------------------------------");
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        //print("Fin carga de iamgen: ", self.falta1);
                        self.cant();
                        if(self.falta1 == true){
                            print("Vacío");
                        }
                        if(DatosC.contenedor.pantallaSV.contenedor != nil){
                            print("repinta");
                            DatosC.contenedor.pantallaSV.reiniciaContenedor();
                            
                        }
                        
                    }
                }
                
            }else{
                print("Imagen de archivo: ", prod.id);
                let datosIma = ima as! NSData;
                prod.imagen=UIImage(data: datosIma);
                self.cant();
            }
            p += 1;
            //print("p: ", p);
            if(p >= (divi*ciclo) || p >= DatosC.contenedor.productos.count){
                ciclo += 1;
                siguiente=false;
            }
            
        }
        if(p<DatosC.contenedor.productos.count){
            self.bloqueCarga(p-1);
            
        }

    }
    
    func parteLista(divi: Int)->Int{
        let cant = DatosC.contenedor.productos.count/divi;
        print("cant: ", cant);
        return cant;
    }
 
 
    
    func iniciamsg(){
        print("Inicia Msg");
        let alto = DatosC.contenedor.altoP;
        let ancho = DatosC.contenedor.anchoP;
        let rect = CGRectMake(0, 0, ancho, alto);
        vista = UIView(frame: rect);
        let alto2 = DatosC.contenedor.altoP * 0.1;
        let OY = DatosC.contenedor.altoP * 0.7;
        let rect2 = CGRectMake(0, OY, DatosC.contenedor.anchoP, alto2);
        texto = UILabel(frame: rect2);
        texto!.textAlignment=NSTextAlignment.Center;
        texto!.text="0%";
        texto!.textColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        texto?.font=UIFont(name: "Gotham Bold", size: alto2/2);
        vista.addSubview(texto!);
        print("Agrega MDG: ", texto?.text);
        plogin.view.addSubview(vista);
        vista.layer.zPosition=1;
        
    }
    */
    
    func cant(){
        ss += 1;
        let tot = DatosC.contenedor.productos.count;
        let prog = ss * 100 / tot;
        //print("Prog: ", prog);
        //print("TextA: ", plogin.texto?.text);
        plogin.texto!.text=String(prog)+"%";
        print("TextD: ", plogin.texto?.text);
        plogin.vista.addSubview(plogin.texto!);
    }
    
    func poneCredenciales(){
        print("user: ", DatosD.contenedor.padre.email);
        print("user: ", DatosD.contenedor.padre.pass);
        NSUserDefaults.standardUserDefaults().setObject(DatosD.contenedor.padre.email, forKey: "user");
        NSUserDefaults.standardUserDefaults().setObject(DatosD.contenedor.padre.pass, forKey: "pass");
        
    }
}
