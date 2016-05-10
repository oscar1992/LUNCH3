//
//  CajaView.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 12/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit
import Foundation

class CajaView: UIButton {
    
    var caja : Caja!;
    var Secuencia:String!;
    var ordenActual:Int=0;
    
    required override init(frame: CGRect) {
        super.init(frame: frame);
        self.addTarget(self, action: #selector(CajaView.muestra(_:)), forControlEvents: .TouchDown);
        
            }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func muestra(button:UIButton){
        
        let vistaN=self.superview?.superview! as! VistaNino;
        let desliza = vistaN.Lonchera.deslizador as VistaLonchera;
        DatosC.lonchera = desliza.paginas[desliza.quien];
        if(desliza.quien<0){
            desliza.quien=0;
        }
        DatosC.lonchera = desliza.paginas[desliza.quien];

        let subVista = DatosC.lonchera;
        //print("Casillas: ",subVista.subVista!.casillas.count);

        let alto = subVista.subVista?.casillas[0].frame.height;
        let ancho = subVista.subVista?.casillas[0].frame.width;
        var p=0;
        
        //print("tama: ", DatosC.contenedor.loncheras[desliza.quien].subVista!.casillas.count);
        
       
        
        for casi in (subVista.subVista?.casillas)!{
            casi.elemeto?.elimina();
        }
        
        for casi in subVista.subVista!.casillas{
            if(p>=caja.secuencia[ordenActual].lista!.count){
                
                //print(p, " se pasó",caja.secuencia[ordenActual].lista!.count);
            }
            if(casi.elemeto==nil){
                print("nulo");
                
            }else{
                print("no nulo: ",casi.elemeto?.producto?.nombre);
                casi.elemeto!.elimina();
                
            }
            
            //print("tama: ",caja.secuencia[ordenActual].lista!.count);
            for Titem in caja.secuencia[ordenActual].lista!{
                if(Titem.productos?.tipo==casi.tipo){
                    
                    //print("ffddf: ",casi.frame);
                    
                    
                    let nn=CGRectMake(0, 0, ancho!, alto!);
                    //print("nn: ",nn);
                    /*
                    print("Titem: ",Titem.productos?.nombre);
                    print("casilla: ",casi.frame);
                    print("___________");
                    */
                    let icono=ProductoView(frame: nn, imagen: Titem.productos!.imagen);
                    icono.tipo=casi.tipo;
                    icono.producto=Titem.productos;
                    icono.padre=casi;
                    //icono.padre=casi;
                    casi.elemeto=icono;
                    casi.bringSubviewToFront(icono);
                    //print("TICONO: ",icono.frame);
                    //print("p: ",p);
                    //DatosC.contenedor.loncheras[desliza.quien].subVista!.casillas.removeAtIndex(p);
                    //DatosC.contenedor.loncheras[desliza.quien].subVista!.casillas.append(casi);
                    casi.addSubview(icono);
                    DatosC.lonchera.subVista!.casillas[p]=casi;
                    DatosC.lonchera.subVista!.casillas[p].addSubview(icono);
                    
                }else{
                    //print("Casi: ",DatosC.contenedor.loncheras[desliza.quien].subVista!.casillas[p].elemeto?.producto?.nombre);
                }
            }
            
            //print("p: ",p);
            if(p>=caja.secuencia[ordenActual].lista!.count){
                //print("se paso");
                //DatosC.contenedor.loncheras[desliza.quien].subVista!.casillas.removeAtIndex(p);
                let Cas = casi;
                Cas.elemeto=nil;
                
                DatosC.lonchera.subVista!.casillas[p]=Cas;
            }
            p+=1;
           
        }
        DatosC.lonchera.contador?.actua();
        /*
        for casi in (subVista.subVista?.casillas)!{
            print("casiD: ",casi.elemeto?.producto?.nombre);
        }
        for cas in DatosC.contenedor.loncheras[desliza.quien].subVista!.casillas{
            print("CassPOs: ",cas.elemeto?.producto?.nombre)
        }
         */
        //DatosC.lonchera=DatosC.contenedor.loncheras[desliza.quien];
        //print("Casillas: ",subVista.subVista?.casillas.count);
        //print("Quien: ", subVista.label?.text);
        //print("CAJA: ",caja.Nombre);
        //print("Sele: ",caja.secuencia[ordenActual]);
        
        ordenActual+=1;
        if(ordenActual>=caja.secuencia.count){
            ordenActual=0;
        }
        //print("OOO: ",ordenActual);
        
        
        /*
        for secu in caja.secuencia{
            print("secu", secu.nombre);
            if (secu.lista==nil){
                //print("secuencia vacía");
            }else{
                for Titem in secu.lista!{
                    //print("titem: ",Titem.productos?.nombre);
                }
            }
        }
        */
        
        
    }

    
}
