//
//  IngresaFavoritos.swift
//  ConsumoSOAP
//
//  Created by Oscar Ramirez on 9/06/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class IngresaFavoritos: NSObject , NSURLConnectionDelegate, NSXMLParserDelegate{
    
    var resp: NSData! = nil
    var estado:NSMutableString!
    var parser=NSXMLParser()
    var eeleDiccio=NSMutableDictionary()
    
    var element=NSString()
    var padre : String!;
    var prodid : String!;
    var bot : UIButton?;
    var predeter: Predeterminadas?;
    var favorita: Favoritos!;
    
    //Método que permite evaluar si la caja viene vacía, de ser así no ejecuta la carga
    func evalua(prods: [Producto], id:Int){
        bot = DatosB.cont.home2.lonchera.botfavo;
        print("cuenta: ", prods.count);
        if(prods.count == 0){
            
        }else{
            bot?.enabled = false;
            favorita=Favoritos(id: id, nombre: "Nueva");
            favorita.items=prods;
            //bot?.backgroundColor = UIColor.grayColor();
            envia(prods, id: id);
            print("Envia");
        }
    }
    
    func envia(prods: [Producto], id: Int){
        
        
        
        var intermedio:String = "";
        for prod in prods{
            
            padre = String(DatosD.contenedor.padre.id!);
            prodid = String(prod.id!);
            print("pad: ", padre!);
            print("prod: ", prodid!);
            intermedio += "<lista><idFavorito>?</idFavorito><nlonchera><idNumeroLonchera>"+String(id)+"</idNumeroLonchera><padre><idPadre>"+padre!+"</idPadre></padre></nlonchera><producto><idProducto>"+prodid!+"</idProducto></producto></lista>";
        }
        //print("INT: ", intermedio);
        let mensajeEnviado:String = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:enp='http://enpoint.lunch.com.co/'><soapenv:Header/><soapenv:Body><enp:ingresaFavoritos>"+intermedio+"</enp:ingresaFavoritos></soapenv:Body></soapenv:Envelope>";
        print("Envia: ", mensajeEnviado);
        let is_URL: String = "http://93.188.163.97:8080/Lunch2/clienteEndpoint"
        
        let lobj_Request = NSMutableURLRequest(URL: NSURL(string: is_URL)!)
        let session = NSURLSession.sharedSession()
        let _: NSError?
        
        lobj_Request.HTTPMethod = "POST"
        lobj_Request.HTTPBody = mensajeEnviado.dataUsingEncoding(NSUTF8StringEncoding)
        lobj_Request.addValue("www.lunch.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(mensajeEnviado.characters.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("\"bool\"", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTaskWithRequest(lobj_Request, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.resp=strData?.dataUsingEncoding(NSUTF8StringEncoding)
            
            //print("Body: \(strData)")
            
            if error != nil
            {
                print("Error: " + error!.description)
            }
            //print(self.resp)
            self.parser=NSXMLParser(data: self.resp)
            self.parser.delegate=self
            self.parser.parse();
            dispatch_async(dispatch_get_main_queue(),{
                self.bot?.enabled = true;
                //self.bot?.backgroundColor = UIColor.yellowColor();
                self.poneDorada();
                print("Sube OK")
                
            });
            
        })
        
        task.resume();
    }
    
    //Método que pone la estrella dorada si la carga fue exitosa
    func poneDorada(){
        for vista in bot!.subviews{
            if(vista is UIImageView){
                vista.removeFromSuperview();
            }
        }
        let frameImagen = CGRectMake(0, 0, self.bot!.frame.width, self.bot!.frame.height);
        let ima = UIImage(named: "BotonFF");
        let backImg = UIImageView(frame: frameImagen);
        backImg.image=ima;
        bot!.addSubview(backImg);
        
        /*
        let cargaF = CargaFavoritos();
        cargaF.pred=self.predeter;
        cargaF.consulta(DatosD.contenedor.padre.id);
        */
        DatosB.cont.favoritos.append(favorita);
        DatosB.cont.home2.predeterminadas.cini=true;
        DatosB.cont.home2.predeterminadas.cargaSaludables();
    }
}
