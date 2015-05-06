//
//  BaseOperation.swift
//  BladeKit
//
//  Created by Doug on 4/2/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import Foundation

public class ServerOperation : NSOperation {
    
    public var request: ServerRequest
    public var response: ServerResponse
    
    public init(request: ServerRequest) {
        self.request = request
        self.response = ServerResponse()
        super.init()
    }
    
    public override func main() {
        let urlReq = self.request.urlRequest()
        urlReq.timeoutInterval = ServerClient.urlTimeout
        var err: NSError?
        var response: NSURLResponse?
        let data = NSURLConnection.sendSynchronousRequest(urlReq, returningResponse: &response, error: &err)
        self.response = self.request.parsingClosure(data:data, error:err)
        self.response.rawResponse = response as? NSHTTPURLResponse
    }
}
