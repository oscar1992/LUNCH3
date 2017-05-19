//
//  Predeterminadas.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class Predeterminadas: UIScrollView, UIScrollViewDelegate{
    
    /*
    
    var cajas = [CajaView]();
    let borde=CGFloat(20);
    var tamaño:CGFloat!;
    var espaciado:CGFloat!;
    

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.delegate=self;
        //tamaño=self.frame.height*0.8;
        tamaño=DatosC.contenedor.altoP*0.1131;
        espaciado=CGFloat(self.frame.height*0.07);
        //print("Cajas??: ",DatosC.contenedor.cajas.count);
        
        
        //self.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.0);
        setFondo2();
        //
        //cargaFavoritos();
        ordenaCajas();
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func ordenaCajas(){
        
        
        //print("tt: ",DatosC.contenedor.cajas.count);
        cajas = [CajaView]();
        for caja in DatosC.contenedor.cajas{
            let cajaBot=CajaView();
            cajaBot.caja=caja;
            //cajaBot.backgroundColor=caja.Color;
            cajaBot.caja.Color=caja.Color;
            //cajaBot.setTitle(caja.Nombre, forState: .Normal);
            cajas.append(cajaBot);
            //print("CAJA NOMB: ",caja.Nombre);
        }
        
        var p:CGFloat=0;
        //print("cajas: ", cajas.count);
        let anchoTotal = (tamaño*CGFloat(cajas.count))+(espaciado*CGFloat(cajas.count-1));
        let inicia = (self.frame.width/2)-(anchoTotal/2)-(espaciado);
        for cc in cajas{
            cc.frame=CGRect(x: ((borde+tamaño+espaciado)*p)+inicia, y: self.frame.height*0.1, width: tamaño, height: tamaño);
            p+=1;
            cc.iniciaTexto();
            cc.setFondo(cc.caja.Color);
            cc.setNombre(cc.caja.Nombre);
            //print("cc: ", cc.frame);
            self.addSubview(cc);
        }
        
        
        
        self.contentSize=CGSize(width: ((borde*2)+(CGFloat(cajas.count)*(tamaño+espaciado))), height: self.frame.height)
        //cajas.removeAll();
    }
    
    // Método que permite cargar las loncheras favoritas previamente almacenadas
    /*func cargaFavoritos(){
        let carg = CargaFavoritos();
        carg.pred=self;
        carg.consulta(DatosD.contenedor.padre.id);
        //print("Carga");
    }*/
    
    func añadeFavoritas(){
        
        let CajaFavo = DatosD.contenedor.favoritas;
        //print("fav: ", DatosD.contenedor.favOk)
        if(CajaFavo.id != nil && DatosD.contenedor.favOk == false){
            //print("favo: ", CajaFavo.Nombre);
            //print("Tama: ", DatosC.contenedor.cajas.count);
            DatosC.contenedor.cajas.append(CajaFavo);
            
            //print("Tama Antes: ", DatosC.contenedor.cajas.count);
            //ordenaCajas();
            DatosD.contenedor.favOk = true;
        }else{
            //print("favo NON");
            
        }
        
        for vista in self.subviews{
            if vista is CajaView{
                let cavav = vista as! CajaView;
                cavav.selimina = true;
            }
        }
        ordenaCajas();
        for vista in self.subviews{
            if vista is CajaView{
                let cavav = vista as! CajaView;
                //cavav.frame = CGRectMake(0, 0, 0, 0);
                //print("Mata: ",cavav.superview);
                cavav.elimina();
                //cavav.removeFromSuperview();
            }
        }

    }
    
    //Método que establece el fondo de desta vista
    func setFondo2(){
        for vista in self.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        let fondo = UIImage(named: "FondoPredeterminadas");
        let backImg = UIImageView(frame: CGRect(x: 0,y: 0,width: self.frame.width,height: self.frame.height));
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = fondo;
        self.addSubview(backImg);
        self.sendSubview(toBack: backImg);
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
*/
}
