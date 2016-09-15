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
    }
    
    func iniciaVistaLonchera(){
        let ancho = self.frame.width*0.3;
        let alto = self.frame.height*0.8;
        borde = self.frame.width*0.02;
        let frameVista = CGRectMake(borde, borde, ancho, alto);
        let imagen : UIImage;
        lonch.contador.esSaludable();
        lonch.actualizaContador();
        print("loncS: ", lonch.contador.saludable, " favo: ", lonch.favorita);
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
        backImg.contentMode=UIViewContentMode.ScaleAspectFit;
        self.addSubview(backImg);
    }
    
    func iniciaDatos(){
        let anchoNombre = self.frame.width*0.3;
        let OXnombre = anchoNombre+borde;
        let alto = self.frame.height*0.2;
        let frameNombre = CGRectMake(OXnombre, borde, anchoNombre, alto);
        let nombre = UILabel(frame: frameNombre);
        nombre.text=lonch.nombr;
        nombre.textColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        nombre.font=UIFont(name: "SansBeam Head", size: alto);
        self.addSubview(nombre);
        let OYele = (alto*0.7);
        var p = CGFloat(1);
        for cas in lonch.casillas{
            let frameEle = CGRectMake(OXnombre, borde+(OYele*p), anchoNombre, alto);
            let label = UILabel(frame: frameEle);
            if(cas.elemeto != nil){
                label.text = "-"+(cas.elemeto!.producto?.nombre)!;
                label.font=UIFont(name: "SansBeamBody-Book", size: OYele)
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
        let framePrecio=CGRectMake(OX, oy, ancho, alto);
        let vistaPrecio = UIView(frame: framePrecio);
        self.addSubview(vistaPrecio);
        DatosB.cont.poneFondoTot(vistaPrecio, fondoStr: "FondoPrecio", framePers: nil, identi: nil, scala: false);
        let valor = UILabel(frame: CGRectMake(0, 0, ancho, alto));
        lonch.actualizaContador();
        valor.text = "$"+lonch.contador.valor.text!;
        valor.textAlignment=NSTextAlignment.Center;
        vistaPrecio.addSubview(valor);
        valor.textColor=UIColor.whiteColor();
        valor.font=UIFont(name: "SansBeam Body", size: (alto*0.8));
    }
    
    func iniciaSumador(){
        let ancho1 = self.frame.height*0.25;
        let ancho2 = ancho1;
        let OX1 = self.frame.width*0.55;
        let OX2 = OX1+ancho1;
        let OX3 = OX2+ancho2;
        let OY = self.frame.height*0.5;
        let frame1=CGRectMake(OX1, OY, ancho1, ancho1);
        let frame2=CGRectMake(OX2, OY, ancho2, ancho1);
        let frame3=CGRectMake(OX3, OY, ancho1, ancho1);
        let bot1 = UIButton(frame: frame1);
        labC = UILabel(frame: frame2);
        let bot2 = UIButton(frame: frame3);
        //print("f2: ", frame2);
        //print("f3: ", frame3);
        //bot2.backgroundColor=UIColor.greenColor();
        DatosB.cont.poneFondoTot(bot1, fondoStr: "Boton+", framePers: nil, identi: nil, scala: true);
        DatosB.cont.poneFondoTot(bot2, fondoStr: "Boton-0", framePers: nil, identi: nil, scala: true);
        labC.text=String(self.cant);
        labC.textColor = UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        labC.font=UIFont(name: "SansBeamBody-Book", size: (labC.frame.height*0.6));
        print("ff: ", labC.font.familyName);
        labC.textAlignment=NSTextAlignment.Center;
        self.addSubview(bot1);
        self.addSubview(bot2);
        self.addSubview(labC);
        bot1.addTarget(self, action: #selector(VistaTipo.suma), forControlEvents: .TouchDown);
        bot2.addTarget(self, action: #selector(VistaTipo.resta), forControlEvents: .TouchDown);
    }
    
    func suma(){
        var cc = self.cant
        cc! += 1;
        self.cant=cc;
        labC.text=String(self.cant);
        actuaLista();
    }
    
    func resta(){
        
        if(self.cant>1){
            var cc = self.cant
            cc! -= 1;
            self.cant=cc;
        }
        labC.text=String(self.cant);
        actuaLista();
    }
    
    func actuaLista(){
        DatosB.cont.listaLoncheras[indice].1=self.cant;
        var tot=0;
        let envio = 5000;
        for lon in DatosB.cont.listaLoncheras{
            tot += lon.0.valor*lon.1;
        }
        tot += envio;
        print("tot: ", tot, "envio: ", envio); 
        DatosB.cont.carrito.sum.actuaPrecios(tot, envio: envio);
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
