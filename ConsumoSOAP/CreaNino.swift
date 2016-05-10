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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let ultimo=DatosC.contenedor.ninos.count-1;        
        DatosC.contenedor.ninos[ultimo].removeFromSuperview();
        DatosC.contenedor.ninos[ultimo].panelNino.removeFromSuperview();
        DatosC.contenedor.ninos.removeLast();
        let vista = DatosC.contenedor.PantallaP as! PantallaP;
        vista.cantBotones-=1;
        vista.botones.removeLast();
        vista.ordenaBoton();
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func acepta(sender: UIButton) {
        if((CampoNombre.text!.isEmpty)){
            //print("Nulo");
            
        }else{
            //print("NO Nulo");
            
            DatosC.contenedor.ninos.last?.fecha=SelectorFecha.date;
            if(Snino.on==true){
                DatosC.contenedor.ninos.last?.genero=true;
            }else{
                DatosC.contenedor.ninos.last?.genero=false;
            }
            DatosC.contenedor.ninos.last?.nombreNino=CampoNombre.text;
            DatosC.contenedor.ninos.last?.panelNino.titulo.text=CampoNombre.text;
            DatosC.contenedor.ninos.last?.cambia();
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        
        
        
    }
    
    func organiza(){
        let borde=CGFloat(20);
        let anchoImagen=DatosC.contenedor.anchoP*0.35;
        let posi=(DatosC.contenedor.anchoP/2)-(anchoImagen/2);
        imagen.frame=CGRectMake(posi, 20, anchoImagen, anchoImagen);
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
