//
//  Request.swift
//  BladeKit
//
//  Created by Doug on 4/2/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import Foundation

public class ServerRequest : BaseObject {
    
    public var headerDict = Dictionary<String,String>()
    public var url : NSURL?
    public var parsingClosure : ((data: NSData?, error: NSError?) -> ServerResponse) = {data, error in
        let sr = ServerResponse()
        if error != nil || data == nil {
            sr.error = error
            
        } else {
            if let rd = data {
                // default to JSON Serialization
                if let parsed: AnyObject = NSJSONSerialization.JSONObjectWithData(rd, options: NSJSONReadingOptions.MutableContainers, error: nil) {
                    sr.genericResults = ["results":parsed]
                }
            }
        }
        return sr
    }
    
    public func urlRequest() -> NSMutableURLRequest {
        let req = NSMutableURLRequest()
        for (key, value) in self.headerDict {
            req.setValue(value, forHTTPHeaderField: key)
        }
        req.URL = url
        return req
    }
}
