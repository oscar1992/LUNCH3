//
//  PantallaP.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class PantallaP: UIViewController {
    
    @IBOutlet weak var BotonAnadir: BotonNino!
    @IBOutlet weak var LaBarra: UIView!
    var cantBotones=1;
    var anchoP:CGFloat!;
    var altoP:CGFloat!;
    var espaciado:CGFloat!;
    var botones=[BotonNino]();
    var posee = false;
    var nin:Ninos?;
    var saludables = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //consume();
        //print("inicia");
        self.anchoP=UIScreen.mainScreen().bounds.width;
        self.altoP=UIScreen.mainScreen().bounds.height;
        self.espaciado=anchoP*0.01;
        //print("ancho: ",anchoP);
        DatosC.contenedor.anchoP=anchoP;
        
        DatosC.contenedor.altoP=altoP;
        //ordenaBoton();
        
        DatosC.contenedor.Pantallap=self;
        
        //BotonAnadir.enabled=false;
        
        //botones+=[BotonAnadir];
        BotonAnadir.addTarget(self, action: #selector(PantallaP.Anade(_:)), forControlEvents: .TouchDown);
        

        if(DatosD.contenedor.padre.primeraVez == true && DatosD.contenedor.ninos.count == 0){
            //print("comom nuevo!");
        }else{
            
            posee=true;
            //print("ninos: ",DatosD.contenedor.ninos.count);
            for nino in DatosD.contenedor.ninos{
                anadeNinos(nino);
            }
            ordenaBoton2();
            DatosC.contenedor.ninos.last?.cambia();
            DatosC.contenedor.ninos=botones;
        }
        
        
        botonMenu();
        botonAñadir();
        //leefuentes();
        
    }
    
    //Método que se ejecuta antes de la aparición de la pantallaP y que carga los productos en las cajas predeterminadas
    override func viewWillAppear(animated: Bool) {
        check_consumo();
        DatosC.contenedor.Check();
        //print("Va a anidar?")
        if(DatosC.contenedor.lleno&&DatosC.contenedor.primera==false){
            //Anida objs
            //print("Anida?");
            DatosC.contenedor.primera=true;
            for caja in DatosC.contenedor.cajas{
                
                for secu in DatosC.contenedor.secuencia{
                    if(secu.caja==caja.id){
                        //print("secu", secu.nombre);
                        var sublista=[TItems]();
                        for titem in DatosC.contenedor.titems{
                            
                            //print(titem.Combinacion," eq ",secu.id);
                            /*if(titem.Combinacion==secu.id){
                                //print("titem-m: ",titem.productos?.nombre);
                                
                                for prod in DatosC.contenedor.productos{
                                    if(prod.id==titem.idProducto){
                                        titem.productos=prod;
                                        //print("prod: ",titem.productos?.nombre);
                                    }
                                }
                                sublista.append(titem);
                                
                            }*/
                            //print("titem", titem.productos?.id);
                        }
                        secu.lista=sublista;
                        caja.secuencia.append(secu);
                    }
                }
            }
        }
        setFondo2();
        if(saludables == false){
            poneSaludables();
            saludables = true;
        }
        
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Método que
    func anadeNinos(ninoe: Ninos?){
        /*
        var nino = ninoe;
        if(nino == nil){
            nino=DatosD.contenedor.ninos.last;
        }
        
        let nBoton=BotonNino();
               nBoton.activo=true;
        
        
        nBoton.nombreNino=nino!.nombre;
        
        //print("NNNNombre: ",nBoton.nombreNino);
        nBoton.fecha=nino!.fechaNacimiento;
        //nBoton.backgroundColor=UIColor.greenColor();
        if(nino!.genero == "F"){
            nBoton.genero=false;
        }else{
            nBoton.genero=true;
        }
        
        */
        let nBoton=BotonNino();
        nBoton.activo=true;
        nBoton.nombreNino=ninoe!.nombre;
        nBoton.fecha=ninoe!.fechaNacimiento;
        nBoton.nino=ninoe;
        botones.append(nBoton);
        if(ninoe!.genero == "F"){
            nBoton.genero=false;
        }else{
            nBoton.genero=true;
        }
        DatosC.contenedor.ninos.append(nBoton);
        print("Tama: ", DatosC.contenedor.ninos.count);
    }
    
    //Método despreciado
    func Anade(sender: AnyObject) {
        //anadeNinos(nil);
        /*
        DatosC.contenedor.ninos.last?.cambia();
        let botonN = BotonNino();
        cantBotones+=1;
        botones+=[botonN];
        botonN.backgroundColor=UIColor.lightGrayColor();
        botonN.activo=false;
        
        self.view.addSubview(botonN);
        let panelNino=VistaNino(frame: CGRectMake(0,(200+(LaBarra.frame.height+LaBarra.frame.origin.y)),anchoP,(altoP-botonN.frame.height)));
        
        botonN.panelNino=panelNino;
        if(posee){
            //botonN.nombreNino=(sender as! Ninos).nombre;
        }
        panelNino.padre=botonN;
        panelNino.backgroundColor=UIColor.init(colorLiteralRed: 1, green: 0.89, blue: 0.77, alpha: 1);
        panelNino.titulo.text?.appendContentsOf(String(cantBotones));
        self.view.addSubview(panelNino);
        DatosC.contenedor.ninos+=[botonN];
        ordenaBoton2();
         */
    }
    
    func ordenaBoton(){
        let mitadC = ((BotonAnadir.frame.width*CGFloat(cantBotones))+CGFloat(espaciado+CGFloat(cantBotones-1)))/2;
        let pini=(anchoP/2)-mitadC;
        let anchoT=BotonAnadir.frame.width+espaciado;
        var itera=0;
        print("pini",pini);
        for btn in botones{
            //print("btn: ",btn.restorationIdentifier);
            btn.frame=CGRectMake((pini+(anchoT*CGFloat(itera))), BotonAnadir.frame.origin.y, BotonAnadir.frame.width, BotonAnadir.frame.height);
            
            itera+=1;
        }
        
        /*
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                
                btn.frame.origin.x=CGFloat();
            }
        }
         */
    }
    
    //Método que organiza las pestañas de los niños
    func ordenaBoton2(){
        for vista in self.view.subviews{
            if vista is VistaNino{
                //print("CUANTOS", vista.superview);
                vista.backgroundColor = UIColor.blueColor();
                vista.removeFromSuperview();
                //vista.hidden=true;
            }
        }
        
        let anchoMax=DatosC.contenedor.anchoP * 0.6;
        let anchoBnino=anchoMax/CGFloat(DatosD.contenedor.ninos.count);
        //print("AnchoBnino: ",anchoBnino);
        let altoBnino=DatosC.contenedor.altoP * 0.0427;
        var p=CGFloat(0);
        let totalnini=(DatosC.contenedor.anchoP/2) - (CGFloat((CGFloat(DatosD.contenedor.ninos.count)*anchoBnino)/2));
        
        //print("Totalini: ",totalnini);
        for bnino in botones{
            //print("OX: ",((totalnini)));
            //print("WW: ", (LaBarra.frame.origin.y+LaBarra.frame.height))
            let frame = CGRectMake((p*(anchoBnino)+totalnini), (LaBarra.frame.origin.y+LaBarra.frame.height), anchoBnino, altoBnino);
            
            
            bnino.frame=frame;
            //print("cc: ",bnino.nombreNino);
            for vista in bnino.subviews{
                print("Inside: ", vista);
                if vista is UILabel{
                    vista.removeFromSuperview();
                }
            }
            let lab = UILabel(frame: CGRectMake(0, 0, bnino.frame.width, bnino.frame.height));
            
            lab.font = UIFont(name: "SansBeam Head", size: 18);
            
            lab.textColor = UIColor.whiteColor();
            lab.text = bnino.nombreNino;
            lab.textAlignment = NSTextAlignment.Center;
            bnino.addSubview(lab);
            p += 1;
            self.view.addSubview(bnino);
            let panelNino=VistaNino(frame: CGRectMake(0,(bnino.frame.height+bnino.frame.origin.y),anchoP,(altoP-bnino.frame.height)));
            //panelNino.backgroundColor=UIColor.redColor();
            bnino.panelNino=panelNino;
            self.view.addSubview(panelNino);
            //bnino.cambia();
        }
    }
    
    /*
    func consume(){
        let cargaI=ConsultaProductos();
        let cargaII=CargaTItems();
        let cargaIII=CargaSecuencia();
        let cargaIV=CargaCajas();
        
        cargaI.consulta();
        cargaII.CargaTItems();
        cargaIII.CargaSecuencia();
        cargaIV.CargaCajas();
        
    }
    */
    func check_consumo(){
        //print("CHECK:");
        
        /*
        for caja in DatosC.contenedor.cajas{
            //print("caja: ",caja.Nombre);
        }
        for secu in DatosC.contenedor.secuencia{
            //print("Secuencia: ",secu.id);
        }
        for titem in DatosC.contenedor.titems{
            //print("TItem: ",titem.Combinacion);
        }
 
        for prod in DatosC.contenedor.productos{
            
            print("Prod: ", prod.listaDatos.count, " || ", prod.id);
        }
         */
        
    }
    
    //Método que establece el fondo de desta vista
    func setFondo2(){
        let fondo = UIImage(named: "FondoHome");
        let backImg = UIImageView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.width,UIScreen.mainScreen().bounds.height));
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = fondo;
        self.view.addSubview(backImg);
        self.view.sendSubviewToBack(backImg);
    }
    
    //Método que inicializa el botón del menú lateral
    func botonMenu(){
        let ancho = DatosC.contenedor.altoP * 0.0922;
        let frameboton = CGRectMake(0, LaBarra.frame.origin.y, ancho, ancho);
        let frameFondo = CGRectMake(ancho/3, ancho/3, ancho*0.3, ancho*0.3);
        //print("Boton", frameboton);
        let BotonMenu = UIButton(frame: frameboton);
        let fondo = UIImage(named: "MenuLat");
        let backImg = UIImageView(frame: frameFondo);
        BotonMenu.backgroundColor = UIColor.redColor();
        backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = fondo;
        BotonMenu.addSubview(backImg);
        BotonMenu.sendSubviewToBack(backImg);
        self.view.addSubview(BotonMenu);
    }
    //Método que inicializa el boton de añadir
    func botonAñadir(){
        
        let frameBotAnadir = CGRectMake(DatosC.contenedor.anchoP*0.884, (LaBarra.frame.origin.y+LaBarra.frame.height), DatosC.contenedor.anchoP*0.116, DatosC.contenedor.anchoP*0.2);
        BotonAnadir.frame = frameBotAnadir;
        let fondo = UIImage(named: "Agrega");
        let frameFondo = CGRectMake(0, 0, frameBotAnadir.width, frameBotAnadir.height*0.6);
        let backImg = UIImageView(frame: frameFondo);
        backImg.image = fondo;
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        self.BotonAnadir.addSubview(backImg);
        self.BotonAnadir.sendSubviewToBack(backImg);
        
    }
    
    //Mètodo que oculta la barra en este viewcontroller
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func leefuentes(){
        let ff = UIFont.familyNames();
        for nn in ff{
            print(nn);
        }
    }
    
    func poneSaludables(){
        for nino in DatosC.contenedor.ninos{
            
            let lon = nino.panelNino.Lonchera.deslizador.paginas.first;
            let bot = UIButton();
            
            for caja in DatosC.contenedor.cajas{
                //print("salu?.", caja.id);
                if (caja.id == 1){
                    //for secu in caja.secuencia{
                    //print("Secu: ", secu);
                    for _ in (caja.secuencia.first?.lista)!{
                        //print("tit: ", tit.productos?.nombre);
                    }
                    //}
                    //print("caja: ", caja.secuencia.first?.lista.count);
                    //print("lonchera: ", lon?.subVista?.casillas.count);
                    
                    
                    if(caja.secuencia.first?.lista.count>lon?.subVista?.casillas.count){
                        let cuantas = (caja.secuencia.first?.lista.count)!-(lon?.subVista?.casillas.count)!;
                        for _ in 0 ... cuantas{
                            lon?.addcasilla(bot);
                        }
                    }
                    
                    var p = 0;
                    //print("Tama: ", caja.secuencia.first?.lista);
                    if(caja.secuencia.first != nil){
                        for item in (caja.secuencia.first?.lista)!{
                            let framePV = CGRectMake(0, 0, (lon?.subVista?.casillas.first?.frame.width)!, (lon?.subVista?.casillas.first?.frame.height)!);
                            let pv = ProductoView(frame: framePV, imagen: (item.productos?.imagen)!);
                            pv.tipo=(item.productos?.tipo)!;
                            //print(pv.tipo);
                            lon?.subVista?.casillas[p].seteaElemento(pv, tipo: (item.productos?.tipo)!, ima: (item.productos?.imagen)!, prod: item.productos!);
                            p += 1;
                        }
                    }
                    
                }
            }
        }
    }
}
