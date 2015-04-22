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
        var err: NSError?
        var response: NSURLResponse?
        let possibleData = NSURLConnection.sendSynchronousRequest(urlReq, returningResponse: &response, error: &err)
        if let data = possibleData {
            //  run custom parsing on test data at the moment
            if let parsing = self.request.parsingClosure {
                self.response = parsing(data: data)
                self.response.rawResponse = response as? NSHTTPURLResponse
            }
        } else {
            println("Server Err:\(err)")
            self.response.error = err
        }
    }
}
