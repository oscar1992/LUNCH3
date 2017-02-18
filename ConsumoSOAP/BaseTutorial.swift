//
//  BaseTutorial.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 8/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class BaseTutorial: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var paginas = [VistaTut]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //let frame = CGRectMake(0, 0, DatosC.contenedor.anchoP, DatosC.contenedor.altoP);
        self.delegate=self;
        self.dataSource=self;
        iniciaFondo();
        iniciaImagenes();
        
        setViewControllers([paginas[3]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false,completion: nil);
        
    }
    
    func iniciaFondo()  {
        self.view.backgroundColor=UIColor.blueColor();
        //self.view.alpha=0.5;
    }
    
    func iniciaImagenes(){
        let pagina = VistaTut();
        DatosB.cont.poneFondoTot(pagina.view, fondoStr: "Tutorial Home 1", framePers: nil, identi: nil, scala: false);
        paginas.append(pagina);
        let pagina2 = VistaTut();
        DatosB.cont.poneFondoTot(pagina2.view, fondoStr: "Tutorial Home 2", framePers: nil, identi: nil, scala: false);
        paginas.append(pagina2);
        let pagina3 = VistaTut();
        DatosB.cont.poneFondoTot(pagina3.view, fondoStr: "Tutorial Home 3", framePers: nil, identi: nil, scala: false);
        paginas.append(pagina3);
        let pagina4 = VistaTut();
        DatosB.cont.poneFondoTot(pagina4.view, fondoStr: "Tutorial Home 4", framePers: nil, identi: nil, scala: false);
        paginas.append(pagina4);
        let pagina5 = VistaTut();
        DatosB.cont.poneFondoTot(pagina5.view, fondoStr: "Tutorial Home 5", framePers: nil, identi: nil, scala: false);
        paginas.append(pagina5);
        print("imagenes: ", paginas.count);
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        print("ccc");
        let currentIndex = paginas.indexOf(viewController as! VistaTut);
            var previousIndex = abs((currentIndex! - 1) % paginas.count);
            let actual = currentIndex;
            if(actual <= 0 || paginas[actual!] == NSNotFound){
                previousIndex = paginas.count-1;
            }
            //setViewControllers([paginas[previousIndex]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false,completion:nil);
            print("prev: ", previousIndex);
            return paginas[previousIndex];
        

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = paginas.indexOf((viewController as! VistaTut))!;
        let nextIndex = abs((currentIndex + 1) % paginas.count);
        //setViewControllers([paginas[nextIndex]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false,completion:nil);
        print("next: ", nextIndex);
        return paginas[nextIndex];
 
    }
    
    
    override func didReceiveMemoryWarning() {
        print("ERROR G")
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
