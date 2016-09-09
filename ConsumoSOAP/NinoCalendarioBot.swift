//
//  NinoCalendarioBot.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 14/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class NinoCalendarioBot: UIButton {
    
    var ninoInt: BotonNino?;
    var id: Int!;
    var activo : Bool = false;
    var Ano : AnoScroll?;
    
    
    init(frame: CGRect, idNIno: Ninos, primera: Bool){
        super.init(frame: frame);
        self.addTarget(self, action: #selector(NinoCalendarioBot.activa(_:)),forControlEvents: .TouchDown);
        self.id = idNIno.id;
        //print("nino:", idNIno)
        if(primera){
            iniciaScroll(idNIno);
        }
        //Ano!.diaActual();
        //print("self: ", self.id);
        /*if (ninoInt?.activo! == true){
            activo=true;
        }*/
        //print("ini nino: ", ninoInt?.activo);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setID(iid: Int){
        //print("Setea: ", iid);
        self.id=iid;
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    // Método que se llama al presionar un apestaña, la cual activa la actual y desactiva las demás
    func activa(sender: AnyObject){
        let ninos = (self.superview as! CalendarioNinos).ninos;
        for nino in ninos{
            //print("ninos: ", self.id, " nino.id", nino.id);
            if(nino.id == self.id){
                //print(" este: ", nino.ninoInt!.nombreNino);
                Fondo(true, quien: nino);
                //nino.backgroundColor = UIColor.cyanColor();
                //nino.activo = true;
                self.activo = true;
                self.Ano!.diaActual();
                //DatosD.contenedor.calendario.iniciaTextoMes();
                //nino.Ano?.calcuaMes((nino.Ano?.contentOffset.y)!);
                //self.Ano!.calcuaMes(self.Ano!.contentOffset.y);
                //nino.Ano.hidden = false;
                self.Ano!.hidden = false;
            }else{
                //print("no");
                nino.activo = false;
                //self.activo = false;
                //nino.backgroundColor = UIColor.lightGrayColor();
                Fondo(false, quien: nino);
                nino.Ano!.hidden = true;
                //self.Ano.hidden = true;
            }
            
        }
    }
    
    //Método que cambia el fondo de las pestañas de los niños del calendario
    func Fondo(activo : Bool, quien: UIView){
        for vista in quien.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        let img : UIImage!;
        if(activo){
            img = UIImage(named: "Pestana1");
        }else{
            img = UIImage(named: "Pestana2");
        }
        let frameBack = CGRectMake(0, 0, self.frame.width, self.frame.height);
        //print("frame", activo);
        let backImg = UIImageView(frame: frameBack);
        backImg.image=img;
        quien.addSubview(backImg);
        quien.sendSubviewToBack(backImg);
    }
    
    //Método que inicia el scroll con los meses adentro
    func iniciaScroll(nino: Ninos){
        
        let ancho = DatosC.contenedor.anchoP*0.89;
        let alto = DatosC.contenedor.altoP*0.54;
        let OX = DatosC.contenedor.anchoP*0.053;
        let OY = DatosC.contenedor.altoP*0.22;
        let frameScroll = CGRectMake(OX, OY, ancho, alto);
        //print("reinicia: ", Ano);
        //print("tama: ", DatosD.contenedor.calendario.pestañasNinos!.ninos.count);
        for nino in (DatosD.contenedor.calendario.pestañasNinos!.ninos){
            print("na: ", nino.activo," nomb: ", nino.ninoInt?.nombreNino);
            //print("UU: ", nino.Ano?.posicionaDiaActual());
            if(nino.activo==true){
                //print("nino: ", nino.Ano);
                
                //
                //nino.Ano!.diaActual();
            }
            //
        }
        
        Ano = AnoScroll(frame: frameScroll, nino: nino);
        //Ano?.diaActual();
        
        
        DatosD.contenedor.calendario.view.addSubview(Ano!);
        //print("oo");
        
        
    }

}
