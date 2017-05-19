//
//  VistaTipo.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 14/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaTipo: UIView {
    
    var lonch:Lonchera2!;
    var cant: Int!;
    var borde:CGFloat!;
    var labC:UILabel!;
    var indice:Int!;
    
    init(frame: CGRect, lonc: Lonchera2, cant: Int, indi:Int){
        super.init(frame: frame);
        self.lonch=lonc;
        self.cant=cant;
        self.indice=indi;
        //self.backgroundColor=UIColor.whiteColor();
        iniciaVistaLonchera();
        iniciaDatos();
        precioLonc();
        iniciaSumador();
        actuaLista();
        inciaSeparador();
    }
    
    func iniciaVistaLonchera(){
        let ancho = self.frame.width*0.2;
        let alto = self.frame.height*0.7;
        borde = self.frame.width*0.06;
        let frameVista = CGRect(x: borde, y: borde, width: ancho, height: alto);
        let imagen : UIImage;
        
        lonch.actualizaContador();
        //print("loncS: ", lonch.contador.saludable, " favo: ", lonch.favorita);
        if(lonch.favorita){
            imagen = UIImage(named: "L4")!;
        }else{
            if(lonch.contador.saludable){
                imagen = UIImage(named: "L1")!;
            }else{
                imagen = UIImage(named: "L5")!;
            }
        }
        
        let backImg = UIImageView(frame: frameVista);
        backImg.image=imagen;
        backImg.contentMode=UIViewContentMode.scaleAspectFit;
        self.addSubview(backImg);
    }
    
    func iniciaDatos(){
        let anchoNombre = self.frame.width*0.4;
        let OXnombre = self.frame.width*0.28;
        let alto = self.frame.height*0.2;
        let OYnombre = self.frame.height*0.1;
        let frameNombre = CGRect(x: OXnombre, y: OYnombre, width: anchoNombre, height: alto);
        let nombre = UILabel(frame: frameNombre);
        nombre.text=lonch.nombr;
        nombre.textColor=UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        nombre.font=UIFont(name: "SansBeam Head", size: alto);
        nombre.adjustsFontSizeToFitWidth=true;
        self.addSubview(nombre);
        let OYele = (alto*0.7);
        var p = CGFloat(1);
        print("cass: ", lonch.casillas.count);
        for cas in lonch.casillas{
            let frameEle = CGRect(x: OXnombre, y: (borde+10)+(OYele*p), width: anchoNombre, height: alto);
            let label = UILabel(frame: frameEle);
            print("ele: ", cas.elemeto?.producto?.nombre);
            if(cas.elemeto != nil){
                label.text = "•"+(cas.elemeto!.producto?.nombre)!;
                label.font=UIFont(name: "Gotham Medium", size: OYele*0.7)
                //label.adjustsFontSizeToFitWidth=true;
            }
            self.addSubview(label);
            p += 1;
        }
        
    }
    
    func precioLonc(){
        let ancho = self.frame.width*0.25;
        let alto = self.frame.height*0.25;
        let OX = self.frame.width-ancho;
        let oy = borde;
        let framePrecio=CGRect(x: OX, y: oy!, width: ancho, height: alto);
        let vistaPrecio = UIView(frame: framePrecio);
        //vistaPrecio.backgroundColor=UIColor.redColor();
        self.addSubview(vistaPrecio);
        DatosB.cont.poneFondoTot(vistaPrecio, fondoStr: "FondoPrecio", framePers: nil, identi: nil, scala: true);
        let valor = UILabel(frame: CGRect(x: 0, y: 0, width: ancho, height: alto));
        lonch.actualizaContador();
        valor.text = lonch.contador.valor.text!;
        valor.textAlignment=NSTextAlignment.center;
        vistaPrecio.addSubview(valor);
        valor.textColor=UIColor.white;
        valor.adjustsFontSizeToFitWidth=true;
        valor.font=UIFont(name: "Gotham Medium", size: (alto*0.5));
    }
    
    func iniciaSumador(){
        let ancho1 = self.frame.height*0.25;
        let ancho2 = ancho1;
        let OX1 = self.frame.width*0.7;
        let OX2 = OX1+ancho1;
        let OX3 = OX2+ancho2;
        let OY = self.frame.height*0.6;
        let frame1=CGRect(x: OX1, y: OY, width: ancho1, height: ancho1);
        let frame2=CGRect(x: OX2, y: OY, width: ancho2, height: ancho1);
        let frame3=CGRect(x: OX3, y: OY, width: ancho1, height: ancho1);
        let bot1 = UIButton(frame: frame3);
        labC = UILabel(frame: frame2);
        let bot2 = UIButton(frame: frame1);
        //print("f2: ", frame2);
        //print("f3: ", frame3);
        //bot2.backgroundColor=UIColor.greenColor();
        DatosB.cont.poneFondoTot(bot1, fondoStr: "Boton+", framePers: nil, identi: nil, scala: false);
        DatosB.cont.poneFondoTot(bot2, fondoStr: "Boton-0", framePers: nil, identi: nil, scala: false);
        labC.text=String(self.cant);
        labC.textColor = UIColor.init(red: 0, green: 0.5, blue: 0.15, alpha: 1);
        labC.font=UIFont(name: "Gotham Medium", size: (labC.frame.height*0.6));
        //print("ff: ", labC.font.familyName);
        labC.textAlignment=NSTextAlignment.center;
        self.addSubview(bot1);
        self.addSubview(bot2);
        self.addSubview(labC);
        bot1.addTarget(self, action: #selector(VistaTipo.suma), for: .touchDown);
        bot2.addTarget(self, action: #selector(VistaTipo.resta), for: .touchDown);
    }
    
    func suma(){
        var cc = self.cant
        cc! += 1;
        self.cant=cc;
        labC.text=String(self.cant);
        
        actuaLista();
        var tot = 0;
        for tipos in DatosB.cont.listaLoncheras{
            tot += tipos.1;
        }
        DatosB.cont.home2.botonCarrito.cant.text=String(tot);
    }
    
    func resta(){
        
        if(self.cant>1){
            var cc = self.cant
            cc! -= 1;
            self.cant=cc;
        }else{
            //print("Elimina");
            let ancho = DatosC.contenedor.anchoP*0.8
            let ox = (DatosC.contenedor.anchoP/2)-(ancho/2);
            let oy = (DatosC.contenedor.altoP/2)-(ancho/2);
            let frameMsg = CGRect(x: ox, y: oy, width: ancho, height: ancho);
            let msg = MensajeEliminaLonchera(frame: frameMsg, lonchera: lonch, id: indice);
            DatosB.cont.carrito.view.addSubview(msg);
            
        }
        var tot = -1;
        for tipos in DatosB.cont.listaLoncheras{
            tot += tipos.1;
        }
        DatosB.cont.home2.botonCarrito.cant.text=String(tot);
        labC.text=String(self.cant);
        actuaLista();
    }
    
    func actuaLista(){
        DatosB.cont.listaLoncheras[indice].1=self.cant;
        var tot=0;
        let envio = Int(DatosB.cont.envia);
        for lon in DatosB.cont.listaLoncheras{
            print("lon: ", lon.0.valor);
            print("cant: ", lon.1);
            tot += lon.0.valor*lon.1;
        }
        tot += envio;
        //print("tot: ", tot, "envio: ", envio);
        DatosB.cont.carrito.sum.actuaPrecios(tot, envio: envio);
    }
    
    func inciaSeparador(){
        let frameLinea = CGRect(x: 0, y: self.frame.height-2, width: self.frame.width, height: 1);
        let linea = UIView(frame: frameLinea);
        linea.backgroundColor=UIColor.lightGray;
        linea.alpha=0.5;
        self.addSubview(linea);
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
