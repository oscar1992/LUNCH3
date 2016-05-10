//
//  VistaPestana.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 20/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaPestana: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    var paginas = [UIViewController]();
    var tipo:Int?;
    var control:UIPageControl?;
    var Panel:PantallaSV?;
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self;
        self.dataSource=self;
        self.Panel=DatosC.contenedor.pantallaSV;
        //carga();
        //setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
        self.view.backgroundColor=UIColor.yellowColor();
        
                // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews {
            if subView is UIScrollView {
                //print("scroll");
                subView.frame = self.view.bounds
            } else if subView is UIPageControl {
                //print("pagecontrol");
                subView.frame=CGRectZero;
                subView.hidden=true;
                self.view.bringSubviewToFront(subView)
            }
        }
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = paginas.indexOf(viewController)!;
        let previousIndex = abs((currentIndex - 1) % paginas.count);
        return paginas[previousIndex];
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = paginas.indexOf(viewController)!;
        let nextIndex = abs((currentIndex + 1) % paginas.count);
        return paginas[nextIndex];
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return paginas.count;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
    }
    
    func carga(){
        var p=CGFloat(0);
        var elementos=[ProductoView]();
        var casillas=[Casilla]();
        let borde = CGFloat(15);
        let cant = 4;
        var divancho :Float;
        divancho=1/Float(cant);
        let anchoP:Int;
        anchoP=Int(self.view.frame.width)
        let ancho = Float(Float(anchoP)*divancho)-(Float(borde));
        var CGAncho=CGFloat(ancho);
        //print("ancho:", ancho);
        //print("anchoP: ",anchoP);
        let espaciado = ancho*0.05;
        CGAncho=CGAncho-CGFloat(espaciado);
        let tama = CGRectMake(0, 0, CGAncho, CGAncho);
        for ele in DatosC.contenedor.productos{
            
            if(ele.tipo==self.tipo){
                //print("tipo E: ",ele.tipo," slide: ",self.tipo);
                //print("prod: ",ele.nombre);
                let pv=ProductoView(frame: tama, imagen: ele.imagen);
                pv.producto=ele;
                
                elementos.append(pv);
            }
        }
        var m = CGFloat(0);
        var fila = CGFloat(0);
        var tot=0;
        var vistas = [UIViewController]();
        var contadorVistas = 0;
        
        for ele in elementos{
            let casill=Casilla();
            if(m>=4){
                fila+=1
                p=0;
                m=0;
            }
            let pos=CGRectMake((borde+(p*(CGAncho+borde))), (borde+(fila*(CGAncho+borde))), CGAncho, CGAncho);
            casill.elemeto=ele;
            casill.addSubview(ele);
            ele.padre=casill;
            ele.espacio=self.Panel!.view;
            ele.Panel2=self.Panel?.Lonchera;
            if(ele.producto?.salud==true){
                casill.backgroundColor=UIColor.greenColor();
            }else{
                casill.backgroundColor=UIColor.whiteColor();
            }
            casill.frame=pos;
            m+=1;
            
            
            if(tot==0){
                let vistaInt=UIViewController();
                vistaInt.view.backgroundColor=UIColor.init(red: (0+(0.2*p)), green: (1-(0.2*p)), blue: 1, alpha: 1);
                let Label=UILabel(frame: CGRectMake(0,0, 100, 30));
                Label.text=String(p);
                vistaInt.view.addSubview(Label)
                vistas.append(vistaInt);
                vistaInt.view.frame=self.view.frame;
                //print("Vista Nueva",contadorVistas);
                paginas.append(vistaInt);
            }
            ele.PanelOrigen=vistas[contadorVistas].view;
            
            if(tot>=8){
                //print("a tope")
                tot=0;
                contadorVistas += 1;
            }else{
                vistas[contadorVistas].view.addSubview(casill);
                //print("normal: ",pos)
            }
            tot+=1;
            p += 1;
            casillas.append(casill);
        }
        
        setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
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
