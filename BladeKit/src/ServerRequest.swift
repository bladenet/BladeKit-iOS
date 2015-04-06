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
    public var parsingClosure : ((data: NSData) -> ServerResponse)?
    
    public func urlRequest() -> NSMutableURLRequest {
        let req = NSMutableURLRequest()
        for (key, value) in self.headerDict {
            req.setValue(value, forHTTPHeaderField: key)
        }
        return req
    }
}
