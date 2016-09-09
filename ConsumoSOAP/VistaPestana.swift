
//
//  VistaPestana.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 20/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaPestana: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    var paginas = [UIViewController]();
    var tipo:Int!;
    var control:UIPageControl?;
    var Panel:PantallaSV?;
    let cant = 3; // Items por estante
    let borde = CGFloat(DatosC.contenedor.anchoP*0.09)/2;
    
    //var vistas = [UIViewController]();
    var contadorVistas = 0;
    let ancho = CGFloat(DatosC.contenedor.anchoP*0.27);
    let alto = CGFloat(DatosC.contenedor.altoP*0.19);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self;
        self.dataSource=self;
        self.Panel=DatosC.contenedor.pantallaSV;
        //cargaPaginascategoria();
        //carga();
        //setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
        self.view.backgroundColor=UIColor.yellowColor();
        
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
                self.view.bringSubviewToFront(subView)
            }
        }
        control?.currentPage=0;
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        
        
        if(paginas.count==1){
            return nil;
        }else{
            let currentIndex = control?.currentPage;
            var previousIndex = abs((currentIndex! - 1) % paginas.count);
            
            let actual = control?.currentPage;
            //print("acc: ", actual);
            if(actual <= 0 || paginas[actual!] == NSNotFound){
                //print("pre-reduce: ", actual);
                previousIndex = paginas.count-1;
                //print("reduce: ", previousIndex);
            }
            //print("prev: ", previousIndex);
            return paginas[previousIndex];
        }
        //let currentIndex = paginas.indexOf(viewController)!;
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = paginas.indexOf(viewController)!;
        let nextIndex = abs((currentIndex + 1) % paginas.count);
        return paginas[nextIndex];
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return paginas.count;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
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
                    if(prod.categoria == categoria.id){
                        //print("PRDO: ",prod.nombre, " cccc ", prod.categoria);
                        let pv=ProductoView(frame: frameProducto(), imagen: prod.imagen);
                        pv.producto=prod;
                        pv.tipo=self.tipo;
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
                        let Label=UILabel(frame: CGRectMake(0,0, 100, 30));
                        Label.text=String(CGFloat(paginas.count));
                        vistaInt.view.addSubview(Label)
                        //vistas.append(vistaInt);
                        vistaInt.view.frame=self.view.frame;
                        iniciaCasillaBaja(vistaInt.view);
                        contadorVistas += 1;
                        paginas.append(vistaInt);
                    }else if(p >= 6){
                        //print("se pasa: ", p);
                        p = 0;
                        fila = 0;
                        m = 0
                        p2 = 0;
                        vistaInt=UIViewController();
                        FondoPanel(vistaInt);
                        let Label=UILabel(frame: CGRectMake(0,0, 100, 30));
                        Label.text=String(CGFloat(paginas.count));
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
                    let pos2=CGRectMake((borde+(p2*(self.ancho+espaciado2))), ((fila*(self.alto+espaciado3))), ancho, alto);
                    //print("framecas: ",pos2)
                    casi.frame = pos2;
                    if(m == 0 || m % 3 == 0){
                        //print("pinta?");
                        pintaEstante(fila, frameRef: pos2, vista: vistaInt, espaciado: espaciado3);
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
        setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
        //print("ccss: ", paginas.count);
        if(paginas.count > 1){
            
        }else{
            for view in self.view.subviews{
                if view is UIScrollView{
                    let vv = (view as! UIScrollView);
                    vv.scrollEnabled = false;
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
        
        return CGRectMake(0, 0, ancho, alto);
    }
    
    //Método que permite establecer la posición de las casillas y los productos en la página de la alacena manteniendo 
    //la configuración de un máximo de 6 productos en dos filas
    func seteProductos(elementos: [ProductoView])->[Casilla]{
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
            casill.seteaElemento(ele, tipo: self.tipo!, ima: ele.producto!.imagen, prod: ele.producto!);
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
            casill.bringSubviewToFront(casill.precio!);
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
    func FondoPanel(vista: UIViewController){
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
        let frame = CGRectMake(0, 0, self.view.frame.width, (DatosC.contenedor.altoP*0.78));
        let backImg = UIImageView(frame: frame);
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
        vista.view.addSubview(backImg);
        vista.view.sendSubviewToBack(backImg);
    }
    
    //Método que pinta la información con el panel que acompaña el producto debajo de él
    func panelInfo(cas : Casilla, salud: Bool){
        let frame = CGRectMake(0, cas.frame.height, cas.frame.width, DatosC.contenedor.altoP*0.07);
        let panel = UIView(frame: frame);
        var imagen: UIImage;
        var barra: UIImage;
        if(salud){
            imagen = UIImage(named: "LabelSaludable")!;
            barra = UIImage(named: "lineaGris")!;
        }else{
            imagen = UIImage(named: "LabelNoSaludable")!;
            barra = UIImage(named: "lineaVerde")!;
        }
        let frameBack = CGRectMake(0, 0, panel.frame.width, panel.frame.height);
        let backImg = UIImageView(frame: frameBack);
        backImg.image = imagen;
        panel.addSubview(backImg);
        let frameBarra = CGRectMake(0, frame.height/2, frame.width, 2);
        let backImg2 = UIImageView(frame: frameBarra);
        //backImg2.backgroundColor=UIColor.redColor();
        panel.addSubview(backImg2);
        let framePrecio = CGRectMake(0, 5, panel.frame.width, panel.frame.height/2);
        let frameCalorias = CGRectMake(0, panel.frame.height/2, panel.frame.width, panel.frame.height/2);
        //let precio = "$"+String(cas.elemeto!.producto!.precio);
        var calorias = "";
        for cal in (cas.elemeto?.producto?.listaDatos)!{
            if(cal.id == 1){
                calorias = String(Int(cal.valor));
            }
        }
        let Lab1 = UILabel(frame: framePrecio);
        let formateadorPrecio = NSNumberFormatter();
        formateadorPrecio.numberStyle = .CurrencyStyle;
        formateadorPrecio.locale = NSLocale(localeIdentifier: "es_CO");
        
        Lab1.text = formateadorPrecio.stringFromNumber(cas.elemeto!.producto!.precio)!;
        let Lab2 = UILabel(frame: frameCalorias);
        
        Lab2.text = calorias + " calorías";
        Lab1.textAlignment = NSTextAlignment.Center;
        Lab2.textAlignment = NSTextAlignment.Center;
        Lab1.font=UIFont(name: "SansBeam Head", size: Lab1.frame.height*0.8)!;
        Lab2.font=UIFont(name: "SansBeamBody-Heavy", size: Lab2.frame.height*0.3)!;
        if(salud){
            Lab1.textColor = UIColor.whiteColor();
            Lab2.textColor = UIColor.whiteColor();
        }else{
            Lab1.textColor = UIColor.grayColor();
            Lab2.textColor = UIColor.grayColor();
        }
        panel.addSubview(Lab1);
        panel.addSubview(Lab2);
        //print("pan frame: ",panel.frame);
        //panel.sendSubviewToBack(backImg);
        cas.addSubview(panel);
        
    }
    
    func pintaEstante(fila : CGFloat, frameRef: CGRect, vista : UIViewController, espaciado: CGFloat){
        let fila2 = fila + CGFloat(1);
        let desface = DatosC.contenedor.altoP*0.04;
        let posE = CGRectMake(0, (((frameRef.height)*fila2)+(espaciado*fila))-desface, DatosC.contenedor.anchoP, DatosC.contenedor.altoP*0.27);
        //print("FF", frameRef);
        //print("PosE", posE);
        let estante = UIView(frame: posE);
        var imagen: UIImage;
        let frameBack = CGRectMake(0, 0, estante.frame.width, estante.frame.height);
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
    
    //Método que inicia la casilla de referencia
    func iniciaCasillaBaja(vista: UIView){
        let casillaBaja = UIView();
        //let casillaBaja2 = UIView();
        let ancho = CGFloat(DatosC.contenedor.anchoP*0.27);
        let alto = CGFloat(DatosC.contenedor.altoP*0.13);
        let OX = CGFloat((DatosC.contenedor.anchoP/2)-(ancho/2));
        //let OY = (espacioIntercambio.frame.height/2)-(alto/2);
        let OY = (DatosC.contenedor.altoP*(0.733))-(alto);
        let frameCasilla = CGRectMake(OX, OY, ancho, alto);
        //let frameCasilla2 = CGRectMake(OX+10, OY+10, ancho, alto);
        casillaBaja.frame=frameCasilla;
        //casillaBaja2.frame=frameCasilla2;
        //casillaBaja.tipo=DatosC.contenedor.tipo;
        //casillaBaja.activo=false;
        //casillaBaja.setFondo(true);
        fondoCasilla(casillaBaja);
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
    func fondoCasilla(cas: UIView){
        let imagen = UIImage(named: "CasillaBaja");
        let frameF = CGRectMake(0, 0, cas.frame.width, cas.frame.height);
        let backImg = UIImageView(frame: frameF);
        backImg.image = imagen;
        cas.addSubview(backImg);
        cas.sendSubviewToBack(backImg);
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
