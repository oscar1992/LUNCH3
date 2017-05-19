//
//  SubVista2.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 7/03/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import UIKit

class SubVista2: UIWebView, UIWebViewDelegate{
    
    var list: ListCard!;
    
    init(frame: CGRect, list: ListCard) {
        self.list=list;
        super.init(frame: frame);
        self.delegate=self;
        self.hideKeyboardWhenTappedAround();
        NotificationCenter.default.addObserver(self, selector: #selector(SubVista2.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //print("Teclado: ", frame);
        print("bajaweb??");
        DatosK.cont.tecladoFrame=frame;
        if(self.superview!.superview != nil){
                DatosK.cont.bajaVista(self.superview!.superview!);
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Carga Web");
        for vista in webView.subviews{
            if(vista.accessibilityIdentifier == "gif"){
                vista.removeFromSuperview();
                
            }
        }
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                print("Nomb: ", cookie.name);
                if(cookie.name == "pmntz_add_success" && cookie.value == "true"){
                    print("Estado: ", cookie.value);
                    print("Lista: ", list);
                    list.pintaDebita();
                    list.cerrarVista();
                    let msg = VistaMensaje(msg: "Tarjeta ingresada exitosamente");
                    DatosB.cont.datosPadre.view.addSubview(msg);
                    self.superview?.addSubview(msg);
                }else if(cookie.name == "pmntz_error_message" && cookie.value != ""){
                    let msg = VistaMensaje(msg: "Tarjeta No ingresada");
                    DatosB.cont.datosPadre.view.addSubview(msg);
                    self.superview?.addSubview(msg);

                }
                print("\(cookie)")
            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        print("bajaweb?")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.addGestureRecognizer(tap)
        for vista in self.subviews{
            if (vista.accessibilityIdentifier=="Despliega2"){
                print("Remueve")
                vista.removeFromSuperview();
            }
        }
    }
    
    func dismissKeyboard() {
        DatosK.cont.bajaVista(self.superview!);
        self.endEditing(true)
    }

}
