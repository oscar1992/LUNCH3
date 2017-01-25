//
//  ConsultaZip.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 3/01/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class ConsultaZip: NSObject, NSURLSessionDownloadDelegate{
    
    var task : NSURLSessionTask!;
    var percentageWritten:Float = 0.0
    var taskTotalBytesWritten = 0
    var taskTotalBytesExpectedToWrite = 0
    let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory;
    let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask;
    var paths: String!;
    var entrada : String!;
    var fileManager : NSFileManager;
    var padre: CargaZip!;
    var vista : LoginView!;
    var n = 0;
    
    lazy var session : NSURLSession = {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        config.allowsCellularAccess = false
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        return session
    }();
    
    init(entrada: String, fileM: NSFileManager, padre: CargaZip){
        self.entrada=entrada;
        self.fileManager=fileM;
        self.padre=padre;
        self.vista = DatosB.cont.loginView;
    }
    
    func descarga(n: Int){
        msgInicia();
        self.n=n;
        //for n in 0...9{
            let url:NSURL = NSURL(string: "http://93.188.163.97:8080/Lunch2/files/elzip"+String(n)+".zip")!
            /*if self.task != nil {
                return
            }*/
            print("ini descarga: ", n);
            let req = NSMutableURLRequest(URL:url);
            let task = self.session.downloadTaskWithRequest(req)
            self.task = task
            task.resume();
        //}
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten writ: Int64, totalBytesExpectedToWrite exp: Int64) {
        taskTotalBytesWritten = Int(writ);
        taskTotalBytesExpectedToWrite = Int(exp);
        percentageWritten = (Float(taskTotalBytesWritten) / Float(taskTotalBytesExpectedToWrite));
        setBarra(percentageWritten);
        //print("N: ",n," Va en: ", percentageWritten);
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        print("completed: error: \(error)")
        if(error != nil){
            msgError();
        }
    }
    
    @objc func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        entrada = (paths?.stringByAppendingString("/ZipI"))!;
        //
        print("Fin descarga: ", entrada);
        
        if(fileManager.fileExistsAtPath(entrada, isDirectory: nil)){
            print("Directorio Existe")
        }else{
            print("Directorio no Existe")
            do{
                try fileManager.createDirectoryAtPath(entrada, withIntermediateDirectories: false, attributes: nil);
            }catch{
                print("Error creando el directorio")
            }
        }
        do{
            entrada = paths.stringByAppendingString("/elzip"+String(n)+".zip");
            try(fileManager.moveItemAtPath(location.path!, toPath: entrada));
            print("Archivo Guardado: ", n);
            padre.descomprimir(entrada);
            //n += 1;
        }catch{
            print("Error guardando archivo: ", n);
        }
        
    }

    
    //Método que establece el porcentaje de la barra de carga
    func setBarra(val: Float){
        if(vista.barra == nil){
            vista.iniciamsg();
            //vista.texto?.text="Inicia Carga Productos";
        }
        if(val > vista.barra.progress){
            vista.barra.progress = val;
        }else{
            //vista.barra.progress = (val+vista.barra.progress)/2;
        }
    }
    
    func msgInicia(){
        //print("carga tags");
        let vista = DatosB.cont.loginView;
        if(vista.ingresa != nil){
            if(vista.vista==nil){
                vista.iniciamsg();
            }
            vista.texto?.text="Inicia Carga Imágenes";
        }
    }
    
    var errCamt = 0;
    
    func msgError(){
        let vista = DatosB.cont.loginView;
        if(vista.vmsg == nil){
            print("Ini msg");
            vista.errorZip();
        }
    }
    
}
