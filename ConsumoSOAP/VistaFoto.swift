//
//  VistaFoto.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 3/10/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaFoto: UIView{
    
    let padre:CreaUsuario;
    var ico:UIButton!;
    var contiene=false;
    var datos: Data!;
    
    init (frame: CGRect, padre: CreaUsuario){
        self.padre=padre;
        super.init(frame:frame)
        iniciaBarra();
        iniciaMensaje();
        iniciaFoto();
    }
    
    func iniciaBarra(){
        let ancho = CGFloat(2);
        let alto = self.frame.height;
        let OX = CGFloat(0);
        let OY = CGFloat(0);
        let frameBarra = CGRect(x: OX, y: OY, width: ancho, height: alto);
        let barra = UIView(frame: frameBarra);
        DatosB.cont.poneFondoTot(barra, fondoStr: "Línea blanca vertical", framePers: nil, identi: nil, scala: true);
        self.addSubview(barra);
    }
    
    func iniciaMensaje(){
        let ancho = self.frame.width*0.5;
        let alto = self.frame.height*0.8;
        let OX = self.frame.width*0.1;
        let OY = (self.frame.height/2)-(alto/2);
        let frameLab=CGRect(x: OX, y: OY, width: ancho, height: alto);
        let lab = UILabel(frame: frameLab);
        lab.text="Agrega una fotografía";
        lab.numberOfLines=3;
        lab.adjustsFontSizeToFitWidth=true;
        lab.textColor=UIColor.white;
        lab.font=UIFont(name: "Gotham Bold", size: alto);
        self.addSubview(lab);
    }
    
    func iniciaFoto(){
        let ancho = self.frame.width*0.5;
        let alto = self.frame.height*0.8;
        let OX = self.frame.width*0.5;
        let OY = (self.frame.height/2)-(alto/2);
        let frameIco=CGRect(x: OX, y: OY, width: ancho, height: alto);
        ico = UIButton(frame: frameIco);
        //ico.addTarget(self, action: #selector(VistaFoto.iniciaPicker), forControlEvents: .TouchDown);
        DatosB.cont.poneFondoTot(ico, fondoStr: "Botón Agregar fotografía", framePers: nil, identi: nil, scala: true);
        self.addSubview(ico);
    }
    
    func setFoto(_ foto: UIImage){
        let ima = UIImageView(frame: CGRect(x: (ico.frame.width/2)-(ico.frame.height/2), y: 0, width: ico.frame.height, height: ico.frame.height));
        let mask = UIImage(named: "mascara");
        ima.image = maskImage(foto, mask: mask!);
        ico.addSubview(ima);
        serImagen(ima.image!);
        contiene=true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func iniciaPicker(){
        padre.inciaPicker();
    }
    
    func maskImage(_ image:UIImage, mask:(UIImage))->UIImage{
        
        let imageReference = image.cgImage
        let maskReference = mask.cgImage
        
        let imageMask = CGImage(maskWidth: maskReference!.width,
                                          height: maskReference!.height,
                                          bitsPerComponent: maskReference!.bitsPerComponent,
                                          bitsPerPixel: maskReference!.bitsPerPixel,
                                          bytesPerRow: maskReference!.bytesPerRow,
                                          provider: maskReference!.dataProvider!, decode: nil, shouldInterpolate: true)
        
        let maskedReference = imageReference!.masking(imageMask!)
        
        let maskedImage = UIImage(cgImage:maskedReference!)
        
        return maskedImage
    }
    
    func serImagen(_ imagen: UIImage){
        datos = UIImagePNGRepresentation(imagen)!;
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
