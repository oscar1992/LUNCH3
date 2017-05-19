
//
//  VistaPestana.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 20/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class VistaPestana: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    var paginas = [UIViewController]();
    var tipo:Int!;
    var control:UIPageControl?;
    var Panel:PantallaSV?;
    let cant = 3; // Items por estante
    let borde = CGFloat(DatosC.contenedor.anchoP*0.09)/2;
    
    //var vistas = [UIViewController]();
    var contadorVistas = 0;
    let ancho = CGFloat(DatosC.contenedor.anchoP*0.24);
    let alto = CGFloat(DatosC.contenedor.altoP*0.15);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self;
        self.dataSource=self;
        self.Panel=DatosC.contenedor.pantallaSV;
        //cargaPaginascategoria();
        //carga();
        //setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
        self.view.backgroundColor=UIColor.white;
        
                // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews {
            if subView is UIScrollView {
                //print("scroll");
                subView.frame = self.view.bounds
            } else if subView is UIPageControl {
                control = subView as? UIPageControl;
                //print("pagecontrol");
                //subView.frame=CGRectZero;
                //subView.hidden=true;
                self.view.bringSubview(toFront: control!);
            }
        }
        //control?.currentPage=0;
        control?.currentPageIndicatorTintColor=UIColor.init(red: 0.51, green: 0.77, blue: 0.25, alpha: 1);
        control?.pageIndicatorTintColor=UIColor.white;
        control?.frame=CGRect(x: control!.frame.origin.x, y: (DatosC.contenedor.altoP*0.56), width: control!.frame.width, height: control!.frame.height)
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        
        if(paginas.count==1){
            return nil;
        }else{
            let currentIndex = control?.currentPage;
            var previousIndex = abs((currentIndex! - 1) % paginas.count);
            
            let actual = control?.currentPage;
            //print("acc: ", actual);
            if(actual! <= 0 || actual! > paginas.count){
                //print("pre-reduce: ", actual);
                previousIndex = paginas.count-1;
                //print("reduce: ", previousIndex);
            }
            //print("prev: ", previousIndex);
            return paginas[previousIndex];
        }
        //let currentIndex = paginas.indexOf(viewController)!;
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = paginas.index(of: viewController)!;
        let nextIndex = abs((currentIndex + 1) % paginas.count);
        return paginas[nextIndex];
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return paginas.count;
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0;
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //print("ABC: ", control!.currentPage);
        
        //self.setViewControllers((paginas), direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil);
    }
    
    /*
    func carga(){
        var p=CGFloat(0);
        var elementos=[ProductoView]();
        var casillas=[Casilla]();
        let borde = CGFloat(15);
        var divancho :Float;
        divancho=1/Float(cant);
        let anchoP:Int;
        anchoP=Int(self.view.frame.width)
        let ancho = Float(Float(anchoP)*divancho)-(Float(borde));
        var CGAncho=CGFloat(ancho);
        //print("ancho:", ancho);
        //print("anchoP: ",anchoP);
        let espaciado = ancho*0.05;
        CGAncho=CGAncho-CGFloat(espaciado);
        let tama = CGRectMake(0, 0, CGAncho, CGAncho);
        for ele in DatosC.contenedor.productos{
            
            if(ele.tipo==self.tipo){
                //print("tipo E: ",ele.tipo," slide: ",self.tipo);
                //print("prod: ",ele.nombre);
                let pv=ProductoView(frame: tama, imagen: ele.imagen);
                pv.producto=ele;
                pv.tipo=self.tipo;
                elementos.append(pv);
            }
        }
        var m = CGFloat(0);
        var fila = CGFloat(0);
        var tot=0;
        var vistas = [UIViewController]();
        
        
        for ele in elementos{
            let casill=Casilla();
            if(m>=CGFloat(cant)){
                fila+=1
                p=0;
                m=0;
            }
            let pos=CGRectMake((borde+(p*(CGAncho+borde))), (borde+(fila*(CGAncho+borde))), self.ancho, self.alto);
            casill.activo = false;
            
            //casill.elemeto=ele;
            //casill.addSubview(ele);
            ele.padre=casill;
            ele.espacio=self.Panel!.view;
            ele.Panel2=self.Panel?.lonch.subVista;
            
            casill.seteaElemento(ele, tipo: self.tipo!, ima: ele.producto!.imagen, prod: ele.producto!);
            //let precio = UILabel(frame: CGRectMake(0, casill.frame.height*0.9, casill.frame.width, casill.frame.height*0.1));
            //precio.text = String(ele.producto?.precio);
            //casill.addSubview(precio);
            
            if(ele.producto?.salud==true){
                casill.backgroundColor=UIColor.greenColor();
            }else{
                casill.backgroundColor=UIColor.whiteColor();
            }
            casill.frame=pos;
            
            let precio = String(ele.producto!.precio);
            casill.iniciaPrecio(precio);
            //casill.precio!.text = (precio);
            casill.addSubview(casill.precio!);
            casill.bringSubviewToFront(casill.precio!);
            //print("setea: ",precio);
            m+=1;
            
            
            if(tot==0){
                let vistaInt=UIViewController();
                
                //vistaInt.view.backgroundColor=UIColor.init(red: (0+(0.2*p)), green: (1-(0.2*p)), blue: 1, alpha: 1);
                let Label=UILabel(frame: CGRectMake(0,0, 100, 30));
                Label.text=String(p);
                vistaInt.view.addSubview(Label)
                vistas.append(vistaInt);
                vistaInt.view.frame=self.view.frame;
                //print("Vista Nueva",contadorVistas);
                paginas.append(vistaInt);
            }
            ele.PanelOrigen=vistas[contadorVistas].view;
            
            if(tot>=(cant*2)){
                print("a tope")
                tot=0;
                contadorVistas += 1;
            }else{
                vistas[contadorVistas].view.addSubview(casill);
                //print("normal: ",pos)
            }
            tot+=1;
            p += 1;
            //casillas.append(casill);
        }
        
        //setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
        
    }
     */
    
    //Método que permite crear paginas por categoaría
    func cargaPaginascategoria(){
        print("Carga pags");
        paginas.removeAll();
        var p=CGFloat(0);
        var p2=CGFloat(0);
        for categoria in DatosD.contenedor.categorias{
            //print("subCate: ", categoria.tipo);
            p = 0;
            p2 = 0;
            var elementos=[ProductoView]();
            //print("categoria: ", categoria.tipo, " selftipo: ", self.tipo);
            if(categoria.tipo == self.tipo){
                for prod in DatosC.contenedor.productos{
                    //print("Prod cate: ", prod.categoria, " - cateid: ", categoria.id);
                    /*if(prod.id == 194 || prod.id == 193){
                        print("Prod: ", prod.nombre);
                        print("ALEJO: ", prod.imagenString);
                        print("Dispo: ", prod.disponible);
                    }*/
                    if(prod.categoria == categoria.id){
                        //print("PRDO: ",prod.nombre, " cccc ", prod.categoria);
                        let pv=ProductoView(frame: frameProducto(), imagen: prod.imagen!);
                        pv.producto=prod;
                        pv.tipo=self.tipo;
                        if(pv.producto?.imagen==nil){
                            cargaImagen(pv.producto!);
                        }
                        elementos.append(pv);
                        //print("E-tama: ", elementos.count);
                    }
                }
                var fila = CGFloat(0);
                var m = CGFloat(0);
                //print("TamaV: ", seteProductos(elementos).count);
                var vistaInt : UIViewController!;
                for casi in seteProductos(elementos){
                    //print("p: ", p);
                    if(p == 0){
                        //print("nuevo");
                        
                        vistaInt=UIViewController();
                        FondoPanel(vistaInt);
                        //vistaInt.view.backgroundColor=UIColor.init(red: (0+(0.2*CGFloat(vistas.count))), green: (1-(0.2*CGFloat(vistas.count))), blue: 1, alpha: 1);
                        let anchoL = DatosC.contenedor.anchoP*0.5;
                        let OX = (DatosC.contenedor.anchoP/2)-(anchoL/2);
                        let altoL=DatosC.contenedor.altoP*0.05;
                        let Label=UILabel(frame: CGRect(x: OX,y: 10, width: anchoL, height: altoL));
                        Label.textAlignment=NSTextAlignment.center;
                        Label.font=UIFont(name: "Gotham Bold", size: Label.frame.height/2);
                        Label.adjustsFontSizeToFitWidth=true;
                        var nombre = "";
                        switch  categoria.tipo {
                        case 1:
                            nombre = "Snacks";
                            break;
                        case 2:
                            nombre = "Frutas";
                            break;
                        case 3:
                            nombre = "Proteína";
                            break;
                        case 4:
                            nombre = "Bebidas";
                            break;
                        default:
                            break;
                        }
                        for cate in DatosD.contenedor.categorias{
                            if (cate.id==casi.elemeto?.producto?.categoria){
                                Label.text=nombre;

                            }
                        }
                        //Label.text=String(CGFloat(paginas.count));
                        vistaInt.view.addSubview(Label)
                        //vistas.append(vistaInt);
                        
                        vistaInt.view.frame=self.view.frame;
                        
                        iniciaCasillaBaja(vistaInt.view);
                        contadorVistas += 1;
                        paginas.append(vistaInt);
                        //print("añade: ", self.view.frame);
                    }else if(p >= 6){
                        //print("se pasa: ", categoria.tipo);
                        p = 0;
                        fila = 0;
                        m = 0
                        p2 = 0;
                        vistaInt=UIViewController();
                        FondoPanel(vistaInt);
                        let anchoL = DatosC.contenedor.anchoP*0.5;
                        let OX = (DatosC.contenedor.anchoP/2)-(anchoL/2);
                        let altoL=DatosC.contenedor.altoP*0.05;
                        let Label=UILabel(frame: CGRect(x: OX,y: 10, width: anchoL, height: altoL));
                        Label.textAlignment=NSTextAlignment.center;
                        Label.font=UIFont(name: "Gotham Bold", size: Label.frame.height/2);
                        Label.adjustsFontSizeToFitWidth=true;
                        //Label.text=String(CGFloat(paginas.count));
                        var nombre = "";
                        switch  categoria.tipo {
                        case 1:
                            nombre = "Snacks";
                            break;
                        case 2:
                            nombre = "Frutas";
                            break;
                        case 3:
                            nombre = "Proteína";
                            break;
                        case 4:
                            nombre = "Bebidas";
                            break;
                        default:
                            break;
                        }
                        for cate in DatosD.contenedor.categorias{
                            if (cate.id==casi.elemeto?.producto?.categoria){
                                Label.text=nombre;
                                
                            }
                        }
                        vistaInt.view.addSubview(Label)
                        vistaInt.view.frame=self.view.frame;
                        iniciaCasillaBaja(vistaInt.view);
                        contadorVistas += 1;
                        paginas.append(vistaInt);
                    }
                    
                    if(m>=CGFloat(cant)){
                        fila+=1
                        p2 = 0;
                        m=0;
                    }
                    
                    
                    
                    let espaciado = (CGFloat(DatosC.contenedor.anchoP)-((ancho*CGFloat(cant))+(borde*2)))
                    let espaciado2 = espaciado/CGFloat(cant-1);
                    let espaciado3 = DatosC.contenedor.altoP*0.071;
                    let pos2=CGRect(x: (borde+(p2*(self.ancho+espaciado2))), y: (borde*3)+((fila*(self.alto+espaciado3+borde))), width: ancho, height: alto);
                    //print("framecas: ",pos2)
                    casi.frame = pos2;
                    if(m == 0 || m.truncatingRemainder(dividingBy: 3) == 0){
                        //print("pinta?");
                        pintaEstante(fila, frameRef: pos2, vista: vistaInt, espaciado: espaciado3);// Posicion Producto
                    }else{
                        //print("no pinta?")
                    }
                    panelInfo(casi, salud: casi.elemeto!.producto!.salud!);
                    
                    //print("tam: ", casi.frame);
                    /*
                    print("tam2: ", casi.elemeto?.frame);
                    
                    print("tam3: ", casi.elemeto?.imagen?.image);
                    */
                    casi.elemeto?.PanelOrigen = vistaInt.view;
                    vistaInt.view.addSubview(casi);
                    
                    
                    m += 1;
                    p2 += 1;
                    p += 1;

                    
                }
                
            }
            
        }
        //print("ELE: ",paginas.count);
        
        //print("ccss: ", paginas.count);
        if(paginas.count > 1){
            setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.forward , animated: false, completion: nil);
        }else if(paginas.count == 1){
            setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.forward , animated: false, completion: nil);
            for view in self.view.subviews{
                if view is UIScrollView{
                    let vv = (view as! UIScrollView);
                    vv.isScrollEnabled = false;
                }
            }
        }else{
            for view in self.view.subviews{
                if view is UIScrollView{
                    let vv = (view as! UIScrollView);
                    vv.isScrollEnabled = false;
                }
            }
            /*
            for pag in paginas{
                print("pag: ", pag);
               
                for view in pag.view.subviews {
                    
                    if (view is UIScrollView ) {
                        let vv = (view as! UIScrollView);
                        vv.scrollEnabled = false;
                    }
                }
            }
            */
        }

    }
    
    //Método que calcula el tamaño de los productos de la alacena
    func frameProducto()-> CGRect{
        
        return CGRect(x: 0, y: 0, width: ancho, height: alto);
    }
    
    //Método que permite establecer la posición de las casillas y los productos en la página de la alacena manteniendo 
    //la configuración de un máximo de 6 productos en dos filas
    func seteProductos(_ elementos: [ProductoView])->[Casilla]{
        var casillas=[Casilla]();
        var p=CGFloat(0);
        var m = CGFloat(0);
        var fila = CGFloat(0);
        //print("elementos: ", elementos.count);
        for ele in elementos{
            let casill=Casilla();
            if(m>=CGFloat(cant)){
                fila+=1
                p=0;
                m=0;
            }
            
            casill.activo = false;
            ele.padre=casill;
            ele.espacio=self.Panel!.view;
            ele.Panel2=self.Panel?.lonch
            casill.seteaElemento(ele, tipo: self.tipo!, ima: ele.producto!.imagen!, prod: ele.producto!);
            ///////
            
            ///////
            if(ele.producto?.salud==true){// COlor de los subpaneles
                //casill.backgroundColor=UIColor.orangeColor();
            }else{
                //casill.backgroundColor=UIColor.whiteColor();
            }
            //casill.frame=pos;
            let precio = String(ele.producto!.precio);
            casill.iniciaPrecio(precio);
            casill.addSubview(casill.precio!);
            casill.bringSubview(toFront: casill.precio!);
            m+=1;
            //ele.PanelOrigen=vistas[contadorVistas].view;
            casillas.append(casill);
            //print("prod: ",casill.frame);
            p += 1;
            
        }
        
        return casillas;
    }
    
    //Método que calcula el ancho de las casillas
    func CGAncho()->CGFloat{
        var divancho :Float;
        divancho=1/Float(cant);
        let anchoP:Int;
        anchoP=Int(self.view.frame.width)
        let ancho = Float(Float(anchoP)*divancho)-(Float(borde));
        var CGAncho=CGFloat(ancho);
        let espaciado = ancho*0.05;
        CGAncho=CGAncho-CGFloat(espaciado);
        return CGAncho;
    }
    
    // Método que pone el fondo del panel de acuerdo al tipo de productos que va a mostrar
    func FondoPanel(_ vista: UIViewController){
        for vista in self.view.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        var imagen: UIImage;
        //print("SSSS: ", self.tipo);
        switch Int(self.tipo!){
        case 1:
            imagen = UIImage(named: "BKGEne")!;
            break;
        case 2:
            imagen = UIImage(named: "BKGVit")!;
            break;
        case 3:
            imagen = UIImage(named: "BKGCre")!;
            break;
        case 4:
            imagen = UIImage(named: "BKGBeb")!;
            break;
        default:
            imagen = UIImage(named: "CasillaVerde")!;
            break;
        }
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (DatosC.contenedor.altoP*0.78));
        let backImg = UIImageView(frame: frame);
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
        vista.view.addSubview(backImg);
        vista.view.sendSubview(toBack: backImg);
    }
    
    //Método que pinta la información con el panel que acompaña el producto debajo de él
    func panelInfo(_ cas : Casilla, salud: Bool){
        let frame = CGRect(x: 0, y: cas.frame.height, width: cas.frame.width, height: DatosC.contenedor.altoP*0.07);
        let panel = UIView(frame: frame);
        var imagen: UIImage;
        var barra: UIImage;
        if(salud){
            imagen = UIImage(named: "LabelNoSaludable")!;
            barra = UIImage(named: "lineaVerde")!;
        }else{
            imagen = UIImage(named: "LabelNoSaludable")!;
            barra = UIImage(named: "lineaGris")!;
        }
        let frameBack = CGRect(x: 0, y: 0, width: panel.frame.width, height: panel.frame.height);
        let backImg = UIImageView(frame: frameBack);
        backImg.image = imagen;
        if(salud){
            subImagen(backImg);
        }
        panel.addSubview(backImg);
        let frameBarra = CGRect(x: cas.frame.width*0.1, y: frame.height/2, width: cas.frame.width*0.8, height: 3);
        let backImg2 = UIImageView(frame: frameBarra);
        backImg2.image=barra;
        backImg2.contentMode=UIViewContentMode.scaleAspectFit;
        //backImg2.backgroundColor=UIColor.redColor();
        panel.addSubview(backImg2);
        let framePrecio = CGRect(x: 0, y: 5, width: panel.frame.width, height: panel.frame.height/2);
        let ox = (panel.frame.width/2)-(panel.frame.width/2)
        let frameCalorias = CGRect(x: ox, y: panel.frame.height/2, width: panel.frame.width, height: panel.frame.height/2);
        //let precio = "$"+String(cas.elemeto!.producto!.precio);
        var calorias = "";
        for cal in (cas.elemeto?.producto?.listaDatos)!{
            if(cal.id == 1){
                calorias = String(Int(cal.valor));
            }
        }
        let Lab1 = UILabel(frame: framePrecio);
        let formateadorPrecio = NumberFormatter();
        formateadorPrecio.numberStyle = .currency;
        formateadorPrecio.locale = Locale(identifier: "es_CO");
        
        Lab1.text = formateadorPrecio.string(from: cas.elemeto!.producto!.precio as! NSNumber)!;
        let Lab2 = UILabel(frame: frameCalorias);
        
        Lab2.text = calorias + " calorías";
        Lab1.textAlignment = NSTextAlignment.center;
        Lab2.textAlignment = NSTextAlignment.center;
        Lab1.font=UIFont(name: "SansBeam Head", size: Lab1.frame.height/1.2)!;
        Lab2.font=UIFont(name: "SansBeamBody-Heavy", size: Lab2.frame.height/1.8)!;
        //Lab2.backgroundColor=UIColor.redColor();
        Lab1.adjustsFontSizeToFitWidth=true;
        Lab2.adjustsFontSizeToFitWidth=true;
        if(salud){
            Lab1.textColor = UIColor.gray;
            Lab2.textColor = UIColor.gray;
        }else{
            Lab1.textColor = UIColor.gray;
            Lab2.textColor = UIColor.gray;
        }
        panel.addSubview(Lab1);
        panel.addSubview(Lab2);
        //print("pan frame: ",panel.frame);
        //panel.sendSubviewToBack(backImg);
        cas.addSubview(panel);
        
    }
    
    func pintaEstante(_ fila : CGFloat, frameRef: CGRect, vista : UIViewController, espaciado: CGFloat){
        let fila2 = fila + CGFloat(1);
        let desface = DatosC.contenedor.altoP*0.04;
        let posE = CGRect(x: 0, y: (((frameRef.height)*fila2)+(espaciado*fila))-desface+(borde*4), width: DatosC.contenedor.anchoP, height: DatosC.contenedor.altoP*0.27);
        //print("FF", frameRef);
        //print("PosE", posE);
        let estante = UIView(frame: posE);
        var imagen: UIImage;
        let frameBack = CGRect(x: 0, y: 0, width: estante.frame.width, height: estante.frame.height);
        switch (self.tipo!) {
        case 1:
            imagen = UIImage(named: "Shelf Energia")!;
            break;
        case 2:
            imagen = UIImage(named: "Shelf Vitaminas")!;
            break;
        case 3:
            imagen = UIImage(named: "Shelf Crecimiento")!;
            break;
        case 4:
            imagen = UIImage(named: "Shelf Bebidas")!;
            break;
        default:
            imagen = UIImage(named: "LabelSaludable")!;
            break;
        }
        let backImg = UIImageView(frame: frameBack);
        backImg.image = imagen;
        
        estante.addSubview(backImg);
        //estante.backgroundColor = UIColor.yellowColor();
        vista.view.addSubview(estante);
    }
    
    //Método que permite cambiar de pestaña
    /*
    func rotaPestaña(adelante: Bool){
        var direccion = UIPageViewControllerNavigationDirection.Forward;
        var pos = control!.currentPage;
        print("pos: ",pos);
        if(adelante){
            pos += 1;
            if(pos>=paginas.count){
                pos=0;
            }
        }else{
            pos -= 1;
            if(pos < 0){
                pos = paginas.count-1;
            }
            direccion = UIPageViewControllerNavigationDirection.Reverse;
        }
        print("direc: ", adelante);
        print("pos: ",pos);
        print("tama max: ",paginas.count);
        setViewControllers([paginas[pos]], direction: direccion , animated: true, completion: nil);
        control?.currentPage=pos;
    }
    */
    //Método que inicia la casilla de referencia
    func iniciaCasillaBaja(_ vista: UIView){
        let casillaBaja = UIButton();
        //let casillaBaja2 = UIView();
        let ancho = CGFloat(DatosC.contenedor.anchoP*0.8);
        let alto = CGFloat(DatosC.contenedor.altoP*0.5);
        let OX = CGFloat((DatosC.contenedor.anchoP/2)-(ancho/2));
        //let OY = (espacioIntercambio.frame.height/2)-(alto/2);
        let OY = (DatosC.contenedor.altoP*(0.6));
        let frameCasilla = CGRect(x: OX, y: OY, width: ancho, height: alto);
        //let frameCasilla2 = CGRectMake(OX+10, OY+10, ancho, alto);
        casillaBaja.frame=frameCasilla;
        casillaBaja.addTarget(self, action: #selector(Panel!.devuelve(_:)), for: .touchDown);
        casillaBaja.layer.zPosition=1;
        //casillaBaja2.frame=frameCasilla2;
        //casillaBaja.tipo=DatosC.contenedor.tipo;
        //casillaBaja.activo=false;
        //casillaBaja.setFondo(true);
        DatosB.cont.poneFondoTot(casillaBaja, fondoStr: "LoncheraVERDE", framePers: nil, identi: nil, scala: true);
        //ondoCasilla(casillaBaja);
        //fondoCasilla(casillaBaja2);
        vista.addSubview(casillaBaja);
        //self.view.addSubview(casillaBaja2);
        //espacioIntercambio.bringSubviewToFront(casillaBaja);
        //self.view.sendSubviewToBack(casillaBaja);
        //casillaBaja.layer.zPosition = 1 ;
        //casillaBaja2.layer.zPosition = 3 ;
        //print("FOND: ", casillaBaja.layer.zPosition);
    }
    
    //Método que pone el fondo de la casilla baja
    func fondoCasilla(_ cas: UIView){
        let imagen = UIImage(named: "LoncheraVERDE");
        let frameF = CGRect(x: 0, y: 0, width: cas.frame.width, height: cas.frame.height);
        let backImg = UIImageView(frame: frameF);
        backImg.image = imagen;
        cas.addSubview(backImg);
        cas.sendSubview(toBack: backImg);
    }
    
    func cargaImagen(_ prod: Producto){
        let hilo = DispatchQueue.GlobalQueuePriority.default;
        DispatchQueue.global(priority: hilo).async {
            
        }
    }
    
    func devuelve(_ sender: UIButton){
        print("Devuelve");
        Panel!.devuelve(sender);
    }
    
    //Método que permite poner la hojita en las saludables
    func subImagen(_ vista : UIView){
        let ancho = vista.frame.width*0.3;
        let OX = vista.frame.width-(ancho/2);
        let OY = -(ancho/2)
        let frame = CGRect(x: OX, y: OY, width: ancho, height: ancho);
        let subVista = UIView(frame: frame);
        DatosB.cont.poneFondoTot(subVista, fondoStr: "Hoja Verde", framePers: nil, identi: nil, scala: true);
        vista.addSubview(subVista);
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
