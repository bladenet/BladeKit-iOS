//
//  Response.swift
//  BladeKit
//
//  Created by Doug on 4/2/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import Foundation

public class ServerResponse : BaseObject {
    public var error : NSError?
    public var rawResponse : NSHTTPURLResponse?
    public var genericResults: AnyObject = [:]
    
    public func results() -> AnyObject {
        return self.genericResults
    }
}
