//
//  BaseOperation.swift
//  BladeKit
//
//  Created by Doug on 4/2/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import Foundation

public class ServerOperation : NSOperation {
    
    public var request : ServerRequest
    public var response : ServerResponse

    public init(request: ServerRequest) {
        self.request = request
        self.response = ServerResponse()
        super.init()
    }
    
    public override func main() {
        let urlReq = self.request.urlRequest()
        //  TODO:(doug)
        //  1 - perform request
        //  2 - parse based on configurable parsing
    }
}
