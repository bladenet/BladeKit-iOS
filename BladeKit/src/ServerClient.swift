//
//  ServerClient.swift
//  BladeKit
//
//  Created by Doug on 4/1/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import Foundation

public class ServerClient {
    
    // MARK: Internal OperationQueue
    private let operationQueue : NSOperationQueue = {
        let opQueue = NSOperationQueue()
        opQueue.maxConcurrentOperationCount = 3
        return opQueue
    }()
    
    // MARK: - Singleton
    class var sharedInstance: ServerClient {
        struct Static {
            static let instance : ServerClient = ServerClient()
        }
        return Static.instance
    }
    
    // MARK: - Generic Request
    public class func performGenericRequest(request: ServerRequest, completion:(response: ServerResponse) -> Void) -> NSOperation {
        let op = ServerOperation(request: request)
        op.completionBlock = {
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                completion(response: op.response)
            })
        }
        ServerClient.enQueueOperation(op)
        return op
    }
    
    // MARK: NSOperationQueue convenience
    private class func enQueueOperation(operation: NSOperation) {
        self.sharedInstance.operationQueue.addOperation(operation)
    }
}
