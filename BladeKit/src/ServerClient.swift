//
//  ServerClient.swift
//  BladeKit
//
//  Created by Doug on 4/1/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import Foundation

public final class ServerClient {
    
    public static var urlTimeout: NSTimeInterval = 30
    
    // MARK: Internal OperationQueue
    private let operationQueue : NSOperationQueue = {
        let opQueue = NSOperationQueue()
        opQueue.maxConcurrentOperationCount = 3
        return opQueue
    }()
    
    // MARK: - Singleton
    private static let sharedInstance = ServerClient()
    
    // MARK: - Making Requests
    /**
    The main networking call, which will run asynchronously on a NSOperationQueue.
    
    :param: ServerRequest The configured object with a variety of interesting information for your networking call.
    :param: ServerResponse After the networking call is completed, this will be called on the main thread.

    :returns: NSOperation
    */
    public class func performRequest(request: ServerRequest, completion:(response: ServerResponse) -> Void) -> NSOperation {
        let op = ServerOperation(request: request)
        let weakOp = op
        op.completionBlock = { [unowned op] in
            if op.cancelled == false {
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    completion(response: op.response)
                })
            }
        }
        ServerClient.enQueueOperation(op)
        return op
    }
    
    /**
    The a repeating networking call, which will repeat itself asynchronously on a NSOperationQueue based on the timeInterval.
    
    :param: ServerRequest The configured object with a variety of interesting information for your networking call.
    :param: NSTimeInterval The repeat interval for the request.
    :param: ServerResponse After the networking call is completed, this will be called on the main thread.
    
    :returns: NSTimer
    */
    public class func performRepeatingRequest(request: ServerRequest, timeInterval:NSTimeInterval, completion:(response: ServerResponse) -> Void) -> NSTimer {
        let fireDate = timeInterval + CFAbsoluteTimeGetCurrent()
        let timer = NSTimer.schedule(repeatInterval: timeInterval, handler:{ nTimer in
            if nTimer.valid {
                ServerClient.performRequest(request, completion:completion)
            }
        })
        return timer
    }
    
    // MARK: NSOperationQueue convenience
    private class func enQueueOperation(operation: NSOperation) {
        self.sharedInstance.operationQueue.addOperation(operation)
    }
}
