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
    }
    
    func descarga(){
        let url:NSURL = NSURL(string: "http://93.188.163.97:8080/Lunch2/files/elzip.zip")!
        if self.task != nil {
            return
        }
        let req = NSMutableURLRequest(URL:url);
        let task = self.session.downloadTaskWithRequest(req)
        self.task = task
        task.resume();
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten writ: Int64, totalBytesExpectedToWrite exp: Int64) {
        taskTotalBytesWritten = Int(writ);
        taskTotalBytesExpectedToWrite = Int(exp);
        percentageWritten = (Float(taskTotalBytesWritten) / Float(taskTotalBytesExpectedToWrite))*100;
        print("Va en: ", percentageWritten);
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        //print("completed: error: \(error)")
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
        if(fileManager.fileExistsAtPath(location.path!)){
            print("Zip en el temporal");
        }else{
            print("Temporal vacio");
            
        }
        /*
        let data = NSData(contentsOfURL: location);
        if (data?.length>0){
            entrada = paths.stringByAppendingString("/elzip2.zip");
            print("ENTRADA F: ", entrada);
            print("CREA: ", fileManager.createFileAtPath(entrada, contents: data, attributes: nil));
        }
        */
        do{
            entrada = paths.stringByAppendingString("/elzip2.zip");
            try(fileManager.moveItemAtPath(location.path!, toPath: entrada));
            print("Archivo Guardado")
        }catch{
            print("Error guardando archivo");
        }
        
    }
    
}
