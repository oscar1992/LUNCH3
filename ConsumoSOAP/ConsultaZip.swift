//
//  ConsultaZip.swift
//  La Lonchera
//
//  Created by Oscar Ramirez on 3/01/17.
//  Copyright © 2017 Edumedio. All rights reserved.
//

import Foundation
import UIKit

class ConsultaZip: NSObject, URLSessionDownloadDelegate{
    
    var task : URLSessionTask!;
    var percentageWritten:Float = 0.0
    var taskTotalBytesWritten = 0
    var taskTotalBytesExpectedToWrite = 0
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory;
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask;
    var paths: String!;
    var entrada : String!;
    var fileManager : FileManager;
    var padre: CargaZip!;
    var vista : LoginView!;
    var n = 0;
    
    lazy var session : Foundation.URLSession = {
        
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = false
        let session = Foundation.URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }();
    
    init(entrada: String, fileM: FileManager, padre: CargaZip){
        self.entrada=entrada;
        self.fileManager=fileM;
        self.padre=padre;
        self.vista = DatosB.cont.loginView;
    }
    
    func descarga(_ n: Int){
        msgInicia();
        self.n=n;
        //for n in 0...9{
            let url:URL = URL(string: "http://93.188.163.97:8080/Lunch2/files/elzip"+String(n)+".zip")!
            /*if self.task != nil {
                return
            }*/
            print("ini descarga: ", n);
            let req = NSMutableURLRequest(url:url);
        
            let task = self.session.downloadTask(with: req as URLRequest);
            self.task = task
            task.resume();
        //}
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten writ: Int64, totalBytesExpectedToWrite exp: Int64) {
        taskTotalBytesWritten = Int(writ);
        taskTotalBytesExpectedToWrite = Int(exp);
        percentageWritten = (Float(taskTotalBytesWritten) / Float(taskTotalBytesExpectedToWrite));
        setBarra(percentageWritten);
        //print("N: ",n," Va en: ", percentageWritten);
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("completed: error: \(error)")
        if(error != nil){
            msgError();
        }
    }
    
    @objc func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true).first;
        entrada = ((paths)! + "/ZipI");
        //
        print("Fin descarga: ", entrada);
        
        if(fileManager.fileExists(atPath: entrada, isDirectory: nil)){
            print("Directorio Existe")
        }else{
            print("Directorio no Existe")
            do{
                try fileManager.createDirectory(atPath: entrada, withIntermediateDirectories: false, attributes: nil);
            }catch{
                print("Error creando el directorio")
            }
        }
        do{
            entrada = paths + ("/elzip"+String(n)+".zip");
            try(fileManager.moveItem(atPath: location.path, toPath: entrada));
            print("Archivo Guardado: ", n);
            padre.descomprimir(entrada);
            //n += 1;
        }catch{
            print("Error guardando archivo: ", n);
        }
        
    }

    
    //Método que establece el porcentaje de la barra de carga
    func setBarra(_ val: Float){
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
