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
    
    // MARK: Test String Extensions, Subscripts
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
    
    func testInitialRangeInValidStartNegative() {
        let str = "cats"
        XCTAssert(str[-1...2] == nil, "Fail")
    }
    
    func testInitialRangeInValidStartPastEnd() {
        let str = "cats"
        XCTAssert(str[-10...2] == nil, "Fail")
    }
    
    func testInitialRangeValidStartEqualsEnd() {
        let str = "cats"
        XCTAssert(str[3...3] == "s", "Fail")
    }
    
    func testInitialRangeInValidEndBeyondRange() {
        let str = "cats"
        XCTAssert(str[3...4] == nil, "Fail")
    }
    
    func testUSPhoneNumberDisplayValidWithOne() {
        let str = "19782139963"
        XCTAssert(str.asPhoneNumber == "1-978-213-9963", "Fail")
    }
    
    func testUSPhoneNumberDisplayValidWithoutOne() {
        let str = "9782139963"
        println(str.asPhoneNumber)
        XCTAssert(str.asPhoneNumber == "(978) 213-9963", "Fail")
    }
    
    func testUSPhoneNumberDisplayValidLastSevenOnly() {
        let str = "2139963"
        println(str.asPhoneNumber)
        XCTAssert(str.asPhoneNumber == "213-9963", "Fail")
    }
    
    // MARK: Test String Extensions, Helpers
    
    func testUSPhoneNumberDisplayNotFullNumber() {
        let str = "093"
        XCTAssert(str.asPhoneNumber == nil, "Fail")
    }
    
    func testDoesContainSubstr() {
        let str = "longstr"
        XCTAssertTrue(str.doesContainSubstring("long"), "Fail")
    }
    
    func testDoesNotContainSubstr() {
        let str = "longstr"
        XCTAssertFalse(str.doesContainSubstring("cat"), "Fail")
    }
    
    func testDoesContainBackwardFragment() {
        let str = "longstr"
        XCTAssertFalse(str.doesContainSubstring("longstrextending"), "Fail")
    }
    
    func testDoesNotContainEmptyStr() {
        let str = "longstr"
        XCTAssertFalse(str.doesContainSubstring(""), "Fail")
    }
    
    // MARK: UIColor Extensions, Test
    func testValidCharsForOneInital() {
        let initials = "B"
        let result = UIColor.colorFromInitials(initials)
        var hue: CGFloat = 0.0
        result.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        XCTAssert(hue > 0.0352941176470588, "Fail")
        XCTAssert(hue < 0.0352941176470600, "Fail")
    }
    
    func testValidCharsForInitals() {
        let initials = "ZA"
        let result = UIColor.colorFromInitials(initials)
        var hue: CGFloat = 0.0
        result.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        XCTAssert(hue > 0.964705882352940, "Fail")
        XCTAssert(hue < 0.964705882352947, "Fail")
    }
    
    func testInValidCharsForInitalsOne() {
        let initials = "()"
        let result = UIColor.colorFromInitials(initials)
        var hue: CGFloat = 0.0
        result.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        XCTAssert(hue > 0.99999999, "Fail")
        XCTAssert(hue < 1.00000001, "Fail")
    }
    
    func testInValidCharsForInitalsTwo() {
        let initials = ""
        let result = UIColor.colorFromInitials(initials)
        var hue: CGFloat = 0.0
        result.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        println("hue \(hue)")
        XCTAssert(hue > 0.99999999, "Fail")
        XCTAssert(hue < 1.00000001, "Fail")
    }
    
    func testInValidCharsForInitalsThree() {
        let initials = "😃 😹"
        let result = UIColor.colorFromInitials(initials)
        var hue: CGFloat = 0.0
        result.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        println("hue \(hue)")
        XCTAssert(hue > 0.99999999, "Fail")
        XCTAssert(hue < 1.00000001, "Fail")
    }
    
    func testInValidCharsForInitalsFour() {
        let initials = "か礯 ヰを訦 ヒェ䋧 秞囥勯 襩㛤ㄨ㠣榊 ヴャざ襪へ姥 绨ぺ樧 䄦ラ 秦榯奯駪ちょ 椩祚婨谢µ, 壎榚 つぞ䣊と䪥 び"
        let result = UIColor.colorFromInitials(initials)
        var hue: CGFloat = 0.0
        result.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        XCTAssert(hue > 0.117647058823520, "Fail")
        XCTAssert(hue < 0.117647058823535, "Fail")
    }
    
    func testInvalidCharsForInitialsFive() {
        let initials = "тคคяє Zคмєєภ թคя - ค мσ√เє ๒єyσภ∂ ฬσя∂ร !!!"
        let result = UIColor.colorFromInitials(initials)
        var hue: CGFloat = 0.0
        result.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        XCTAssert(hue > 0.117647058823520, "Fail")
        XCTAssert(hue < 0.117647058823535, "Fail")
    }
    
    func testInvalidOverflowForInitials() {
        let initials = "0S"
        let result = UIColor.colorFromInitials(initials)
        var hue: CGFloat = 0.0
        result.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
        XCTAssert(hue > 0.99999999, "Fail")
        XCTAssert(hue < 1.00000001, "Fail")
    }
}
