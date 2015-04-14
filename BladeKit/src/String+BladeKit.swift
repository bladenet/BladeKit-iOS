//
//  String+Formatting.swift
//  BladeKit
//
//  Originally Created by Brian Bates on 4/14/15.
//  Added to BladeKit by Doug 4/14/15
//  Copyright (c) 2015 Blade. All rights reserved.
//

import Foundation

public extension String {
    
    // Get substring between start and end, inclusive on for the start, non-inclusive for the end
    private func simpleSubstring(start:Int, end:Int) -> String? {
        return self.substringWithRange(Range<String.Index>(start: advance(self.startIndex, start), end: advance(self.startIndex, end)))
    }
    
    // Ability to pass an integer range in string subscripts
    public subscript(range: Range<Int>) -> String? {
        get {
            return self.simpleSubstring(range.startIndex, end: range.endIndex)
        }
    }
    
    // Ability to pass an integer index for a string subscript
    public subscript(index: Int) -> Character? {
        get {
            return self[advance(self.startIndex, index)]
        }
    }
    
    // Get a formatted phone number representation of the given string.
    // If the string cannot be parsed as a valid phone number, then return nil
    // NOTE: Currently only supports US phone numbers
    public var asPhoneNumber: String? {
        if self == "" {
            return nil
        }
        
        let numberComponents = self.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        let numbersOnly = "".join(numberComponents)
        
        var formatted : String? = nil
        if count(numbersOnly) == 11 && numbersOnly[0] == "1" {
            //let firstThree: String! = numbersOnly.simpleSubstring(1, end: 3)
            let firstThree: String! = numbersOnly[1...3]
            let secondThree: String! = numbersOnly[4...6]
            let lastFour: String! = numbersOnly[7...10]
            formatted = "1-\(firstThree)-\(secondThree)-\(lastFour)"
        } else if count(numbersOnly) == 10 {
            //let firstThree: String! = numbersOnly.simpleSubstring(0, end: 2)
            let firstThree: String! = numbersOnly[0...2]
            let secondThree: String! = numbersOnly[3...5]
            let lastFour: String! = numbersOnly[6...9]
            formatted = "(\(firstThree)) \(secondThree)-\(lastFour)"
        } else if count(numbersOnly) == 7 {
            let firstThree: String! = numbersOnly[0...2]
            let lastFour: String! = numbersOnly[3...6]
            formatted = "(\(firstThree)) \(lastFour)"
        }
        return formatted
    }
}