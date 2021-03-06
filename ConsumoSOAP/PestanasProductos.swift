//
//  PestanasProductos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 20/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class PestanasProductos: UIButton {
    
    var subVista:VistaPestana?;
    var activo:Bool?;
    var tipo:Int!;
    var padre:ContenedorProductos;
        
    init(frame: CGRect, padre: ContenedorProductos) {
        self.padre=padre;
        super.init(frame: frame);
        self.backgroundColor=UIColor.red;
        self.addTarget(self, action: #selector(PestanasProductos.cambia(_:)), for: .touchDown);
        
        if(subVista != nil){
            self.addSubview((subVista?.view)!);
        }else{
            subVista=VistaPestana(transitionStyle: UIPageViewControllerTransitionStyle.scroll,
                                  navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal ,
                                  options:nil );
        }
        backgroundColor=UIColor.lightGray;
        
        self.subVista?.view.isHidden=true;
        //print("crea");
        
    }
    
    func cambia(_ sender: UIButton){
        //print("cambia: ", self.tipo);
        
        for pest in DatosC.contenedor.Pestanas{
            //if(pest.activo==true){
                
            pest.activo=false;
            pest.backgroundColor=UIColor.lightGray;
            pest.subVista!.view.isHidden=true;
            pest.Fondo();
            //pest.superview?.bringSubviewToFront(pest);
                //print("Activo: ",pest.frame);
            //}
            
        }
        self.activo=true;
        FondoActivo();
        self.backgroundColor=UIColor.blue;
        self.subVista!.view.isHidden=false;
        self.superview?.sendSubview(toBack: self);
        padre.activo=self;
        /*
        if(activo==true){
            //print("Desactiva");
            self.activo=false;
            //self.backgroundColor=UIColor.lightGrayColor();
            //self.subVista!.view.hidden=true;
            Fondo();
        }else{
            //print("Activa");
            self.activo=true;
            FondoActivo();
            //
            self.backgroundColor=UIColor.blueColor();
            //self.subVista!.view.hidden=false;
        }
        */
    }
    
    //Método que inicializa 
    func iniSlide()->VistaPestana{
        //subVista?.view.frame=CGRectMake(0, (self.frame.height+self.frame.origin.y), DatosC.contenedor.anchoP, self.padre!.frame.height*0.8);
        subVista?.view.frame=CGRect(x: 0, y: (self.frame.height+self.frame.origin.y), width: DatosC.contenedor.anchoP, height: DatosC.contenedor.altoP-(self.frame.height+self.frame.origin.y+(DatosC.contenedor.altoP*0.092)));
        //print("retama", subVista?.view.frame);
        subVista?.tipo=self.tipo;
        //subVista?.carga();
        subVista?.cargaPaginascategoria();
        return subVista!;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Método que pone el fondo de la pestaña
    func Fondo(){
        for vista in self.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        var imagen: UIImage;
        //print("Dtt: ", self.tipo);
        switch Int(self.tipo!){
        case 1:
            imagen = UIImage(named: "PEne")!;
            break;
        case 2:
            imagen = UIImage(named: "PVit")!;
            break;
        case 3:
            imagen = UIImage(named: "PCre")!;
            break;
        case 4:
            imagen = UIImage(named: "PBeb")!;
            break;
        default:
            imagen = UIImage(named: "CasillaVerde")!;
            break;
        }
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        let backImg = UIImageView(frame: frame);
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
        self.addSubview(backImg);
        self.sendSubview(toBack: backImg);
        self.backgroundColor=UIColor.blue;
    }
    
    func FondoActivo(){
        for vista in self.subviews{
            if vista is UIImageView{
                vista.removeFromSuperview();
            }
        }
        var imagen: UIImage;
        //print("Att: ", self.tipo);
        switch Int(self.tipo!){
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
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        let backImg = UIImageView(frame: frame);
        //backImg.contentMode = UIViewContentMode.ScaleAspectFit;
        backImg.image = imagen;
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

}
