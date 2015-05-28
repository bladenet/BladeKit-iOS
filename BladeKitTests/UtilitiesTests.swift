//
//  UtilitiesTests.swift
//  BladeKit
//
//  Created by Brian Bates on 5/1/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import UIKit
import XCTest
import BladeKit

class UtilitiesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Version Utilities Tests
    
    func testMajorVersion() {
        XCTAssertEqual(1, VersionUtils.majorVersion("1.0.0"), "Major version fail")
        XCTAssertEqual(0, VersionUtils.majorVersion(""), "Major version fail")
        XCTAssertEqual(0, VersionUtils.majorVersion("foobar.1.0"), "Major version fail")
        XCTAssertEqual(0, VersionUtils.majorVersion("0.1.1"), "Major version fail")
        XCTAssertEqual(4, VersionUtils.majorVersion("4"), "Major version fail")
        XCTAssertEqual(4, VersionUtils.majorVersion("4.0"), "Major version fail")
    }
    
    func testMinorVersion() {
        XCTAssertEqual(0, VersionUtils.minorVersion("1.0.0"), "Minor version fail")
        XCTAssertEqual(0, VersionUtils.minorVersion("4"), "Minor version fail")
        XCTAssertEqual(3, VersionUtils.minorVersion("4.3"), "Minor version fail")
        XCTAssertEqual(0, VersionUtils.minorVersion(""), "Minor version fail")
        XCTAssertEqual(0, VersionUtils.minorVersion("1.foobar.0"), "Minor version fail")
        XCTAssertEqual(1, VersionUtils.minorVersion("0.1.1"), "Minor version fail")
    }
    
    func testPatchVersion() {
        XCTAssertEqual(0, VersionUtils.patchVersion("1.0.0"), "Patch version fail")
        XCTAssertEqual(0, VersionUtils.patchVersion("4"), "Patch version fail")
        XCTAssertEqual(12, VersionUtils.patchVersion("4.3.12"), "Patch version fail")
        XCTAssertEqual(0, VersionUtils.patchVersion(""), "Patch version fail")
        XCTAssertEqual(0, VersionUtils.patchVersion("1.1.foobar"), "Patch version fail")
        XCTAssertEqual(1, VersionUtils.patchVersion("0.1.1"), "Patch version fail")
    }
    
    func testCompareVersions() {
        XCTAssert(VersionUtils.compareVersions("1.0.0", "1.0.1") < 0, "Compare versions fail")
        XCTAssert(VersionUtils.compareVersions("1.0.1", "1.0.0") > 0, "Compare versions fail")
        XCTAssert(VersionUtils.compareVersions("1.2.3", "1.2.3") == 0, "Compare versions fail")
        XCTAssert(VersionUtils.compareVersions("2.0.0", "1.3.12") > 0, "Compare versions fail")
        XCTAssert(VersionUtils.compareVersions("1.12.0", "1.13.3") < 0, "Compare versions fail")
        XCTAssert(VersionUtils.compareVersions("", "1") < 0, "Compare versions fail")
        XCTAssert(VersionUtils.compareVersions("1", "1.0.0") == 0, "Compare versions fail")
        XCTAssert(VersionUtils.compareVersions("1", "1.0.1") < 0, "Compare versions fail")
    }
}
