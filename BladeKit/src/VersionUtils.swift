//
//  VersionUtils.swift
//  BladeKit
//
//  Created by Brian Bates on 5/1/15.
//  Copyright (c) 2015 Blade. All rights reserved.
//

import Foundation

public class VersionUtils {

    private class func getVersionAtIndex(versionString: String, index: Int) -> Int {
        var pieces = split(versionString) {$0 == "."}
        if pieces.count > index, let version = pieces[index].toInt() {
            return version
        }  else {
            return 0
        }
    }
    
    public class func majorVersion(versionString: String) -> Int {
        return getVersionAtIndex(versionString, index: 0)
    }
    
    public class func minorVersion(versionString: String) -> Int {
        return getVersionAtIndex(versionString, index: 1)
    }
    
    public class func patchVersion(versionString: String) -> Int {
        return getVersionAtIndex(versionString, index: 2)
    }
    
    /**
    Comparator for version strings.
    
    :param: String1 The first string version to compare.
    :param: String2 The second string version to compare.
    
    :returns: -1 if v1 < 2, 0 if v1 == v2 and 1 if v1 > v2
    */
    public class func compareVersions(v1: String, _ v2: String) -> Int {
        if majorVersion(v1) != majorVersion(v2) {
            return majorVersion(v1) - majorVersion(v2)
        } else if minorVersion(v1) != minorVersion(v2) {
            return minorVersion(v1) - minorVersion(v2)
        } else if patchVersion(v1) != patchVersion(v2) {
            return patchVersion(v1) - patchVersion(v2)
        } else {
            return 0
        }
    }

}
