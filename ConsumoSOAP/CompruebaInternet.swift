//
//  CompruebaInternet.swift
//  Lunch1
//
//  Created by Oscar Ramirez on 29/09/16.
//  Copyright © 2016 Edumedio. All rights reserved.
//

import Foundation
import SystemConfiguration

class CompruebaInternet: NSObject {
    
    func tieneConexion()->Bool{
        var Status:Bool = false
        let url = URL(string: "http://google.com/")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        let response: URLResponse?
        
        //var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
        
        /*if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        */
        return Status
    }
    
}
