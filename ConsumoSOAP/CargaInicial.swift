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
    var exitos = [Producto]();
    var plogin : LoginView;
    
    //MARK: Variables Evaluación
    var tipos = [AnyClass]();
    var iteraTipos = -1;
    
    
    //MARK: Métodos
    init(log: LoginView){
        self.plogin=log;
        super.init();
        iniciaArregloTipos();
        iniciaEvaluacion();
        
        //evaluaActualizacion();
        
        //let cargaI=ConsultaProductos();
        //cargaI.consulta(self);
        poneCredenciales();
        //DatosB.cont.cargaInicial=self;
    }
    
    func cargaImagenes(){
        print("Inicia Carga Imagenes");
        plogin.iniciamsg();
        //bloqueCarga(0);
        //bloqueCarga2();
        
    }

    
    func bloqueCarga2(){
        msgInicia();
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
            //let ima = NSUserDefaults.standardUserDefaults().objectForKey(String(prod.id));
            //if(ima == nil){
                //print("Imagen de red: ", prod.id);
                dispatch_async(dispatch_get_global_queue(hilo, 0)) {
                    var ok = false;
                    let url = NSURL(string: prod.imagenString!)!
                    let data = NSData(contentsOfURL : url);
                    if(data != nil){
                        let imagenD=UIImage(data: data!);
                        prod.imagen=imagenD;
                        //NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(imagenD!), forKey: String(prod.id));
                        
                        self.exitos.append(prod);
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
                //}
           
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
            print("nuevo ciclo");
            bloqueCarga2();
        }else if(cuenta==DatosC.contenedor.productos.count){
            let carga2 = CargaInicial2(cInicial: self);
            carga2.guardaImagenes(exitos);
            //iniciaEvaluacion();
            print("fin?");
            print("errores: ", errores.count);
            //plogin.vista.removeFromSuperview();
            //let cargaInfo = CargaTinfo2();
            //cargaInfo.cargaInformacion(plogin);
        }
    }
    
    //Método que inicia un arreglo con los tipos de datos a cargar, importante el orden, imágenes a lo último
    func iniciaArregloTipos(){
        
        cargaFavoritos();
        tipos.append(Producto);
        tipos.append(UIImage);
        tipos.append(Tag);
        tipos.append(TipoInfo);
        tipos.append(Saludable);
        tipos.append(ProductoSaludable);
        
        
        
        //tipos.append(Favoritos);
        
        //
    }
    
    //Método que se llama por cada elemento de la lista de los tipos
    func iniciaEvaluacion(){
        iteraTipos += 1;
        //print("ITERA TIPOS: ", iteraTipos, "tiposCount: ", tipos.count);
        let carga3 = CargaInicial3(cInicial: self);
        if(iteraTipos < tipos.count){
            let carga2 = CargaInicial2(cInicial: self);

            if(!carga2.exixte(tipos[iteraTipos])){
                switch tipos[iteraTipos] {
                case is Producto.Type:
                    let cargaI=ConsultaProductos();
                    cargaI.consulta(self);
                    break;
                case is TipoInfo.Type:
                    let cargaTipoInfo = CargaTinfo2();
                    cargaTipoInfo.cargaInformacion(self);
                    break;
                case is Tag.Type:
                    let cargaTags = CargaTags2();
                    cargaTags.consulta(self);
                    break;
                case is Saludable.Type:
                    let cargaSaludables = CargaSalud();
                    cargaSaludables.cargaSaludables(self);
                    break;
                case is Favoritos.Type:
                    
                    break;
                case is TItems.Type:
                    //let cargaTitems = CargaItemsFavoritos();
                    //cargaTitems.carga(self);
                    break;
                case is ProductoSaludable.Type:
                    print("Vacio en Producto-Saludable");
                    let cargaProductoSaludable = CargaProductoSalud();
                    cargaProductoSaludable.cargaSaludables(self);
                    break;
                case is UIImage.Type:
                    bloqueCarga2();
                    break;
                default:
                    print("default en switch de existen: ", tipos[iteraTipos]);
                    break;
                }
                
            }else{
                
                print("lleno: ", tipos[iteraTipos]);
                carga2.lee(tipos[iteraTipos]);
                carga3.comparaFechas(tipos[iteraTipos]);
                //iniciaEvaluacion();
            }
            
            
        }else{
            
            //
            uneTinfo();
            //cargaZip();
            
            print("Fin");
            pasaLogin();
        }
        
        
    }

    //Método que evalua la existencia de las imágenes
    func cargaZip(){
        let carga3 = CargaZip(padre: self);
        carga3.ejecuta();
    }
    
    
    func cant(){
        ss += 1;
        let tot = Float(DatosC.contenedor.productos.count);
        let prog = ((Float(ss) * 0.9) / tot);
        print("Prog: ", prog);
        sumaBarra(Float(prog));
        //print("TextA: ", plogin.texto?.text);
        //plogin.texto!.text=String(prog)+"%";
        //print("TextD: ", plogin.texto?.text);
        //plogin.vista.addSubview(plogin.texto!);
    }
    
    func sumaBarra(val: Float){
        let vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            vista.barra.progress = val + 0.02;
        }
    }
    
    func msgInicia(){
        let vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            vista.iniciamsg();
            vista.texto?.text="Inicia Carga Imágenes";
        }
    }
    
    func poneCredenciales(){
        print("user: ", DatosD.contenedor.padre.email);
        print("user: ", DatosD.contenedor.padre.pass);
        NSUserDefaults.standardUserDefaults().setObject(DatosD.contenedor.padre.email, forKey: "user");
        NSUserDefaults.standardUserDefaults().setObject(DatosD.contenedor.padre.pass, forKey: "pass");
        
    }
    
    func tamaProductos()->Int{
        return DatosC.contenedor.productos.count;
    }
    
    func tamaInfoNutricional()->Int{
        return DatosB.cont.listaTInfo.count;
    }
    
    func tamaImagnesVacias()->Int{
        var vacias = 0;
        if(DatosC.contenedor.productos.count != 0 || !DatosC.contenedor.productos.isEmpty){
            for prod in DatosC.contenedor.productos{
                if(prod.imagen == nil){
                    vacias += 1;
                }
            }
        }
        return vacias;
    }
    
    func tamaEtiquetas()->Int{
        return DatosD.contenedor.tags.count;
    }
    
    func tamaSaludables()->Int{
        return DatosB.cont.saludables.count;
    }
    
    func tamaItemsSaludables()->Int{
        return DatosB.cont.prodSaludables.count;
    }
    
    func tamaFavoritos()->Int{
        return DatosB.cont.favoritos.count;
    }
    
    func tamaItmesFavoritos()->Int{
        return DatosB.cont.itemsFavo.count;
    }
    
    func pasaLogin(){
        plogin.pasa2();
        if(plogin.vista != nil){
            plogin.vista.removeFromSuperview();
        }
        
    }
    
    //Método que une la información nutricional con su respectivo producto
    func uneTinfo(){
        print("TAMA TINFO: ", DatosB.cont.listaTInfo.count);
        for prod in DatosC.contenedor.productos{
            for titm in DatosB.cont.listaTInfo{
                if(titm.idProducto == prod.id){
                    prod.listaDatos.append(titm);
                }
            }
        }
        for itemS in  DatosB.cont.prodSaludables{
            for prod in DatosC.contenedor.productos{
                if(itemS.produ.id == prod.id){
                    itemS.produ.listaDatos=prod.listaDatos;
                }
            }
        }
    }
    
    func cargaFavoritos(){
        let cargaFavoritos = CargaFavoritos();
        cargaFavoritos.consulta(DatosD.contenedor.padre.id, cInicial: self)
    }
    
}
