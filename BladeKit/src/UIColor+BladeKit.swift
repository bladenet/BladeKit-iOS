//
//  UIColor+BladeKit.swift
//  BladeKit
//
//  Created by Doug on 4/13/15.
//  Copyright (c) 2015 BladeKit, Inc. All rights reserved.
//

import Foundation

public extension UIColor {
    
    private static let notAllowed = NSCharacterSet.alphanumericCharacterSet().invertedSet
    
    public static func colorFromInitials(initials: String) -> UIColor {
        var total = 0.0
        var index = 0.0
        var utf8A: UnicodeScalar {
            for code in "A".unicodeScalars {
                return code
            }
            return UnicodeScalar(1) // useless
        }
        // clean
        let cleanInitials = initials.stringByTrimmingCharactersInSet(notAllowed)
        for codeUnit in cleanInitials.unicodeScalars {
            let code = codeUnit.value - utf8A.value
            let denom = Double(pow(26.0, index + 1.0))
            let addition = Double(code) / denom
            total += addition
            index++
        }
        total = floor((total == 1.0) ? 255.0 : total * 256.0)
        return UIColor(hue: CGFloat(total/255.0), saturation: 170.6752/255.0, brightness: 170.0/255.0, alpha: 1.0)
    }
}
