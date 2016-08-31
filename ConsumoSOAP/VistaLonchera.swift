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
    var control : UIPageControl?;

    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.delegate=self;
        self.dataSource=self;
        //print("desliza:self.appearance
        
        var p=CGFloat(1);//Dia de la semana en la que empieza
        for _ in 1..<7{
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
            //print("p: ", p);
            let lonchera=LoncheraO();
            lonchera.inicia(Int(p));
            lonchera.padre=self;
            paginas.append(lonchera);
            DatosC.contenedor.loncheras.append(lonchera);
            
            p+=1;
            
            //lonchera.view.backgroundColor=UIColor.init(red: (0+(0.2*p)), green: (1-(0.2*p)), blue: 1, alpha: 1);
        }
        setViewControllers([paginas[0]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
        //control?.currentPage = 1;
        //DatosC.contenedor.iActual=0;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if(paginas.count==1){
            return nil;
        }else{
            let currentIndex = control?.currentPage;
            var previousIndex = abs((currentIndex! - 1) % paginas.count);
            
            let actual = control?.currentPage;
            //print("acc: ", actual);
            if(actual <= 0 || paginas[actual!] == NSNotFound){
                //print("pre-reduce: ", actual);
                previousIndex = paginas.count-1;
                //print("reduce: ", previousIndex);
            }
            //print("prev: ", previousIndex);
            return paginas[previousIndex];
        }

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        //let currentIndex = paginas.indexOf(viewController as! LoncheraO)!;
        let currentIndex = control?.currentPage;
        //print("actualA: ", currentIndex);
        let nextIndex2 = abs((currentIndex! + 1) % paginas.count);
        //let nextIndex = control!.currentPage + 1;
        //print("nextA", nextIndex);
        //quien = currentIndex!;
        //quien=currentIndex+1;
        //DatosC.contenedor.iActual=quien;
        //print("Quien A: ",quien, " sumado: ", nextIndex, "dividido: ", nextIndex2);
        return paginas[nextIndex2];
    }
    
   
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return paginas.count;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 0;
    }
    
    
    //Método que moverá el sroll a una lonchera indicada
    func mueveAPosicion(pos: Int){
        //var p=paginas.indexOf(lon)
        var pos2 = pos-1;
        if(pos2 < 0){
            pos2 = 0;
        }
        
        self.setViewControllers([paginas[pos2]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
        control?.currentPage=pos2;
        DatosC.contenedor.iActual=pos2;
        DatosC.contenedor.ninoActual?.cambiaLonchera(pos2+1);
        //quien = control!.currentPage;
        //print("quien: ", quien);
        //self.pageViewController(self, viewControllerAfterViewController: lon);
        /*
        let frameM = CGRectMake((self.view.frame.origin.x-(100*CGFloat(p!))), self.view.frame.origin.y, self.view.frame.width, self.view.frame.height);
        self.view.frame=frameM;
        */
        //print("FF", self.viewControllers?.last?.view.frame);
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        
        DatosC.contenedor.iActual = control!.currentPage;
        //print("ABC: ", DatosC.contenedor.iActual);
        DatosC.contenedor.lonchera = paginas[(control?.currentPage)!];
        DatosC.contenedor.ninoActual?.cambiaLonchera(DatosC.contenedor.iActual+1);
        //revisa();
        
    }
    
   
    
    
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews {
            if subView is UIScrollView {
                //print("scroll");
                subView.frame = self.view.bounds
            } else if subView is UIPageControl {
                control = subView as? UIPageControl;
                
                //control?.currentPage = 0;
                //control?.pageIndicatorTintColor = UIColor.redColor();
                //control?.currentPageIndicatorTintColor = UIColor.blackColor();
                //print("pagecontrol: ", control?.currentPage);
                subView.frame=CGRectZero;
                control?.hidden=true;
                
                self.view.bringSubviewToFront(subView)
            }
        }
        super.viewDidLayoutSubviews()
    }
    
    //Método que reemplaza las loncheras
    func reemplazaLonchera(lonchN : [LoncheraO], diaSemana: Int){
        self.paginas.removeAll();
        self.paginas = lonchN;
        var p = 0;
        for pag in paginas{
            pag.fecha = lonchN[p].fecha;
            
            pag.contador!.actua();
            //print("pp: ",pag.contador?.pre2?.text);
            print("pp: ",pag.fechaVisible?.text);
            //print("llF: ", lonchN[p].fecha);
            //print("ffN: ", pag.fecha);
            p += 1;
        }
        //print("diaS: ", diaSemana);
        var pos = diaSemana;
        pos -= 1;
        if(diaSemana == 0){
            pos = lonchN.count;
        }
        setViewControllers([paginas[pos]], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion: nil);
        control?.currentPage=pos;
        DatosC.contenedor.iActual=pos;
        DatosC.contenedor.ninoActual?.cambiaLonchera(control!.currentPage+1);
        //revisa();
    }
    
    //Método que permite cambiar a una lonchera determinada
    func rotaLonc(Iact: Int, siguiente: Bool){
        var pos = 0;
        var direction = UIPageViewControllerNavigationDirection.Forward;
        if(siguiente){
            print("tot: ", paginas.count);
            print("trae : ", Iact);
            if(Iact >= paginas.count-1){
                pos = 0;
            }else{
                pos = Iact+1
            }
            
        }else{
            if(Iact <= 0){
                pos = paginas.count-1;
            }else{
                pos = Iact-1;
            }
            direction = UIPageViewControllerNavigationDirection.Reverse;
        }
        print("Iact: ", pos);
        setViewControllers([paginas[pos]], direction: direction , animated: true, completion: nil);
        control?.currentPage=pos;
        DatosC.contenedor.iActual=pos;
        DatosC.contenedor.ninoActual?.cambiaLonchera(control!.currentPage+1);
        quien=pos;
        //revisa();
    }
    
    //Método de debug que muestra las loncheras de la semana
    func revisa(){
        for lon in paginas{
            print("Lon: ", lon.fechaVisible?.text, " - ", lon.contador?.pre2?.text);
        }
        print("Actual: ", DatosC.contenedor.iActual);
        print("Control: ", control?.currentPage);
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
