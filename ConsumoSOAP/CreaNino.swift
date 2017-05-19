//
//  CreaNino.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 11/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class CreaNino: UIViewController {

    @IBOutlet weak var Snino: UISwitch!
    @IBOutlet weak var Snina: UISwitch!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var TextoNombre: UILabel!
    @IBOutlet weak var CampoNombre: UITextField!
    @IBOutlet weak var TextoFecha: UILabel!
    @IBOutlet weak var SelectorFecha: UIDatePicker!
    @IBOutlet weak var TextoHombre: UILabel!
    @IBOutlet weak var TextoMujer: UILabel!
    @IBOutlet weak var BotonAceptar: UIButton!
    @IBOutlet weak var BotonCancelar: UIButton!
    @IBOutlet weak var Mensaje: UIView!
    var sube = SubeNino();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargaCalorias();
        organiza();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Anino(_ sender: UISwitch) {
        if(Snino.isOn){
            Snina.isOn=false;
        }else{
            Snina.isOn=true;
        }
    }
    
    @IBAction func Anina(_ sender: UISwitch) {
        if(Snina.isOn){
            Snino.isOn=false;
        }else{
            Snino.isOn=true;
        }
    }
    
    
    @IBAction func cancela(_ sender: UIButton) {
        /*
        let ultimo=DatosC.contenedor.ninos.count-1;        
        DatosC.contenedor.ninos[ultimo].removeFromSuperview();
        DatosC.contenedor.ninos[ultimo].panelNino.removeFromSuperview();
        DatosC.contenedor.ninos.removeLast();
        let vista = DatosC.contenedor.Pantallap;
        vista.cantBotones-=1;
        vista.botones.removeLast();
        //vista.ordenaBoton();
        */
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func acepta(_ sender: UIButton) {
        
        if((CampoNombre.text!.isEmpty)){
            //print("Nulo");
            
        }else{
            //print("NO Nulo");
            ordenaMensaje();
            Mensaje.isHidden=false;
                        //DatosC.contenedor.ninos.last?.panelNino.titulo.text=CampoNombre.text;
            let ninoNuevo : Ninos;
            ninoNuevo = Ninos();
            ninoNuevo.fechaNacimiento=SelectorFecha.date;
            if(Snino.isOn==true){
                
                ninoNuevo.genero="M";
            }else{
                ninoNuevo.genero="F";
            }
            ninoNuevo.nombre=CampoNombre.text;
            ninoNuevo.padre=DatosD.contenedor.padre.id;
            //let sube = SubeNino();
            sube.crea = self;
            sube.envía(ninoNuevo);
            
        }
        
        
        
    }
    
    var calorias : [[Int ]] = [[0, 5, 248, 230] , [6, 9, 300, 279], [10, 13, 418, 374], [14, 17, 550, 420], [18, 59, 530, 420], [60, 99, 434, 379]];
    //var caloriasM : [[Int]] = [];
    
    
    
    func organiza(){
        let borde=CGFloat(20);
        let anchoImagen=DatosC.contenedor.anchoP*0.35;
        let posi=(DatosC.contenedor.anchoP/2)-(anchoImagen/2);
        imagen.frame=CGRect(x: posi, y: 80, width: anchoImagen, height: anchoImagen);
        let anchoTexto=DatosC.contenedor.anchoP*0.3;
        let altoTexto=DatosC.contenedor.altoP*0.04;
        let anchoCampo=DatosC.contenedor.anchoP*0.7;
        TextoNombre.frame=CGRect(x: borde, y: (imagen.frame.origin.y+imagen.frame.height+10), width: anchoTexto, height: altoTexto);
        CampoNombre.frame=CGRect(x: (TextoNombre.frame.origin.x+anchoTexto), y: TextoNombre.frame.origin.y, width: (anchoCampo-(borde*2)), height: altoTexto);
        
        TextoFecha.frame=CGRect(x: borde, y: ((TextoNombre.frame.origin.y+TextoNombre.frame.height)+10), width: (DatosC.contenedor.anchoP-(borde*2)), height: altoTexto);
        let altoSelector=DatosC.contenedor.altoP*0.2;
        SelectorFecha.frame=CGRect(x: borde, y: ((TextoFecha.frame.origin.y+TextoFecha.frame.height)+10), width: (DatosC.contenedor.anchoP-(borde*2)), height: altoSelector);
        let anchoTextoHombre=DatosC.contenedor.anchoP*0.3;
        TextoHombre.frame=CGRect(x: borde, y: ((SelectorFecha.frame.origin.y+SelectorFecha.frame.height+10)), width: anchoTextoHombre, height: altoTexto);
        TextoMujer.frame=CGRect(x: borde, y: ((TextoHombre.frame.origin.y+TextoHombre.frame.height+20)), width: anchoTextoHombre, height: altoTexto);
        Snino.frame=CGRect(x: (TextoHombre.frame.origin.x+TextoHombre.frame.width), y: ((SelectorFecha.frame.origin.y+SelectorFecha.frame.height+10)), width: anchoTextoHombre, height: altoTexto);
        Snina.frame=CGRect(x: (TextoHombre.frame.origin.x+TextoHombre.frame.width), y: ((TextoHombre.frame.origin.y+TextoHombre.frame.height+10)), width: anchoTextoHombre, height: altoTexto);
        let posiBA=(DatosC.contenedor.anchoP/4)-(BotonAceptar.frame.width/2);
        let posiBC=((DatosC.contenedor.anchoP/4)-(BotonCancelar.frame.width/2))+((DatosC.contenedor.anchoP/4)*2);
        BotonAceptar.frame=CGRect(x: posiBA, y: (TextoMujer.frame.origin.y+TextoMujer.frame.height+10), width: BotonAceptar.frame.width, height: altoTexto);
        BotonCancelar.frame=CGRect(x: posiBC, y: (TextoMujer.frame.origin.y+TextoMujer.frame.height+10), width: BotonCancelar.frame.width, height: altoTexto);
    }
    
    
    // Método de carga de la tabla de calorías, debe mutar a una consulta de una tabla a travez de un servicio web
    
    func cargaCalorias(){
        Mensaje.isHidden = true;
        Mensaje.frame=CGRect(x: self.view.frame.width*0.1, y: self.view.frame.height*0.4, width: self.view.frame.width*0.8, height: self.view.frame.height*0.4);
    }
    
    // Método que inicializa la vista del mensaje y su contenido
    func ordenaMensaje(){
        let msg = UILabel(frame: CGRect(x: 0, y: 0, width: Mensaje.frame.width, height: Mensaje.frame.height));
        let bot = UIButton(frame: CGRect(x: 0, y: Mensaje.frame.height*0.9, width: Mensaje.frame.width, height: Mensaje.frame.height*0.1));
        let botmsg=UILabel(frame: CGRect(x: 0, y: 0, width: bot.frame.width, height: bot.frame.height));
        botmsg.text="AVAA";
        bot.addSubview(botmsg);
        bot.addTarget(self, action: #selector(CreaNino.prosigue(_:)), for: .touchDown);
        bot.backgroundColor = UIColor.blue;
        msg.numberOfLines=5;
        Mensaje.addSubview(msg);
        Mensaje.addSubview(bot);
        let fecha = SelectorFecha.date;
        let resta = Date();
        let calendar = Calendar.current;
        let componentes = (calendar as NSCalendar).components(NSCalendar.Unit.year, from: fecha, to: resta, options: .wrapComponents);
        let años = componentes.year;
        var cal : String = "";
        for aa in calorias{
            //print("Menor: ", aa[0]);
            //print("Mayor: ", aa[1]);
            
            if(aa[0] <= años! && aa[1] >= años!){
                if(Snino.isOn){
                    //print(aa[1]," -- ",aa[2]);
                    cal = String(aa[2]);
                }else{
                    //print(aa[1]," -- ",aa[3]);
                    cal = String(aa[3]);
                }
                
            }
        }
        //print("Fecha: ", años);
        
        msg.text = "Su rango Calórico ideal está alrededor de: "+cal+" calorias";
    }
    
    //Método que permite avanzar hacia la ventana del home
    func prosigue(_ sender: AnyObject){
        if((CampoNombre.text!.isEmpty)){
        
        }else{
            self.dismiss(animated: true, completion: nil);
        }
        
        
    }
    
    //Método que se llama al finalizar la inserción del niño
    func apruebaInserción(_ nino: Ninos){
        if(sube.inserta!){
            
            DatosD.contenedor.ninos.append(nino);
            DatosC.contenedor.Pantallap.anadeNinos(nino);
            DatosC.contenedor.Pantallap.ordenaBoton2();
            print("Pre tama: ", DatosC.contenedor.ninos.count);
            DatosC.contenedor.ninos.last!.cambia();
        }else{
            cancela(BotonCancelar);
        }
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
