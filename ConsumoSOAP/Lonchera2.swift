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
    var letrero: UIView!;
    var nombr:String!;
    var vista : UIView!;
    var nomb : UITextField!;
    
    
    override init(frame: CGRect){
        super.init(frame: frame);
        iniciaCasillas();
        iniciaTablaDatos();
        iniciaBotonFav();
        DatosB.cont.poneFondoTot(self, fondoStr: "LoncheraVerde", framePers: nil, identi: "loncheraB", scala: false);
        print("ini lonch")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que inicia las casillas de la lonchera
    func iniciaCasillas(){
        let oox = (self.frame.width/2)-((self.frame.width*0.9)/2);
        let ooy = (self.frame.height/2)-((self.frame.height*0.8)/2);
        let frameRef = CGRectMake(oox, ooy, (self.frame.width*0.9), (self.frame.height*0.8));
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
            let frameCas = CGRectMake((OX), OY, ancho, alto);
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
        let ancho = self.frame.width;
        let alto = DatosC.contenedor.altoP*0.110;
        let OX = CGFloat(0);
        let OY = self.frame.height;
        let frameLetrero = CGRectMake(OX, OY, ancho, alto);
        contador = Contador2(frame: frameLetrero);
        //contador.backgroundColor=UIColor.blueColor();
        DatosB.cont.poneFondoTot(contador, fondoStr: "TablaValor", framePers: nil, identi: "Contador", scala: false);
        self.addSubview(contador);
    }
    
    //Método que permite poner un elemento en una casilla
    func setCasilla(tipo: Int, prod: Producto){
        for cas in casillas{
            //print("tipo: ", tipo);
            if (cas.tipo == tipo){
                //print("castipo: ", tipo);
                if(cas.elemeto != nil){
                    cas.elemeto?.elimina();
                }
                //cas.seteaElemento(prod, tipo: cas.tipo!, ima: (prod.producto?.imagen)!, prod: prod.producto!);
                
                cas.elemeto?.espacioPadre=cas.frame;
                let imagenN = prod.imagen;
                let prodN=ProductoView(frame: CGRectMake(0, 0, cas.frame.width, cas.frame.height), imagen: imagenN);
                prodN.producto=prod;
                prodN.padre=cas;
                prodN.espacioPadre=CGRectMake(0, 0, cas.frame.width, cas.frame.height)
                cas.elemeto=prodN;
                cas.addSubview(prodN);
            }
        }
        actualizaContador();
    }
    
    //Método que evalua los valores de los productos y el color de la lonchera
    func actualizaContador(){
        //print("actua")
        var valor:Int=0;
        var calorias:Int=0;
        var azucar:Int=0;
        var proteina:Int=0;
        var salud = true;
        for cas in casillas{
            if(cas.elemeto != nil){
                //print("ele?: ", cas.elemeto?.producto?.nombre);
                for dato in (cas.elemeto?.producto?.listaDatos)!{
                    switch dato.id {
                    case 1:
                        calorias += Int(dato.valor);
                        break;
                    case 3:
                        azucar += Int(dato.valor);
                        break;
                    case 4:
                        proteina += Int(dato.valor);
                        break;
                    default:
                        break;
                    }
                    
                }
                valor += (cas.elemeto?.producto?.precio)!;
                //print("val: ", valor);
                if(cas.elemeto?.producto?.salud==false){
                    salud = false;
                }
            }
            
            
        }
        contador.azucar.text=String(azucar);
        contador.calorias.text=String(calorias);
        contador.proteina.text=String(proteina);
        contador.valor.text=String(valor);
        cambiaColor(salud);
        lfavo=esFavorita();
        if(lfavo != nil){
            favorita = true;
        }else{
            favorita = false;
        }
        cambiaFavorita();
        print("favorita?: ", favorita);
        //print("salud: ", salud);
    }
    
    //Método que cambia el color de la lonchera de verde a blanco
    func cambiaColor(salud: Bool){
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
        for cas in casillas{
            if(cas.elemeto != nil){
                llena=true;
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
        imagen = UIImage(named: "BotonF")!;
        
        let OX=self.frame.width*0.45
        let OY=self.frame.height*0.85;
        //let BAOX=(OX+ancho);
        
        let Bancho=(self.frame.width*0.1173);
        let frame = CGRectMake(OX, OY, Bancho, Bancho);
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
        DatosB.cont.poneFondoTot(botfavo, fondoStr: "BotonF", framePers: nil, identi: "Favo", scala: true);
        botfavo?.addTarget(self, action: #selector(Lonchera2.letreroNombre), forControlEvents: .TouchDown);
        self.addSubview(botfavo!);
        
    }
    
    //Método que sube la lonchera
    func subeFavorita(){
        if(DatosB.cont.favoritos.count<=5){
            if(!favorita ){
                vista.removeFromSuperview();
                var prds = [Producto]()
                for cas in casillas{
                    if(cas.elemeto != nil){
                        prds.append((cas.elemeto?.producto)!);
                    }
                }
                let sube = SubeFavorito(nombre: nomb.text!, prods: prds);
                sube.enviaFavorito();
                favorita=true;
                
            }else{
                let rem = EliminaFavoritos();
                rem.bot=botfavo;
                rem.elimina((lfavo!.id)!);
                //Remueve
            }
        }else{
            print("se pasó de cajas");
        }
        letreroFavorito();
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
            print("pp: ", prod.nombre, " camt: ", cuenta[p]);
            p += 1;
        }
        
        for lon in DatosB.cont.favoritos{
            var lista2 = [Producto]()
            var cuenta2 = [Int]();
            print("lon: ",lon.items.count, " cant: ", cant);
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
                print("pp2: ", prod.nombre, " camt2: ", cuenta2[p]);
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
                                //print("Misma cantidad de: ", prod2.nombre);
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
            DatosB.cont.poneFondoTot(botfavo, fondoStr: "BotonFF", framePers: nil, identi: "Favo", scala: true);
        }else{
            //print("favo FALSE");
            DatosB.cont.poneFondoTot(botfavo, fondoStr: "BotonF", framePers: nil, identi: "Favo", scala: true);
        }
    }
    
    //Método que puestra el letrero cuando se agrega/quita un afavorita
    func letreroFavorito(){
        let ancho = self.frame.width*0.4;
        let alto = self.frame.height*0.3;
        let ox = (self.frame.width/2)-(ancho/2);
        let oy = (self.frame.height/2)-(alto/2);
        let frameFav = CGRectMake(ox, oy, ancho, alto);
        letrero = UIView(frame: frameFav);
        letrero.backgroundColor=UIColor.blueColor();
        if(favorita){
            let msg = UILabel(frame: CGRectMake(0, 0, ancho, alto));
            msg.text="Caja favorita añadida";
            letrero.addSubview(msg);
        }else{
            let msg = UILabel(frame: CGRectMake(0, 0, ancho, alto));
            msg.text="Caja favorita eliminada";
            letrero.addSubview(msg);
        }
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Lonchera2.cierraLetrero), userInfo: nil, repeats: false);
        self.addSubview(letrero);
    }
    
    //Método que cierra el letrero del mensaje
    func cierraLetrero(){
        letrero.removeFromSuperview();
    }
    
    //Método que pide el nombre de la lonchera favorita nueva
    func letreroNombre(){
        if(!favorita){
            let ancho = self.frame.width*0.4;
            let alto = self.frame.height*0.3;
            let ox = (self.frame.width/2)-(ancho/2);
            let oy = (self.frame.height/2)-(alto/2);
            let frameFav = CGRectMake(ox, oy, ancho, alto);
            vista = UIView(frame: frameFav);
            let texto = UILabel(frame: CGRectMake(0, 0, ancho, alto/3));
            let frameNomb = CGRectMake(0, alto/3, ancho, alto/3);
            let frameBot = CGRectMake(0, 2*(alto/3), ancho, alto/3);
            let bot = UIButton(frame: frameBot);
            nomb = UITextField(frame: frameNomb);
            nomb.backgroundColor=UIColor.redColor();
            texto.text = "Ingresa el nombre de la lonchera favorita";
            texto.numberOfLines=0;
            nomb.placeholder = "Favorita";
            //bot.titleLabel = UILabel(frame: CGRectMake(0, 0, bot.frame.width, bot.frame.height));
            bot.titleLabel?.text="Ingresar";
            nombr=nomb.text;
            bot.addTarget(self, action: #selector(Lonchera2.subeFavorita), forControlEvents: .TouchDown);
            vista.addSubview(texto);
            vista.addSubview(nomb);
            vista.addSubview(bot);
            vista.backgroundColor=UIColor.yellowColor();
            self.addSubview(vista);
        }else{
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
