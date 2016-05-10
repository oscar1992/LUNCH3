//
//  DeslizadorViewController.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 4/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit


class DeslizadorViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var paginas = [UIViewController]();
    var posiciones = [CGRect]();
    var vista:ViewController?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self;
        self.dataSource=self;
                var p = 0;
        for _ in 0..<5{
            let pagina = Lonchera() ;
            pagina.deslizador=self;
            pagina.id?.text=String(p);
            pagina.id2=p;
            print("p.",p);
            paginas.append(pagina as UIViewController);
            
            p+=1;
        }
            setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil);
            
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = paginas.indexOf(viewController)!;
        let previousIndex = abs((currentIndex - 1) % paginas.count);
        //print("before: ",previousIndex);
        DatosC.contenedor.iActual=currentIndex;
        DatosC.contenedor.cambia();
        return paginas[previousIndex];
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = paginas.indexOf(viewController)!;
        let nextIndex = abs((currentIndex + 1) % paginas.count);
        //print("after: ",nextIndex);
        DatosC.contenedor.iActual=currentIndex;
        DatosC.contenedor.cambia();
        return paginas[nextIndex];
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return paginas.count;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
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
