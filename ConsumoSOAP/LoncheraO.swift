//
//  LoncheraO.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 14/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class LoncheraO: UIViewController {

    var id:Int?;
    var label:UILabel?;
    var botadd:UIButton?;
    var botrem:UIButton?;
    var subVista:SubVista?;
    var padre:VistaLonchera?;
    var contador : Contador?;
    var fecha: Date?;
    var fechaVisible: UILabel?;
    var saludable:Bool?;
    var botfavo:UIButton?;
    var color: Int?;
    var nfavorita: Int?;
    var msg:UILabel?;
    var cuadromsg:UIView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func inicia() {
        
        subVista = SubVista();
        subVista!.padre=self.view;
        botrem=UIButton();
        botrem?.titleLabel?.text="REM";
        saludable = true;
        botrem?.addTarget(self, action: #selector(self.remcasilla(_:)), for: .touchDown);
        botadd=UIButton();
        botfavo=UIButton();
        botadd!.addTarget(self, action: #selector(self.addcasilla(_:)), for: .touchDown);
        botfavo!.addTarget(self, action: #selector(self.anadeFavorito(_:)), for: .touchDown);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ordena(){
        iniciaBotonAdd();
        iniciaBotonFav();
        iniciaBotonResta();
        let ancho=self.view.frame.width*0.78;
        
        let alto=(DatosC.contenedor.altoP*0.1331);
        let alto2=DatosC.contenedor.altoP*0.36;
        
        let OX=(self.view.frame.width/2)-(ancho/2);
        let OY=(self.view.frame.origin.y)+(alto);
        //print("OX ->",((self.view.frame.width/2)-(ancho/2)));
        subVista?.frame=CGRect(x: OX, y: OY, width: ancho, height: alto2);
        //subVista?.backgroundColor=UIColor.purpleColor();
        DatosC.contenedor.tamaLonchera=CGRect(x: OX, y: OY, width: ancho, height: alto2);
        //print("Tama Lonchera: ",DatosC.contenedor.tamaLonchera );
        self.view.addSubview(subVista!);
        //let BAOX=(OX+ancho);
        //let BAOY=(OY);
        //let Bancho=(self.view.frame.width*0.1);
        //let Balto=(alto*0.3);
        //botadd?.frame=CGRectMake(BAOX, BAOY, Bancho, Balto);
        //botadd!.backgroundColor=UIColor.brownColor();
        //self.view.addSubview(botadd!);
        //let BROY=(OY+Balto);
        //botrem?.frame=CGRectMake(BAOX, BROY, Bancho, Balto);
        //botrem?.backgroundColor=UIColor.blueColor()
        //botfavo?.frame=CGRectMake(BAOX, BROY, Bancho, Balto);
        //botfavo?.backgroundColor = UIColor.yellowColor();
        //self.view.addSubview(botfavo!);
        inciaContador();
        self.view.bringSubview(toFront: botfavo!);
        self.view.bringSubview(toFront: botadd!);
        self.view.bringSubview(toFront: botrem!);
        self.view.addSubview(contador!);
        
    }
    
    func inicia(_ id: Int){
        
        ordena();
        self.id=id;
        self.label=UILabel();
        self.label!.text=("Id: "+String(id));
        self.label!.frame=CGRect(x: 5, y: 5, width: 100, height: 20);
        //self.view.addSubview(self.label!);
        self.subVista?.crea();
        fechaActual(self.id!);
        let yFEcha = DatosC.contenedor.altoP*0.0239;
        let anchoFecha = DatosC.contenedor.anchoP*0.24;
        let altoFecha = DatosC.contenedor.altoP*0.04;
        fechaVisible?.frame=CGRect(x: 0, y: yFEcha, width: anchoFecha,height: altoFecha);
        fondoFecha();
        self.view.addSubview(fechaVisible!);
        
    }
    

    
    func addcasilla(_ button: UIButton){
        //limpia();
        print("ID: ", self.id);
        if(self.subVista!.campos<6){
            //print("Campos: ",self.subVista!.campos);
            self.subVista!.campos+=1;
            self.subVista!.text();
            self.subVista?.crea();
        }
        /*
        for cc in (self.subVista?.casillas)!{
            print("cc: ", cc.elemeto?.producto?.nombre);
        }*/
        //print(self.subVista!.campos);
    }
    
    func remcasilla(_ button: UIButton){
        //limpia();
        if(self.subVista?.casillas.last?.elemeto != nil){
            print("No nulo");
            
        }else{
            if(self.subVista!.campos>4){
                self.subVista!.campos-=1
                self.subVista!.text();
                self.subVista?.crea();
            }
        }
        
        //print(self.subVista!.campos);
    }
    
    func limpia (){
        if((self.subVista?.casillas.isEmpty) != nil){
            for cas in (self.subVista?.casillas)!{
                cas.elemeto?.elimina();
            }
        }else{
            
            
        }
    }
    
    //Método que muestra la fecha actual por lonchera
    func fechaActual(_ id: Int){
        let fecha=Date();
        var fechac=DateComponents();
        let calendar=Calendar.current;
        let añoS=(calendar as NSCalendar).components(.year , from: fecha);
        let mesS=(calendar as NSCalendar).components(.month , from: fecha);
        let diaS=(calendar as NSCalendar).components(.day , from: fecha);
        let diaSemana=(calendar as NSCalendar).components(.weekday, from: fecha);
        let rest = diaSemana.weekday! - (id+1); // Corrimiento de Inicio de semana
        
        
        fechac.year=añoS.year;
        fechac.month=mesS.month;
        fechac.day=(diaS.day!-rest)+7;//Asignación de una semana más
        
        
        let fechaf=Calendar.current.date(from: fechac);
        self.fecha=fechaf;
        
        //print("num día: ", diaS.year);
        let formateadpr:DateFormatter=DateFormatter();
        formateadpr.locale = Locale.init(identifier: "es_CO");
        formateadpr.dateFormat = "EEE dd/MM/yy";
        fechaVisible=UILabel();
        fechaVisible?.text=(formateadpr.string(from: fechaf!).uppercased());
        fechaVisible?.textAlignment = NSTextAlignment.right;
        fechaVisible?.font = UIFont(name: "SansBeam Head", size: 18);
        fechaVisible?.textColor = UIColor.white;
       
    }
    
    //Método que permite cambiar la fecha de acuerdo al día que llegue como parámetro
    
    func cambiaFecha(_ fecha: Date){
        //print("Cambia FEcha");
        /*
        let fechac=NSDateComponents();
        let calendar=NSCalendar.currentCalendar();
        let añoS=calendar.components(.Year , fromDate: self.fecha!);
        let mesS=calendar.components(.Month , fromDate: self.fecha!);
        fechac.year=añoS.year;
        fechac.month=mesS.month;
        fechac.day=(dia);
        let fechaf=NSCalendar.currentCalendar().dateFromComponents(fechac);
         */
        let formateadpr:DateFormatter=DateFormatter();
        formateadpr.locale = Locale.init(identifier: "es_CO");
        formateadpr.dateFormat = "EEE dd/MM/yy";
        //print("Previa: ",fechaVisible!.text);
        let ff=(formateadpr.string(from: fecha).uppercased());
        self.fecha = fecha;
        //print("Cambia: ",ff);
        fechaVisible!.text=ff;
    }
    
    //Método que permite añadir o eliminar una lonchera favorita a la lista de las loncheras del padre
    func anadeFavorito(_ sender: AnyObject){
        print("Ingresa? ", nfavorita);
        if(nfavorita == nil){
            var prodos = [Producto]();
            for casi in (subVista?.casillas)!{
                if(casi.elemeto != nil){
                    //print("prod: ",casi.elemeto?.producto?.nombre);
                    casi.elemeto?.producto?.tipo = casi.tipo;
                    prodos.append((casi.elemeto?.producto)!);
                }
            }
            let sube = IngresaFavoritos();
            sube.bot = self.botfavo;
            let cargaFav=(self.view.superview?.superview?.superview?.superview?.superview as! VistaNino);
            //cargaFav.EspacioLoncheras.cargaFavoritos();
            //sube.predeter = cargaFav.EspacioLoncheras;
            //sube.evalua(prodos);
            mensajeFavorito(true);
        }else{
            print("Borra? ", nfavorita);
            let elimina = EliminaFavoritos();
            elimina.bot=self.botfavo;
            elimina.elimina(nfavorita!);
            nfavorita = nil;
            mensajeFavorito(false);
        }
        
        //print("ccc: ",self.view.superview?.superview?.superview?.superview?.superview);
        
    }
    
    //Método que pone el fondo de la fecha
    func fondoFecha(){
        let fondoFecha = UIImage(named: "FechaFondo");
        
        let frameFondo = CGRect(x: fechaVisible!.frame.origin.x, y: fechaVisible!.frame.origin.y, width: fechaVisible!.frame.width+15, height: fechaVisible!.frame.height);
        //print("fechaf frame: ", fechaVisible!.frame)
        let backImg = UIImageView(frame: frameFondo);
        backImg.image = fondoFecha;
        self.view.addSubview(backImg);
        self.view.sendSubview(toBack: backImg);
    }
    
    //Método que inicializa el Boton de añadir
    func iniciaBotonAdd(){
        
        //botadd?.titleLabel?.text="ADD";
        /*
        for vista in botadd!.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }*/
        var imagen: UIImage;
        imagen = UIImage(named: "Boton+")!;
        _=self.view.frame.width*0.78;
        let alto=(DatosC.contenedor.altoP*0.1124);
        let OX=DatosC.contenedor.anchoP*0.86;
        let OY=(self.view.frame.origin.y)+(alto);
        //let BAOX=(OX+ancho);
        let BAOY=(OY);
        let Bancho=(self.view.frame.width*0.1173);
        let frame = CGRect(x: OX, y: BAOY, width: Bancho, height: Bancho);
        let frame2 = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
        //print("frame+: ",frame);
        let backImg = UIImageView(frame: frame2);
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        botadd?.frame=frame;
        backImg.image = imagen;
        botadd?.addSubview(backImg);
        botadd?.sendSubview(toBack: backImg);
        //botadd?.backgroundColor = UIColor.redColor();
        self.view.addSubview(botadd!);
        
    }
    //Método que inicia el botón de añadir favoritos
    func iniciaBotonFav(){
        
        var imagen: UIImage;
        imagen = UIImage(named: "BotonF")!;
        
        let OX=DatosC.contenedor.anchoP*0.86;
        let OY=(botadd?.frame.origin.y)!+(botadd!.frame.height);
        //let BAOX=(OX+ancho);
        let BAOY=(OY+(10));
        let Bancho=(self.view.frame.width*0.1173);
        let frame = CGRect(x: OX, y: BAOY, width: Bancho, height: Bancho);
        let frame2 = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
        //print("frameF: ",frame);
        let backImg = UIImageView(frame: frame2);
        botfavo?.frame=frame;
        backImg.contentMode = UIViewContentMode.scaleAspectFit;
        backImg.image = imagen;
        botfavo?.addSubview(backImg);
        botfavo?.sendSubview(toBack: backImg);
        self.view.addSubview(botfavo!);
        
    }
    
    func iniciaBotonResta(){
        var imagen: UIImage;
        imagen = UIImage(named: "Boton-0")!;
        
        let OX=DatosC.contenedor.anchoP*0.86;
        let OY=(botfavo?.frame.origin.y)!+(botfavo!.frame.height);
        //let BAOX=(OX+ancho);
        let BAOY=(OY+(10));
        let Bancho=(self.view.frame.width*0.1173);
        let frame = CGRect(x: OX, y: BAOY, width: Bancho, height: Bancho);
        let frame2 = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
        //print("frameF: ",frame);
        let backImg = UIImageView(frame: frame2);
        botrem?.frame=frame;
        backImg.contentMode = UIViewContentMode.scaleAspectFit;
        backImg.image = imagen;
        botrem?.addSubview(backImg);
        botrem?.sendSubview(toBack: backImg);
        self.view.addSubview(botrem!);
    }
    
    //Método que inicia el contador de la lonchera
    func inciaContador(){
        let ancho = DatosC.contenedor.anchoP*0.854;
        let OX = (DatosC.contenedor.anchoP/2)-(ancho/2);
        contador=Contador(frame: CGRect(x: OX, y: (subVista!.frame.height+subVista!.frame.origin.y+(+DatosC.contenedor.altoP*0.055)), width: ancho, height: DatosC.contenedor.altoP*0.07));
        contador!.id=self.id;
        contador!.lonc = self;
    }
    
    func mensajeFavorito(_ ingresa: Bool){
        let ancho = self.view.frame.width*0.8;
        let alto = self.view.frame.height*0.6;
        let OX = (self.view.frame.width/2)-(ancho/2);
        let OY = (self.view.frame.height/2)-(alto/2);
        let frameCuadro = CGRect(x: OX, y: OY, width: ancho, height: alto);
        cuadromsg = UIView (frame: frameCuadro);
        cuadromsg!.backgroundColor = UIColor.green;
        msg = UILabel(frame: CGRect(x: 0, y: 0, width: ancho, height: alto));
        if(ingresa){
            msg!.text = "Lonchera añadida a Favoritos";
        }else{
            msg!.text = "Lonchera removida de Favoritos";
        }
        msg?.textAlignment=NSTextAlignment.center;
        cuadromsg!.addSubview(msg!);
        self.view.addSubview(cuadromsg!);
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LoncheraO.cierraMsg), userInfo: nil, repeats: false);
        
    }
    
    func cierraMsg(){
        cuadromsg!.removeFromSuperview();
    }
    
}
