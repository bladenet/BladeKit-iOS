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
    
    // MARK: NSOperationQueue convenience for subclasses
    public class func enQueueOperation(operation: NSOperation) {
        self.sharedInstance.operationQueue.addOperation(operation)
    }
}
