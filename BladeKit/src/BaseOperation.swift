//
//  BaseOperation.swift
//  BladeKit
//
//  Created by Doug on 4/2/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import Foundation

public class BaseOperation : NSOperation {
    
    public var request : ServerRequest?
    
    public override func main() {
        if let urlReq = self.request?.urlRequest() {
            //  TODO:(doug)
            //  1 - perform request
            //  2 - parse based on configurable parsing
        }
    }
}
