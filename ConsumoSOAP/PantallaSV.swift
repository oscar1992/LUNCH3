//
//  PantallaSV.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 18/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class PantallaSV: UIViewController {

    @IBOutlet weak var PanelElementos: UIView!
    @IBOutlet weak var Lonchera: UIView!
    
    
    
    var CasillaF:CGRect?;
    var FrameOriginal:CGRect?;
    var CasiillaOriginal:CGRect?;
    var lonch:LoncheraO!;
    var padreLonch:UIView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatosC.contenedor.pantallaSV=self;
        PanelElementos!.frame=CGRectMake(0, 0, DatosC.contenedor.anchoP, (DatosC.contenedor.altoP*0.7));
        Lonchera?.frame=CGRectMake(10, PanelElementos.frame.height, (DatosC.contenedor.anchoP-20), (DatosC.contenedor.altoP*0.3));
        
        
        lonch=DatosC.lonchera;
        
        if(lonch != nil){
            print("Lleno")
        }else{
            print("vacio");
        }
        //lonch.ordena();
        //Lonchera.addSubview(lonch.view);
        padreLonch=lonch!.view.superview;
        let contenedor=ContenedorProductos(frame: PanelElementos.frame);
        
        PanelElementos.addSubview(contenedor)
        PanelElementos.addSubview(lonch!.subVista!);
        
        FrameOriginal=lonch!.subVista?.frame;
        //lonch.subVista?.escala();
        //CasiillaOriginal=lonch.subVista?.casillas[0].frame;
        
        print("Frame: ", FrameOriginal);
        lonch!.subVista!.frame=CGRectMake(0, DatosC.contenedor.altoP*0.7, DatosC.contenedor.anchoP, Lonchera!.frame.height);
        
        
        let sum=((lonch!.subVista!.frame.width)*0.5);
        
        for cass in lonch.subVista!.casillas{
            //print("pos: ",cass.frame);
            
            let nf=CGRectMake((cass.frame.origin.x+sum)*0.6, cass.frame.origin.y*0.6, (cass.frame.width*0.6), (cass.frame.height*0.6))
            cass.frame=nf;
            //print("nima: ",cass.elemeto?.producto?.nombre);
            if(cass.elemeto != nil){
                cass.elemeto!.frame=CGRectMake(0, 0, nf.width, nf.height)
                
                //print("nn: ",cass.elemeto!.frame);
                
                let pv=ProductoView(frame: CGRectMake(0, 0, nf.width, nf.height), imagen: cass.elemeto!.producto!.imagen);
                let prod=cass.elemeto!.producto;
                let tipo=cass.tipo;
                let ima=cass.elemeto!.producto!.imagen;
                cass.elemeto?.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.6);
                cass.elemeto!.removeFromSuperview();
                //cass.elemeto!.elimina();
                
                
                /*
                let Cas = cass;
                Cas.elemeto=nil;
                cass.elemeto=nil;
                */
                cass.elemeto=pv;
                cass.tipo=tipo;
                /*
                for ele in cass.elemeto!.subviews{
                    print("subvv: ", ele);
                }
                */
                cass.addSubview(pv);
                cass.tipo=tipo;
                cass.elemeto!.producto=prod;
                cass.elemeto!.producto!.imagen=ima;
 
            }else{
                print("no posee: ", cass.elemeto?.producto?.nombre);
            }
            //print("pos2: ",nf);
            
        }
        
        
        DatosC.contenedor.casillasF=lonch.subVista!.casillas;
        
                 /*
        
        self.view.bringSubviewToFront(PanelElementos);
        let volver = UIButton(frame: CGRectMake(0, (DatosC.contenedor.altoP*0.9), (DatosC.contenedor.anchoP*0.3), (DatosC.contenedor.altoP*0.07)));
        volver.addTarget(self, action: #selector(PantallaSV.devuelve(_:)), forControlEvents: .TouchDown)
        volver.setTitle("Volver", forState: .Normal);
        volver.backgroundColor=UIColor.blueColor();
        //self.view.addSubview(volver);
        //cargaElementos();
        */
        
        //let calendario = UIButton(frame: CGRectMake(0, (DatosC.contenedor.altoP*0.9), (DatosC.contenedor.anchoP*0.4), (DatosC.contenedor.altoP*0.2)));
        //calendario.addTarget(self, action: #selector(PantallaSV.pasaCalendario(_:)), forControlEvents: .TouchDown);
        //calendario.setTitle("Calendario", forState: .Normal);
        //calendario.backgroundColor=UIColor.cyanColor();
        //self.view.addSubview(calendario);

        print("Carga??");
        
        
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cargaElementos(){
        let borde=CGFloat(20);
        let espaciado=CGFloat(DatosC.contenedor.anchoP*0.05);
        let ancho = CGFloat(DatosC.contenedor.anchoP*0.25);
        var p=CGFloat(0);
        var f=CGFloat(0);
        
        
        for prdo in DatosC.contenedor.productos{
            let fila=(espaciado+ancho)*p+2*(borde);
            if(fila>DatosC.contenedor.anchoP){
                f+=1;
            }
            
            if(prdo.tipo==DatosC.contenedor.tipo){
                //print("prdo: ",prdo.nombre);
                let casilla=Casilla(frame: CGRectMake(borde+((ancho+espaciado)*p), borde+(ancho*f), ancho, ancho));
                let posProducto=CGRectMake(0, 0, casilla.frame.height, casilla.frame.width);
                let producto=ProductoView(frame: posProducto, imagen: prdo.imagen);
                producto.Panel2=Lonchera;
                producto.padre=casilla;
                producto.PanelOrigen=PanelElementos;
                producto.espacio=self.view;
                casilla.elemeto=producto;
                casilla.backgroundColor=UIColor.greenColor();
                casilla.addSubview(producto);
                PanelElementos.addSubview(casilla);
                producto.casillaF=CasillaF;
                //print("Prod: ",producto.frame);
                p+=1;
            }
            
        }
    }
    
    func devuelve(sender: UIButton){
        
        actuaLonch(true);
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func actuaLonch(pasa: Bool){
        //padreLonch?.addSubview(lonch.view);
        let sum=((lonch!.subVista!.frame.width)*0.5);
        if(pasa){
            lonch!.subVista?.frame=FrameOriginal!;
        }
        lonch=DatosC.lonchera;
        
        
        for cass in lonch.subVista!.casillas{
            //
            if(pasa){
            cass.frame=CGRectMake((cass.frame.origin.x)/0.6-sum, cass.frame.origin.y/0.6, cass.frame.width/0.6, cass.frame.height/0.6);
            }
            //print("nima: ",cass.elemeto?.producto?.nombre);
            if(cass.elemeto != nil){
                cass.elemeto!.frame=CGRectMake(0, 0, cass.frame.width, cass.frame.height)
                
                //print("nn: ",cass.elemeto!.frame);
                
                let pv=ProductoView(frame: CGRectMake(0, 0, cass.frame.width, cass.frame.height), imagen: cass.elemeto!.producto!.imagen);
                let prod=cass.elemeto!.producto;
                
                var tipo=cass.tipo;
                if(tipo == nil){
                    tipo = -1;
                }
                pv.tipo=tipo;
                let ima=cass.elemeto!.producto!.imagen;
                //pv.imagen?.contentMode=UIViewContentMode.ScaleAspectFit;
                cass.elemeto!.backgroundColor=UIColor.clearColor().colorWithAlphaComponent(0.6);
                cass.elemeto!.removeFromSuperview();
                //cass.elemeto!.elimina();
                
                
                /*
                 let Cas = cass;
                 Cas.elemeto=nil;
                 cass.elemeto=nil;
                 */
                cass.elemeto=pv;
                cass.tipo=tipo;
                cass.elemeto?.Natural=true;
                cass.elemeto?.padre=cass;
                /*
                 for ele in cass.elemeto!.subviews{
                 print("subvv: ", ele);
                 }
                */
                cass.addSubview(pv);
                cass.elemeto!.producto=prod;
                //print("PV: ",cass.elemeto?.producto!.nombre);
                cass.elemeto!.producto!.imagen=ima;
                
            }else{
                print("no posee: ", cass.elemeto?.producto?.nombre);
            }
            
        }
        
        /*
        for ele in lonch.subVista!.casillas{
            print("PRODUTO: ",ele.elemeto);
            print("PRODUTO: ",ele.elemeto?.producto);
        }
        */
        for cs in (lonch.subVista!.casillas){
            cs.elemeto?.Natural=true;
        }
        DatosC.lonchera=lonch;
        //padreLonch?.addSubview(lonch!.subVista!);
        
        //print("iActual:", DatosC.contenedor.iActual);
        //scrol?.paginas[DatosC.contenedor.iActual].removeFromParentViewController();
        
        
        //print("sup:", scrol);
        //print("Frame: ", lonch!.subVista?.frame);
        if(pasa){
            let scrol=lonch?.padre;
            let sub=lonch?.subVista;
            scrol?.paginas[DatosC.contenedor.iActual].subVista=lonch!.subVista;
            scrol?.paginas[DatosC.contenedor.iActual].view!.addSubview(sub!);
            self.dismissViewControllerAnimated(true, completion: nil);
        }else{
            
        }
    }
    
    func bajaLonch()-> LoncheraO{
        return DatosC.lonchera;
    }
    
    func pasaCalendario(sender: AnyObject){
        print("aaaaa");
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
