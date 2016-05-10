//
//  VistaLonchera.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 14/04/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import UIKit

class VistaLonchera: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var paginas = [LoncheraO]();
    var quien:Int=0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.delegate=self;
        self.dataSource=self;
        //print("desliza:self.appearance
        
        var p=CGFloat(0);
        for _ in 0..<5{
            /*
            let fecha=NSDate();
            let compon=NSCalendar.currentCalendar();
            let cmponene=compon.components(.Weekday, fromDate: fecha)
            let componene2=compon.components(.Day, fromDate: fecha)
            let formateadpr:NSDateFormatter=NSDateFormatter();
            //formateadpr.dateStyle=NSDateFormatterStyle.LongStyle;
            formateadpr.locale = NSLocale.init(localeIdentifier: "es_CO");
            formateadpr.dateFormat = "EEEE d MMMM";
            //formateadpr.timeStyle = .NoStyle;
            
            print("POSEE: ",cmponene.weekday,"----",componene2.day);
            print("Posee2: ",formateadpr.stringFromDate(fecha));
            */
            let lonchera=LoncheraO();
            lonchera.inicia(Int(p));
            lonchera.padre=self;
            paginas.append(lonchera);
            DatosC.contenedor.loncheras.append(lonchera);
            p+=1;
            lonchera.view.backgroundColor=UIColor.init(red: (0+(0.2*p)), green: (1-(0.2*p)), blue: 1, alpha: 1);
        }
        setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = paginas.indexOf(viewController as! LoncheraO)!;
        let previousIndex = abs((currentIndex - 1) % paginas.count);
        
        quien=currentIndex-1;
        if(quien<0){
            quien=0;
        }
        DatosC.contenedor.iActual=quien;
        print("Before: ",quien);
        return paginas[previousIndex];
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            let currentIndex = paginas.indexOf(viewController as! LoncheraO)!;
            let nextIndex = abs((currentIndex + 1) % paginas.count);
        
        quien=currentIndex+1;
        DatosC.contenedor.iActual=quien;
        print("After: ",quien);
            return paginas[nextIndex];
    }
    
   
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return paginas.count;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
