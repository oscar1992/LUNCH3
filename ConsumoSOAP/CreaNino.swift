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
    
    @IBAction func Anino(sender: UISwitch) {
        if(Snino.on){
            Snina.on=false;
        }else{
            Snina.on=true;
        }
    }
    
    @IBAction func Anina(sender: UISwitch) {
        if(Snina.on){
            Snino.on=false;
        }else{
            Snino.on=true;
        }
    }
    
    
    @IBAction func cancela(sender: UIButton) {
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
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func acepta(sender: UIButton) {
        
        if((CampoNombre.text!.isEmpty)){
            //print("Nulo");
            
        }else{
            //print("NO Nulo");
            ordenaMensaje();
            Mensaje.hidden=false;
                        //DatosC.contenedor.ninos.last?.panelNino.titulo.text=CampoNombre.text;
            let ninoNuevo : Ninos;
            ninoNuevo = Ninos();
            ninoNuevo.fechaNacimiento=SelectorFecha.date;
            if(Snino.on==true){
                
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
        imagen.frame=CGRectMake(posi, 80, anchoImagen, anchoImagen);
        let anchoTexto=DatosC.contenedor.anchoP*0.3;
        let altoTexto=DatosC.contenedor.altoP*0.04;
        let anchoCampo=DatosC.contenedor.anchoP*0.7;
        TextoNombre.frame=CGRectMake(borde, (imagen.frame.origin.y+imagen.frame.height+10), anchoTexto, altoTexto);
        CampoNombre.frame=CGRectMake((TextoNombre.frame.origin.x+anchoTexto), TextoNombre.frame.origin.y, (anchoCampo-(borde*2)), altoTexto);
        
        TextoFecha.frame=CGRectMake(borde, ((TextoNombre.frame.origin.y+TextoNombre.frame.height)+10), (DatosC.contenedor.anchoP-(borde*2)), altoTexto);
        let altoSelector=DatosC.contenedor.altoP*0.2;
        SelectorFecha.frame=CGRectMake(borde, ((TextoFecha.frame.origin.y+TextoFecha.frame.height)+10), (DatosC.contenedor.anchoP-(borde*2)), altoSelector);
        let anchoTextoHombre=DatosC.contenedor.anchoP*0.3;
        TextoHombre.frame=CGRectMake(borde, ((SelectorFecha.frame.origin.y+SelectorFecha.frame.height+10)), anchoTextoHombre, altoTexto);
        TextoMujer.frame=CGRectMake(borde, ((TextoHombre.frame.origin.y+TextoHombre.frame.height+20)), anchoTextoHombre, altoTexto);
        Snino.frame=CGRectMake((TextoHombre.frame.origin.x+TextoHombre.frame.width), ((SelectorFecha.frame.origin.y+SelectorFecha.frame.height+10)), anchoTextoHombre, altoTexto);
        Snina.frame=CGRectMake((TextoHombre.frame.origin.x+TextoHombre.frame.width), ((TextoHombre.frame.origin.y+TextoHombre.frame.height+10)), anchoTextoHombre, altoTexto);
        let posiBA=(DatosC.contenedor.anchoP/4)-(BotonAceptar.frame.width/2);
        let posiBC=((DatosC.contenedor.anchoP/4)-(BotonCancelar.frame.width/2))+((DatosC.contenedor.anchoP/4)*2);
        BotonAceptar.frame=CGRectMake(posiBA, (TextoMujer.frame.origin.y+TextoMujer.frame.height+10), BotonAceptar.frame.width, altoTexto);
        BotonCancelar.frame=CGRectMake(posiBC, (TextoMujer.frame.origin.y+TextoMujer.frame.height+10), BotonCancelar.frame.width, altoTexto);
    }
    
    
    // Método de carga de la tabla de calorías, debe mutar a una consulta de una tabla a travez de un servicio web
    
    func cargaCalorias(){
        Mensaje.hidden = true;
        Mensaje.frame=CGRectMake(self.view.frame.width*0.1, self.view.frame.height*0.4, self.view.frame.width*0.8, self.view.frame.height*0.4);
    }
    
    // Método que inicializa la vista del mensaje y su contenido
    func ordenaMensaje(){
        let msg = UILabel(frame: CGRectMake(0, 0, Mensaje.frame.width, Mensaje.frame.height));
        let bot = UIButton(frame: CGRectMake(0, Mensaje.frame.height*0.9, Mensaje.frame.width, Mensaje.frame.height*0.1));
        let botmsg=UILabel(frame: CGRectMake(0, 0, bot.frame.width, bot.frame.height));
        botmsg.text="AVAA";
        bot.addSubview(botmsg);
        bot.addTarget(self, action: #selector(CreaNino.prosigue(_:)), forControlEvents: .TouchDown);
        bot.backgroundColor = UIColor.blueColor();
        msg.numberOfLines=5;
        Mensaje.addSubview(msg);
        Mensaje.addSubview(bot);
        let fecha = SelectorFecha.date;
        let resta = NSDate();
        let calendar = NSCalendar.currentCalendar();
        let componentes = calendar.components(NSCalendarUnit.Year, fromDate: fecha, toDate: resta, options: .WrapComponents);
        let años = componentes.year;
        var cal : String = "";
        for aa in calorias{
            //print("Menor: ", aa[0]);
            //print("Mayor: ", aa[1]);
            
            if(aa[0] <= años && aa[1] >= años){
                if(Snino.on){
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
    func prosigue(sender: AnyObject){
        if((CampoNombre.text!.isEmpty)){
        
        }else{
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        
        
    }
    
    //Método que se llama al finalizar la inserción del niño
    func apruebaInserción(nino: Ninos){
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
