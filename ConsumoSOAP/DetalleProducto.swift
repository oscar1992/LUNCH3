//
//  DetalleProducto.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 19/07/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class DetalleProducto: UIView {
    
    var prod : Producto!;
    var casTipo:Int!;
    var prodV : ProductoView!;
    
    init(frame: CGRect, prdo: Producto) {
        super.init(frame: frame);
        self.prod=prdo;
        tipoImagen();
        setFondo();
        Nombre();
        Precio();
        Imagen();
        Datos();
        BotonAgregar();
        BotonCerrar();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Método que establece el fondo del detalle
    func setFondo(){
        let frameFondo = CGRectMake(0, 0, self.frame.width, self.frame.height);
        let imagen = UIImage(named: "FondoDetalle");
        let back = UIImageView(frame: frameFondo);
        back.image=imagen;
        back.alpha=0.9;
        self.addSubview(back);
        self.sendSubviewToBack(back);
    }
    
    //Método que pone la etiqueta del tipo de producto al que pertenece
    func tipoImagen(){
        let frameImagen = CGRectMake(0, DatosC.contenedor.anchoP*0.04, DatosC.contenedor.anchoP*0.18, DatosC.contenedor.altoP*0.13);
        let imagen : UIImage!;
        switch prod.tipo! {
        case 1:
            imagen = UIImage(named: "PEneA")!;
            break;
        case 2:
            imagen = UIImage(named: "PVitA")!;
            break;
        case 3:
            imagen = UIImage(named: "PCreA")!;
            break;
        case 4:
            imagen = UIImage(named: "PBebA")!;
            break;
        default:
            imagen = UIImage(named: "CasillaVerde")!;
            break;
        }
        let back = UIImageView(frame: frameImagen);
        back.image=imagen;
        self.addSubview(back);
    }
    
    //Método que establece el label del Nombre del producto
    func Nombre(){
        let OX = DatosC.contenedor.anchoP*0.25;
        let OY = DatosC.contenedor.altoP*0.04;
        let ancho = DatosC.contenedor.anchoP*0.4;
        let alto = DatosC.contenedor.altoP*0.07;
        let frameNombre = CGRectMake(OX, OY, ancho, alto);
        let label = UILabel(frame: frameNombre);
        label.text=String(prod.nombre!);
        label.font=UIFont(name: "SansBeam Head", size: alto);
        label.textColor=UIColor.grayColor();
        label.numberOfLines=2;
        label.adjustsFontSizeToFitWidth=true;
        self.addSubview(label);
    }
    
    //Método que establece el label del precio del producto
    func Precio(){
        let OX = DatosC.contenedor.anchoP*0.25;
        let OY = DatosC.contenedor.altoP*0.11;
        let ancho = DatosC.contenedor.anchoP*0.3;
        let alto = DatosC.contenedor.altoP*0.03;
        let framePrecio = CGRectMake(OX, OY, ancho, alto);
        let precio = UILabel(frame: framePrecio);
        let formateadorPrecio = NSNumberFormatter();
        formateadorPrecio.numberStyle = .CurrencyStyle;
        formateadorPrecio.locale = NSLocale(localeIdentifier: "es_CO");
        
        
        precio.text = String(formateadorPrecio.stringFromNumber(prod.precio)!);
        precio.font=UIFont(name: "SansBeam Head", size: alto);
        precio.textColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        self.addSubview(precio);
    }
    
    //Método que establece la posición de la imagen
    func Imagen(){
        let OX = DatosC.contenedor.anchoP*0.13;
        let OY = DatosC.contenedor.altoP*0.17;
        let ancho = DatosC.contenedor.anchoP*0.45;
        let alto = DatosC.contenedor.altoP*0.37;
        
        let frameImagen = CGRectMake(OX, OY, ancho, alto);
        let imagen = prod.imagen;
        let back = UIImageView(frame: frameImagen);
        back.image=imagen;
        back.contentMode=UIViewContentMode.ScaleAspectFit;
        self.addSubview(back);
    }
    //Método que permite mostrar los datos de un producto
    func Datos(){
        let OX = DatosC.contenedor.anchoP*0.06;
        let OY = DatosC.contenedor.altoP*0.58;
        let ancho = DatosC.contenedor.anchoP*0.6666;
        _ = DatosC.contenedor.altoP*0.07;
        //let frameDatos = CGRectMake(OX, OY, ancho, alto);
        var itera = 0;
        for fila in 0...2{
            
            for columna in 0...1{
                let ancho2 = ancho/2;
                let alto2 = DatosC.contenedor.altoP*0.026;
                let OX2 = CGFloat(columna)*ancho2+OX;
                let OY2 = CGFloat(fila)*alto2+OY;
                let frameCasilla = CGRectMake(OX2, OY2, ancho2, alto2);
                //let vv = UIView(frame: frameCasilla);
                //vv.backgroundColor=UIColor.blueColor();
                //self.addSubview(vv);
                if(itera < prod.listaDatos.count){
                    //print("framecas: ", frameCasilla);
                    let tituloDato = UILabel(frame: CGRectMake(frameCasilla.origin.x, frameCasilla.origin.y, frameCasilla.width/2, frameCasilla.height));
                    let valorDato = UILabel(frame: CGRectMake(frameCasilla.width/2+frameCasilla.origin.x, frameCasilla.origin.y, frameCasilla.width/2, frameCasilla.height));
                    var tipo: String;
                    switch prod.listaDatos[itera].tipo {
                    case "Calorias":
                        tipo = "Cal";
                        break;
                    case "Grasas":
                        tipo = "g";
                        break;
                    case "Azucar":
                        tipo = "g";
                        break;
                    case "Proteinas":
                        tipo = "g";
                        break;
                    case "Fibra":
                        tipo = "g";
                        break;
                    case "Sodio":
                        tipo = "mg";
                        break;
                    default:
                        tipo = "";
                        break;
                    }
                    tituloDato.text = prod.listaDatos[itera].tipo+":";
                    valorDato.text = String(prod.listaDatos[itera].valor)+"   "+tipo;
                    valorDato.textAlignment=NSTextAlignment.Center;
                    tituloDato.textAlignment=NSTextAlignment.Center
                    tituloDato.textColor=UIColor.grayColor();
                    valorDato.textColor=UIColor.grayColor();
                    tituloDato.font=UIFont(name: "SansBeamHead-SemiBold", size: frameCasilla.height);
                    valorDato.font=UIFont(name: "SansBeamHead-SemiBold", size: frameCasilla.height);
                    self.addSubview(tituloDato);
                    self.addSubview(valorDato);
                }
                
                itera += 1;
                
            }
        }
    }
    
    //Metodo que posiciona el botón de agregar
    func BotonAgregar(){
        let OX = DatosC.contenedor.anchoP*0.12;
        let OY = DatosC.contenedor.altoP*0.7;
        let ancho = DatosC.contenedor.anchoP*0.55;
        let alto = DatosC.contenedor.altoP*0.05;
        let frameBoton = CGRectMake(OX, OY, ancho, alto);
        let boton = UIButton(frame: frameBoton);
        let imagen = UIImage(named: "BotonAgregar");
        let back = UIImageView(frame: CGRectMake(0, 0, ancho, alto));
        boton.addTarget(self, action: #selector(DetalleProducto.agrega(_:)), forControlEvents: .TouchDown);
        back.image=imagen;
        boton.addSubview(back);
        self.addSubview(boton);
    }
    
    //Metodo que posiciona los botones de cruzar
    func BotonesEleccion(){
        let OX = DatosC.contenedor.anchoP*0.12;
        let OY = DatosC.contenedor.altoP*0.7;
        let ancho = DatosC.contenedor.anchoP*0.55;
        let alto = DatosC.contenedor.altoP*0.05;
        let frameBoton = CGRectMake(OX, OY, ancho, alto);
        let boton = UIButton(frame: frameBoton);
        let imagen = UIImage(named: "Botón CAMBIAR");
        let back = UIImageView(frame: CGRectMake(0, 0, ancho, alto));
        boton.addTarget(self, action: #selector(DetalleProducto.cruza(_:)), forControlEvents: .TouchDown);
        back.image=imagen;
        boton.addSubview(back);
        self.addSubview(boton);
    }
    
    //Metodo que prmite agregar el producto en detalle a la lonchera
    func agrega(seneder: UIButton){
        let casilla = DatosC.contenedor.pantallaSV.casillaBaja;
        let pv = ProductoView(frame: CGRectMake(0, 0, casilla.frame.width, casilla.frame.height), imagen: prod.imagen!);
        DatosC.contenedor.pantallaSV.casillaBaja.seteaElemento(pv, tipo: prod.tipo!, ima: prod.imagen!, prod: prod);
        pv.cierraAlacena(true);
    }
    
    func setTipo(tipo: Int){
        self.casTipo=tipo;
    }
    
    //Metodo que prmite agregar el producto en detalle a la lonchera
    func cruza(seneder: UIButton){
        
        DatosC.contenedor.tipo=self.casTipo;
        print("iactu: ", DatosC.contenedor.tipo);
        DatosB.cont.home2.performSegueWithIdentifier("Seleccion", sender: nil);
        self.removeFromSuperview();
    }
    
    //Método que estabelce la posición del botón de cerrar
    func BotonCerrar(){
        let rad = DatosC.contenedor.anchoP*0.09;
        let OX = self.frame.width-(rad);
        _ = (0);
        let frameBot = CGRectMake(OX, 0, rad, rad);
        let botCerrar = UIButton(frame: frameBot);
        let ima=UIImage(named: "BotonCerrar");
        let back = UIImageView(frame: CGRectMake(0, 0, rad, rad));
        back.image=ima;
        botCerrar.addSubview(back);
        botCerrar.addTarget(self, action: #selector(DetalleProducto.cerrar(_:)), forControlEvents: .TouchDown);
        self.addSubview(botCerrar);
    }
    
    //Método que cierra la vista del detalle
    func cerrar(seneder: AnyObject){
        self.removeFromSuperview();
    }
    
    //Método que inicia el botón de eliminar
    func iniciaBotonEliminar(prodV: ProductoView){
        self.prodV=prodV;
        let alto = DatosC.contenedor.altoP*0.05;
        let OX = DatosC.contenedor.anchoP*0.12;
        let OY = DatosC.contenedor.altoP*0.72+alto;
        let ancho = DatosC.contenedor.anchoP*0.55;
        let frame = CGRectMake(OX, OY, ancho, alto);
        let boton = UIButton(frame: frame);
        self.addSubview(boton);
        DatosB.cont.poneFondoTot(boton, fondoStr: "Botón Eliminar", framePers: nil, identi: nil, scala: false);
        boton.addTarget(self, action: #selector(DetalleProducto.eliminaProd), forControlEvents: .TouchDown);
    }
    
    //Método que elimna una vista de producto
    func eliminaProd(){
        self.prodV.elimina();
        self.removeFromSuperview();
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
