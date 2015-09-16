//
//  BladeKitTests.swift
//  BladeKitTests
//
//  Created by Doug on 4/2/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import UIKit
import XCTest
import BladeKit

class BladeKitTests: XCTestCase {
    
    let opQueue = NSOperationQueue()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - ServerRequest
    func testUrlHeadersEmpty() {
        let req = ServerRequest()
        XCTAssert(req.headerDict.count == 0, "Test Failure")
        XCTAssert(req.urlRequest().allHTTPHeaderFields?.count == 0, "Test Failure")
    }
    
    func testUrlHeaderPopulation() {
        let req = ServerRequest()
        req.headerDict["Test-HTTP-Header"] = "Test HTTP Header Value"
        XCTAssert(req.headerDict.count == 1, "Test Failure")
        XCTAssert(req.urlRequest().allHTTPHeaderFields != nil, "Test Failure")
        print(req.urlRequest().valueForHTTPHeaderField("Test-HTTP-Header"))
        XCTAssert(req.urlRequest().valueForHTTPHeaderField("Test-HTTP-Header") == "Test HTTP Header Value", "Test Failure")
    }
    
    // MARK: - ServerOperation
    func testServerOperationMain() {
        // add async expectation
        let asyncExpectation = self.expectationWithDescription("Standard Async Expectation")
        
        let req = ServerRequest()
        let op = ServerOperation(request: req)
        var test = false
        op.completionBlock = {
            // simple delayed test is all
            XCTAssert(test == true, "Test Failure")
            asyncExpectation.fulfill()
        }
        test = true
        opQueue.addOperation(op)
        self.waitForExpectationsWithTimeout(0.2, handler: { (error) -> Void in
            if (error != nil) {
                XCTFail("Expectation Failed with error: \(error)");
            }
        })
    }
    
    func testServerOperationSimpleUrl() {
        // add async expectation
        let asyncExpectation = self.expectationWithDescription("Standard Async Expectation")
        
        let req = ServerRequest()
        req.url = NSURL(string: "https://google.com")
        req.parsingClosure = { data in
            return ServerResponse()
        }
        ServerClient.performRequest(req){ (response) -> Void in
            XCTAssert(response.rawResponse?.statusCode == 200, "Fail")
            asyncExpectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(0.6, handler: { (error) -> Void in
            if (error != nil) {
                XCTFail("Expectation Failed with error: \(error)");
            }
        })
    }
    
    func testServerOperationRepeatingUrl() {
        // add async expectation
        let asyncExpectation = self.expectationWithDescription("Standard Async Expectation")
        var count = 0
        let req = ServerRequest()
        req.url = NSURL(string: "https://google.com")
        req.parsingClosure = { data in
            return ServerResponse()
        }
        let timer = ServerClient.performRepeatingRequest(req, timeInterval:0.2){ (response) -> Void in
            XCTAssert(response.rawResponse?.statusCode == 200, "Fail")
            count++
            print(count)
            if count > 1 {
                asyncExpectation.fulfill()
            }
        }
        self.waitForExpectationsWithTimeout(0.8, handler: { (error) -> Void in
            timer.invalidate()
            if (error != nil) {
                XCTFail("Expectation Failed with error: \(error)");
            }
        })
    }
    
    func testRequestSerializationEmpty() {
        let request = ServerRequest(url: NSURL(string: "http://www.example.com"))
        let urlReq = request.urlRequest()
        XCTAssert(urlReq.HTTPBody == nil, "Fail")
    }
    
    func testRequestSerializationBasic() {
        let request = ServerRequest(url: NSURL(string: "http://www.example.com"))
        request.parameters = ["Key":"Value"]
        request.httpMethod = .Post
        let urlReq = request.urlRequest()
        XCTAssert(urlReq.HTTPBody != nil, "Fail")
    }
    
    func testRequestSerializationOtherFoundationObjects() {
        let request = ServerRequest(url: NSURL(string: "http://www.example.com"))
        request.parameters = ["Key":NSNull.new(),"Key2":4.0,"Key3":["String"]]
        request.httpMethod = .Post
        let urlReq = request.urlRequest()
        XCTAssert(urlReq.HTTPBody != nil, "Fail")
    }
}
