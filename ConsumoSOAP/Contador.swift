//
//  Contador.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 4/05/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Contador: UIView {
    
    
    var cal:UILabel?;
    var cal2:UILabel?;
    var pre:UILabel?;
    var pre2:UILabel?;
    var id:Int?;
    var esFavorita:Bool!;
    var lonc : LoncheraO!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        let borde=CGFloat(10);
        cal=UILabel();
        cal2=UILabel();
        pre=UILabel();
        pre2=UILabel();
        cal?.frame=CGRect(x: self.frame.width/2, y: 0, width: self.frame.width/4, height: self.frame.height);
        cal2?.frame=CGRect(x: ((cal?.frame.origin.x)!+(cal?.frame.width)!),y: 0 , width: self.frame.width/4, height: self.frame.height);
        pre?.frame=CGRect(x: borde, y: 0, width: self.frame.width/4, height: self.frame.height);
        pre2?.frame=CGRect(x: (pre!.frame.origin.x+pre!.frame.width
            ), y: 0, width: self.frame.width/4, height: self.frame.height);
        cal?.text="Calorías: ";
        pre?.text="Valor: $";
        cal?.font = UIFont(name: "SansBeam Body", size: self.frame.height*0.3);
        cal?.textColor = UIColor.white;
        pre?.font = UIFont(name: "SansBeam Body", size: self.frame.height*0.3);
        pre?.textColor = UIColor.white;
        cal2?.font = UIFont(name: "SansBeam Head", size: self.frame.height*0.5);
        cal2?.textColor = UIColor.white;
        pre2?.font = UIFont(name: "SansBeam Head", size: self.frame.height*0.5);
        pre2?.textColor = UIColor.white;
        cal?.textAlignment = NSTextAlignment.center;
        pre?.textAlignment = NSTextAlignment.center;
        cal2?.textAlignment = NSTextAlignment.left;
        pre2?.textAlignment = NSTextAlignment.left;
        
        self.addSubview(cal!);
        self.addSubview(pre!);
        self.addSubview(cal2!);
        self.addSubview(pre2!);
        //self.backgroundColor=UIColor.yellowColor();
        estableceFondo();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que actualiza los valores de las calorias y del precio, tmabíen evalua si la lonchera ya es favorita
    func actua(){
        
        //let lonc=DatosC.contenedor.lonchera;
        var sum=0;
        var sum2:Float=0;
        var verdes=0;
        var blancas=0;
        for cas in lonc.subVista!.casillas{
            if(cas.elemeto?.producto != nil){
                if((cas.elemeto?.producto?.salud) == true){
                    //print("saludable");
                    verdes += 1;
                }else{
                    blancas += 1;
                }
                //print("pre: ",cas.elemeto?.producto?.nombre);
                for tinfo in (cas.elemeto?.producto?.listaDatos)!{
                    //print("nom: ",tinfo.tipo);
                    if(tinfo.id==1){
                        /*
                        print("idT: ",tinfo.id);
                        print("nom: ",tinfo.tipo);
                        print("val: ",tinfo.valor);
                        */
                        sum2 += tinfo.valor;
                    }
                }
            }
            if(cas.elemeto?.producto?.precio != nil){
                sum += cas.elemeto!.producto!.precio!;
            }
        }
        //print("verdes: ", verdes);
        //print("blancas: ", blancas);

        if(blancas==0){
            lonc.subVista?.cambiaFondo(true);
            for cas2 in lonc.subVista!.casillas{
                //cas2.backgroundColor=UIColor.greenColor();
                cas2.setFondo(true);
            }
            lonc.saludable=true;
        }else{
            lonc.subVista?.cambiaFondo(false);
            for cas2 in lonc.subVista!.casillas{
                //cas2.backgroundColor=UIColor.whiteColor();
                cas2.setFondo(false);
            }
            lonc.saludable=false;
        }
        let formateadorPrecio = NumberFormatter();
        formateadorPrecio.numberStyle = .currency;
        formateadorPrecio.locale = Locale(identifier: "es_CO");
        pre2?.text = String(formateadorPrecio.string(from: NSNumber(value: sum))!);
        //print("pre2: ", pre2?.text);
        cal2?.text = "  "+String(Int(sum2));
        //print("cal2: ", cal2?.text);
        let num : Int;
        //(esFavorita?, num) = esfavorita();
        //print("eva: ", eva)
        if (esFavorita==true){
            fondoEstrella(lonc.botfavo!, esFavorito: true);
            //lonc.nfavorita = num;
        }else{
            //print("non");
            fondoEstrella(lonc.botfavo!, esFavorito: false);
            lonc.nfavorita = nil;
        }
        if(lonc.color != nil){
            //print("Color: ", lonc.color);
        }else{
            //print("Sin color");
        }
    }
    
    /*
    //Método que actuliza la lonchera cuando se llena con una lonchera predeterminada
    func actua2(ncolor: Int){
        actua();
        let lonc=DatosC.contenedor.lonchera;
        lonc.subVista?.fondoColores(ncolor);
    }*/
    
    //Método que permite establece el fondo del contador
    func estableceFondo(){
        let fondo = UIImage(named: "BarraValor");
        let backImg = UIImageView(frame: CGRect(x: 0,y: 0,width: self.frame.width,height: self.frame.height));
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = fondo;
        self.addSubview(backImg);
        self.sendSubview(toBack: backImg);
    }
    
    /*
    //Método que evalua si la lonchera es favorita
    func esfavorita()->(Bool, Int){
        var ret = false;
        var securet : Int;
        let lonc=DatosC.contenedor.loncheras;
        var tot = 0;
        /*for itt in lonc.subVista!.casillas{
            if(itt.elemeto != nil){
                tot += 1;
            }
        }*/
        var opcion1=[Secuencia]();
        
        //print("SECURET: ", securet);
        for secu in DatosD.contenedor.favoritas.secuencia{
            if (secu.lista.count == tot){
                opcion1.append(secu);
            }
        }
        
        var flag1 = true;
        var itera1 = 0;
        if(opcion1.count <= 0){
            flag1 = false;
            //break;
        }
        while(flag1){
            
            //print("Opcion1: ", opcion1.count);
            
            
            
                var items = opcion1[itera1].lista;
            //print("SECU1: ", opcion1[itera1].id);
            
                //print("Secu: ", itera1);
                //for item in items{
                    var flag3 = true;
                    var itera3 = 0;
                    var suma = 0;
            if(items?.count==0){
                //print("no posee");
            }
                    while(flag3){
                        //print("itera 3: ", itera3);
                        var itemasCas = lonc.subVista?.casillas;
                        if(itemasCas![itera3].elemeto?.producto?.id != nil){
                            if((itemasCas![itera3].elemeto?.producto?.id)! == items?[itera3].productos!.id){
                                //print("cass: ", itemasCas![itera3].elemeto?.producto?.nombre);
                                //print("EQ: ", items[itera3].productos!.nombre);
                                suma += 1;
                            }else{
                                //print("Rompe");
                                //print("cass: ", itemasCas![itera3].elemeto?.producto?.nombre);
                                //print("EQ: ", items[itera3].productos!.nombre);
                                flag3=false;
                                suma -= 1;
                            }
                        }else{
                            flag3 = false;
                        }
                        itera3 += 1;
                        //print("Itera3 : ",itera3);
                        //print("Suma: ", suma, "itrems: ", items.count);
                        if(suma == items?.count){
                            flag3 = false;
                            securet = opcion1[itera1].id;
                            ret = true;
                            //print("si");
                        }
                        //print("itera: ", itera3, " count: ", items.count);
                        /*if(itera3 == items.count){
                            flag3 = false;
                            print("nulea");
                            securet = nil;
                         }
                        */
                    }
                    
                //}
                
                //print("Itemns: ", items.count);
            
           
            itera1 += 1;
            if(itera1 >= opcion1.count){
                flag1=false;
            }
        }

        //print("Es: ", ret, "sss", securet);
        return (ret, securet);
    }*/
    
    func fondoEstrella(_ favo: UIButton, esFavorito: Bool){
        for vista in favo.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
                //print("remieve");
            }
        }
        let frame = CGRect(x: 0, y: 0, width: favo.frame.height, height: favo.frame.width);
        var imagen: UIImage;
        //print("esf: ",esFavorito)
        if (esFavorito){
            imagen = UIImage(named: "BotonFF")!;
        }else{
            //print("remieve");
            imagen = UIImage(named: "BotonF")!;
        }
        let backImg = UIImageView(frame: frame);
        backImg.contentMode = UIViewContentMode.scaleAspectFit;
        backImg.image = imagen;
        favo.addSubview(backImg);
        //favo.sendSubviewToBack(backImg);

    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
