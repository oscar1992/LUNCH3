//
//  Lonchera2.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 2/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Lonchera2: UIView {
    
    var casillas = [Casilla]();
    var contador:Contador2!;
    var botfavo:UIButton!;
    var favorita=false;
    var lfavo: Favoritos?;
    
    var nombr:String!;
    var vista : UIView!;
    var nomb : UITextField!;
    var valor: Int!;
    var salud: Bool!;
    
    override init(frame: CGRect){
        super.init(frame: frame);
        iniciaCasillas();
        iniciaTablaDatos();
        iniciaBotonFav();
        DatosB.cont.poneFondoTot(self, fondoStr: "LoncheraVerde", framePers: nil, identi: "loncheraB", scala: false);
        //print("ini lonch")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que inicia las casillas de la lonchera
    func iniciaCasillas(){
        let oox = (self.frame.width/2)-((self.frame.width*0.9)/2);
        let ooy = (self.frame.height/2)-((self.frame.height*0.8)/2);
        let frameRef = CGRect(x: oox, y: ooy, width: (self.frame.width*0.9), height: (self.frame.height*0.8));
        let vistaRef = UIView(frame: frameRef);
        //vistaRef.backgroundColor=UIColor.blueColor();
        self.addSubview(vistaRef);
        let ancho = vistaRef.frame.width/2;
        let bordelateral = DatosC.contenedor.anchoP*0.01
        let alto = vistaRef.frame.height/2;
        var p = CGFloat(0);
        var l = CGFloat(0);
        for n in 0...3{
            let OX = ((ancho+bordelateral) * p)+(bordelateral/2);
            let OY = ((alto+bordelateral) * l)+(bordelateral/2);
            let frameCas = CGRect(x: (OX), y: OY, width: ancho, height: alto);
            let cas = Casilla(frame: frameCas);
            vistaRef.addSubview(cas);
            cas.tipo=n+1;
            cas.setFondo(true);
            casillas.append(cas);
            p += 1;
            if(p>1){
                p=0;
                l += 1;
            }
            
        }
    }
    
    //Método que inicia la tabla de los datos
    func iniciaTablaDatos(){
        let ancho = self.frame.width*0.8;
        let alto = DatosC.contenedor.altoP*0.110;
        let OX = (self.frame.width/2)-(ancho/2);
        let OY = self.frame.height+(self.frame.height*0.1);
        let frameLetrero = CGRect(x: OX, y: OY, width: ancho, height: alto);
        contador = Contador2(frame: frameLetrero);
        //contador.backgroundColor=UIColor.blueColor();
        DatosB.cont.poneFondoTot(contador, fondoStr: "TablaValor", framePers: nil, identi: "Contador", scala: false);
        self.addSubview(contador);
    }
    
    //Método que permite poner un elemento en una casilla
    func setCasilla(_ tipo: Int, prod: Producto, salud: Bool){
        if(salud){
            for cas in casillas{
                //print("tipo: ", prod.tipo);
                if (cas.tipo == prod.tipo){
                    //print("castipo: ", cas.tipo);
                    if(cas.elemeto != nil){
                        cas.elemeto?.elimina();
                    }
                    //cas.seteaElemento(prod, tipo: cas.tipo!, ima: (prod.producto?.imagen)!, prod: prod.producto!);
                    
                    cas.elemeto?.espacioPadre=cas.frame;
                    let reductor = CGFloat(0.8);
                    let ancho = cas.frame.width*reductor;
                    let alto = cas.frame.height*reductor;
                    let OX = (cas.frame.width/2)-(ancho/2);
                    let OY = (cas.frame.height/2)-(alto/2);
                    let imagenN = prod.imagen;
                    let prodN=ProductoView(frame: CGRect(x: OX, y: OY, width: ancho, height: alto), imagen: prod.imagen!);
                    prodN.producto=prod;
                    prodN.padre=cas;
                    prodN.espacioPadre=CGRect(x: OX, y: OY, width: ancho, height: alto);
                    prodN.tipo=cas.tipo;
                    prodN.Natural=true;
                    prodN.PanelOrigen=nil;
                    prodN.Panel2=nil;
                    //print("ima: ", prodN.producto?.imagen);
                    
                    //prodN.producto?.imagen=imagenN;
                    cas.elemeto=prodN;
                    cas.addSubview(prodN);
                }
            }
        }else{
            //print("Tipo: ", tipo);
            let cas = casillas[tipo-1];
            if(cas.elemeto != nil){
                cas.elemeto?.elimina();
            }
            //cas.seteaElemento(prod, tipo: cas.tipo!, ima: (prod.producto?.imagen)!, prod: prod.producto!);
            
            cas.elemeto?.espacioPadre=cas.frame;
            let reductor = CGFloat(0.8);
            let ancho = cas.frame.width*reductor;
            let alto = cas.frame.height*reductor;
            let OX = (cas.frame.width/2)-(ancho/2);
            let OY = (cas.frame.height/2)-(alto/2);
            let imagenN = prod.imagen;
            //print("ima: ", prod.imagen!);
            let prodN=ProductoView(frame: CGRect(x: OX, y: OY, width: ancho, height: alto), imagen: prod.imagen!);
            prodN.producto=prod;
            prodN.padre=cas;
            prodN.espacioPadre=CGRect(x: OX, y: OY, width: ancho, height: alto);
            prodN.tipo=cas.tipo;
            prodN.Natural=true;
            prodN.PanelOrigen=nil;
            prodN.Panel2=nil;
            //print("cant: ", prodN.producto?.listaDatos.count);
            //print("nombreima: ", prodN.producto?.imagenString);
            let ima = UIImageView(image: prod.imagen!);
            cas.elemeto=prodN;
            //cas.elemeto!.imagen=ima;
            
            cas.addSubview(prodN);
        }
        
        //actualizaContador();
    }
    
    //Método que evalua los valores de los productos y el color de la lonchera
    func actualizaContador(){
        print("actua")
        
        valor=0;
        var valor2=0;
        var calorias:Int=0;
        var azucar:Int=0;
        var proteina:Int=0;
        salud = true;
        for cas in casillas{
            if(cas.elemeto != nil){
                print("ele?: ", cas.elemeto?.producto?.listaDatos.count);
                ajustaTInfo(prod: cas.elemeto!.producto!);
                for dato in (cas.elemeto?.producto?.listaDatos)!{
                    print("dato: ", dato.id);
                    switch dato.id {
                    case 1:
                        calorias += Int(dato.valor);
                        break;
                    case 3:
                        azucar += Int(dato.valor);
                        print("azucar: ", azucar);
                        break;
                    case 4:
                        proteina += Int(dato.valor);
                        break;
                    default:
                        break;
                    }
                    
                }
                
                valor2 += cas.elemeto!.producto!.precio;
                valor = valor2;
                //print("val: ", valor);
                if(cas.elemeto?.producto?.salud==false){
                    salud = false;
                }
            }
            
            
        }
        
        let formateadorPrecio = NumberFormatter();
        formateadorPrecio.numberStyle = .currency;
        formateadorPrecio.locale = Locale(identifier: "es_CO");
        contador.azucar.text=String(azucar)+" g";
        contador.calorias.text=String(calorias)+" cal";
        contador.proteina.text=String(proteina)+" g";
        if(valor != nil){
            contador.valor.text=formateadorPrecio.string(from: valor as! NSNumber)!;
        }
        
        cambiaColor(salud);
        lfavo=esFavorita();
        if(lfavo != nil){
            favorita = true;
        }else{
            favorita = false;
        }
        cambiaFavorita();
        //print("favorita?: ", favorita);
        //print("salud: ", salud);
    }
    
    func ajustaTInfo(prod: Producto){
        if(prod.listaDatos.count > 6){
            var aux = [TipoInfo]();
            var s1 = false;
            var s2 = false;
            var s3 = false;
            var s4 = false;
            var s5 = false;
            var s6 = false;
            
            for item in prod.listaDatos{
                if(s1 == false && item.id == 1){
                    s1 = true;
                    aux.append(item);
                }
                if(s2 == false && item.id == 2){
                    s2 = true;
                    aux.append(item);
                }
                if(s3 == false && item.id == 3){
                    s3 = true;
                    aux.append(item);
                }
                if(s4 == false && item.id == 4){
                    s4 = true;
                    aux.append(item);
                }
                if(s5 == false && item.id == 5){
                    s5 = true;
                    aux.append(item);
                }
                if(s6 == false && item.id == 6){
                    s6 = true;
                    aux.append(item);
                }
            }
            prod.listaDatos.removeAll();
            prod.listaDatos = aux;
        }
    }
    
    //Método que cambia el color de la lonchera de verde a blanco
    func cambiaColor(_ salud: Bool){
        if(salud){
            DatosB.cont.poneFondoTot(self, fondoStr: "LoncheraVerde", framePers: nil, identi: "loncheraB", scala: false);
            for cas in casillas{
                //print("CambiaFondo: ", salud);
                cas.setFondo(salud);
            }
        }else{
            DatosB.cont.poneFondoTot(self, fondoStr: "LoncheraBlanca", framePers: nil, identi: "loncheraB", scala: false);
            for cas in casillas{
                //print("CambiaFondo: ", salud);
                cas.setFondo(salud);
            }
        }
    }
    
    //Método que indica si la lonchera no contiene productos
    func estaLLena()->Bool{
        var llena = false;
        print("VACIA??")
        for cas in casillas{
            
            if((cas.elemeto?.producto) == nil){
                llena=false;
                print("no posee")
            }else{
                llena=true;
                print("cas: ", cas.elemeto?.producto);
                print("posee");
                break;
            }
        }
        return llena;
    }
    
    //Método que limipa la lonchera
    func limpia(){
        for cas in casillas{
            if(cas.elemeto != nil){
                //print("lleno")
                cas.elemeto!.elimina();
                
            }else{
                //print("vacio")
            }
        }
        //actualizaContador();
    }
    
    //Método que inicia el botón de añadir favoritos
    func iniciaBotonFav(){
        botfavo=UIButton();
        var imagen: UIImage;
        imagen = UIImage(named: "FAVG")!;
        
        let OX=self.frame.width*0.45
        let OY=self.frame.height*0.85;
        //let BAOX=(OX+ancho);
        
        let Bancho=(self.frame.width*0.1173);
        let frame = CGRect(x: OX, y: OY, width: Bancho, height: Bancho);
        botfavo?.frame=frame;
        
        //print("frameF: ",frame);
        /*
        let backImg = UIImageView(frame: frame2);
        let frame2 = CGRectMake(0, 0, frame.width, frame.height);
        backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
        botfavo?.addSubview(backImg);
        botfavo?.sendSubviewToBack(backImg);
        */
        DatosB.cont.poneFondoTot(botfavo, fondoStr: "FAVG", framePers: nil, identi: "Favo", scala: true);
        botfavo?.addTarget(self, action: #selector(Lonchera2.letreroNombre), for: .touchDown);
        self.addSubview(botfavo!);
        
    }
    
    //Método que sube la lonchera
    func subeFavorita(){
        
        var subio=0;
        print("Cajas: ", DatosB.cont.favoritos.count);
        if(DatosB.cont.favoritos.count<5){//Límite de favoritas
            if(!favorita ){
                vista.removeFromSuperview();
                var prds = [Producto]()
                for cas in casillas{
                    if(cas.elemeto != nil){
                        prds.append((cas.elemeto?.producto)!);
                    }
                }
                let sube = SubeFavorito(nombre: self.nombr, prods: prds);
                sube.enviaFavorito();
                favorita=true;
                subio=1;
            }else{
                let rem = EliminaFavoritos();
                rem.bot=botfavo;
                rem.elimina((lfavo!.id)!);
                //Remueve
            }
        }else{
            print("se pasó de cajas: ", DatosB.cont.favoritos.count);
            if(favorita && DatosB.cont.favoritos.count>=5){
                
                let rem = EliminaFavoritos();
                rem.bot=botfavo;
                rem.elimina((lfavo!.id)!);
                subio=0;
            }else{
                print("elimina normal")
                subio=2;
            }
            
        }
        letreroFavorito(subio);
    }
    
    func esFavorita()->Favoritos?{
        var favo: Favoritos?;
        var lista = [Producto]()
        var cuenta = [Int]();
        var cant = 0;
        for cas in casillas{
            //print("cas: ",cas.elemeto ,"prod:", cas.elemeto?.producto);
            if(cas.elemeto != nil){
                if(lista.count==0){
                    lista.append((cas.elemeto?.producto)!);
                    cuenta.append(1);
                    //print("inicia");
                }else{
                    var band = true;
                    var p = 0;
                    var añade = false;
                    while (band == true){
                        //print("pp: ", cas.elemeto?.producto!.id, "tot: ", lista[p].id);
                        if(cas.elemeto?.producto!.id==lista[p].id){
                            //print("suma:");
                            cuenta[p] += 1;
                            añade=true;
                        }
                        p += 1;
                        if(p >= lista.count){
                            if(!añade){
                                lista.append((cas.elemeto?.producto)!);
                                cuenta.append(1);
                                
                            }
                            band = false;
                        }
                    }
                }
                cant += 1;
            }
        }
        var p = 0;
        for prod in lista{
            //print("pp: ", prod.nombre, " camt: ", cuenta[p]);
            p += 1;
        }
        
        for lon in DatosB.cont.favoritos{
            var lista2 = [Producto]()
            var cuenta2 = [Int]();
            //print("lon: ",lon.items.count, " cant: ", cant);
            if(lon.items.count==cant){
                for pfavo in lon.items{
                    if(lista2.count==0){
                        lista2.append(pfavo);
                        cuenta2.append(1);
                        //print("inicia");
                    }else{
                        var band = true;
                        var p = 0;
                        var añade = false;
                        while (band == true){
                            //print("pp: ", cas.elemeto?.producto!.id, "tot: ", lista[p].id);
                            if(pfavo.id==lista2[p].id){
                                //print("suma:");
                                cuenta2[p] += 1;
                                añade=true;
                            }
                            p += 1;
                            if(p >= lista2.count){
                                if(!añade){
                                    lista2.append(pfavo);
                                    cuenta2.append(1);
                                    
                                }
                                band = false;
                            }
                        }
                    }

                }
            }
            p = 0;
            for prod in lista2{
                //print("pp2: ", prod.nombre, " camt2: ", cuenta2[p]);
                p += 1;
            }
            //print("lista1: ",lista.count, "lista2: ", lista2.count);
            var check = 0;
            if(lista2.count == lista.count){
                var i = 0;
                
                for prod2 in lista2{
                    var j = 0;
                    for prod in lista{
                        if(prod.id == prod2.id){
                            if(cuenta[j]==cuenta2[i]){
                                //0'print("Misma cantidad de: ", prod2.nombre);
                                check += 1;
                            }
                        }
                        j += 1;
                    }
                    i += 1;
                }
            }
            if(check == lista2.count && check != 0){
                //print("check ok");
                favo=lon;
            }
        }
        //print("favo?: ", favo)
        return favo;
        
    }
    
    //Método que cambia el corazón si la lonchera es favorita
    func cambiaFavorita(){
        if(favorita){
            //print("favo TRUE");
            DatosB.cont.poneFondoTot(botfavo, fondoStr: "FAVR", framePers: nil, identi: "Favo", scala: false);
        }else{
            //print("favo FALSE");
            DatosB.cont.poneFondoTot(botfavo, fondoStr: "FAVG", framePers: nil, identi: "Favo", scala: true);
        }
    }
    
    //Método que puestra el letrero cuando se agrega/quita un afavorita
    func letreroFavorito(_ sub: Int){
        let ancho = DatosC.contenedor.anchoP*0.8
        let ox = (DatosC.contenedor.anchoP/2)-(ancho/2);
        let oy = (DatosC.contenedor.altoP/2)-(ancho/2);
        let frameFav = CGRect(x: ox, y: oy, width: ancho, height: ancho);
        let letrero = RespuestaFavorita(frame: frameFav, sub: sub);
        //letrero.backgroundColor=UIColor.blueColor();
        

        
        self.superview!.addSubview(letrero);
    }
    
    //Método que cierra el letrero del mensaje
    func cierraLetrero(){
        botfavo.isEnabled=true;
        //letrero.removeFromSuperview();
        if(vista != nil){
            vista.removeFromSuperview();
        }
        
    }
    
    //Método que pide el nombre de la lonchera favorita nueva
    func letreroNombre(){
        botfavo.isEnabled=false;
        print("favorita: ", estaLLena());
        if(!favorita){
            if(estaLLena()==true){
                let ancho = DatosC.contenedor.anchoP*0.8
                let ox = (DatosC.contenedor.anchoP/2)-(ancho/2);
                let oy = (DatosC.contenedor.altoP/2)-(ancho/2);
                let frameFav = CGRect(x: ox, y: oy, width: ancho, height: ancho);
                vista = LetreroFavorita(frame: frameFav);
                self.superview?.addSubview(vista);
            }else{
                botfavo.isEnabled=true;
            }
        }else{
            print("elimina");
            subeFavorita();
        }
        
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
