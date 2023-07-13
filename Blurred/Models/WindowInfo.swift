//
//  WindowInfo.swift
//  Dimmer Bar
//
//  Created by phucld on 1/7/20.
//  Copyright © 2020 Dwarves Foundation. All rights reserved.
//

import Foundation
import Cocoa

// The keys that are guaranteed to be available in a window’s information dictionary.
// https://developer.apple.com/documentation/coregraphics/quartz_window_services/required_window_list_keys?language=objc

struct WindowInfo {

    var alpha: Double
    var backingLocationVideoMemory: Bool?
    var bounds: CGRect?
    var isOnScreen: Bool?
    var layer: Int
    var memoryUsage: Double
    var name: String?
    var number: Int
    var ownerName: String?
    var ownerPID: Int
    var sharingState: Int
    var storeType: Int
}

extension WindowInfo {

    init(dict: [String: Any]) {
        alpha = dict["kCGWindowAlpha"] as? Double ?? 0
        backingLocationVideoMemory = dict["CGWindowBackingLocationVideoMemory"] as? Bool
        // swiftlint:disable:next force_cast
        let boundsDict =  dict["kCGWindowBounds"] as! CFDictionary
        bounds = CGRect(dictionaryRepresentation: boundsDict)
        isOnScreen = dict["kCGWindowIsOnscreen"] as? Bool
        layer = dict["kCGWindowLayer"] as? Int ?? 0
        memoryUsage = dict["kCGWindowMemoryUsage"] as? Double ?? 0
        name = dict["kCGWindowName"] as? String
        number = dict["kCGWindowNumber"] as? Int ?? 0
        ownerName = dict["kCGWindowOwnerName"] as? String
        ownerPID = dict["kCGWindowOwnerPID"] as? Int ?? 0
        sharingState = dict["kCGWindowSharingState"] as? Int ?? 0
        storeType = dict["kCGWindowStoreType"] as? Int ?? 0
    }
}
