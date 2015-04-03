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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUrlHeadersEmpty() {
        let req = ServerRequest()
        XCTAssert(req.headerDict.count == 0, "Test Failure")
        XCTAssert(req.urlRequest().allHTTPHeaderFields? == nil, "Test Failure")
    }
    
    func testUrlHeaderPopulation() {
        let req = ServerRequest()
        req.headerDict["Test-HTTP-Header"] = "Test HTTP Header Value"
        XCTAssert(req.headerDict.count == 1, "Test Failure")
        XCTAssert(req.urlRequest().allHTTPHeaderFields? != nil, "Test Failure")
        println(req.urlRequest().valueForHTTPHeaderField("Test-HTTP-Header"))
        XCTAssert(req.urlRequest().valueForHTTPHeaderField("Test-HTTP-Header") == "Test HTTP Header Value", "Test Failure")
    }
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
