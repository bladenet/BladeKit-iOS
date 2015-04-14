//
//  ExtensionsTests.swift
//  BladeKitTests
//
//  Created by Doug on 4/14/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import UIKit
import XCTest
import BladeKit

class ExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test String Extensions
    func testStringSubscriptExtensionIndexStart() {
        let str = "cats"
        XCTAssert(str[0] == "c", "Fail")
    }

    func testStringSubscriptExtensionIndexNegative() {
        let str = "cats"
        XCTAssert(str[-1] == nil, "Fail")
    }
    
    func testStringSubscriptExtensionIndexOkay() {
        let str = "cats"
        XCTAssert(str[3] == "s", "Fail")
    }
    
    func testStringSubscriptExtensionIndexJustOver() {
        let str = "cats"
        XCTAssert(str[4] == nil, "Fail")
    }
    
    func testStringSubscriptExtensionIndexOverflow() {
        let str = "cats"
        XCTAssert(str[10] == nil, "Fail")
    }
    
    func testInitialRangeValid() {
        let str = "cats"
        XCTAssert(str[0...2] == "cat", "Fail")
    }
    
//    func testInitialRangeInValid() {
//        let str = "cats"
//        XCTAssert(str[-1...2] == "cat", "Fail")
//    }
}