//
//  BaseImagenes.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 8/02/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class BaseImagenes: UIPageViewController, UIPageViewControllerDelegate,  UIPageViewControllerDataSource {
    
    var paginas = [UIViewController]();
    
    override func viewDidLoad() {
        
        self.delegate=self;
        self.dataSource=self;
        
        super.viewDidLoad()
        iniciaImagenes();
        setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false,completion: nil);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func iniciaImagenes(){
        let pagina = VistaTut();
        let pagina2 = VistaTut();
        let pagina3 = VistaTut();
        let pagina4 = VistaTut();
        let pagina5 = VistaTut();
        pagina.orden=0;
        pagina.orden=1;
        pagina.orden=2;
        pagina.orden=3;
        pagina.orden=4;
        DatosB.cont.poneFondoTot(pagina.view, fondoStr: "Tutorial Home 1", framePers: nil, identi: nil, scala: false);
        DatosB.cont.poneFondoTot(pagina2.view, fondoStr: "Tutorial Home 2", framePers: nil, identi: nil, scala: false);
        DatosB.cont.poneFondoTot(pagina3.view, fondoStr: "Tutorial Home 3", framePers: nil, identi: nil, scala: false);
        DatosB.cont.poneFondoTot(pagina4.view, fondoStr: "Tutorial Home 4", framePers: nil, identi: nil, scala: false);
        DatosB.cont.poneFondoTot(pagina5.view, fondoStr: "Tutorial Home 5", framePers: nil, identi: nil, scala: false);
        let OX = self.view.frame.width*0.1;
        let OY = self.view.frame.height*0.5;
        let ancho = self.view.frame.width*0.8;
        let alto = self.view.frame.height*0.1;
        let frameFinal = CGRectMake(OX, OY, ancho, alto);
        let botFinal = UIButton(frame: frameFinal);
        botFinal.addTarget(self, action: #selector(BaseImagenes.botFinal), forControlEvents: .TouchDown);
        //botFinal.backgroundColor=UIColor.redColor();
        pagina5.view.addSubview(botFinal);
        paginas.append(pagina);
        paginas.append(pagina2);
        paginas.append(pagina3);
        paginas.append(pagina4);
        paginas.append(pagina5);
        print("imagenes: ", paginas.count);
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! VistaTut).orden;
        print("Before")
        let indant = paginas.indexOf(viewController);
        let previousIndex = indant! - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard paginas.count > previousIndex else {
            return nil
        }
        
        return paginas[previousIndex];
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        print("After")
        let indant = paginas.indexOf(viewController);
        let previousIndex = indant! + 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard paginas.count > previousIndex else {
            return nil
        }
        
        return paginas[previousIndex];
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return paginas.count
    }
    
    func botFinal(){
        //print("Cambia")
        self.view.removeFromSuperview();
        //setViewControllers([paginas[1]], direction: UIPageViewControllerNavigationDirection.Forward , animated: true,completion: nil);
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
