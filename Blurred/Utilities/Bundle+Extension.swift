//
//  Bundle+Extension.swift
//  Dimmer Bar
//
//  Created by phucld on 1/14/20.
//  Copyright © 2020 Dwarves Foundation. All rights reserved.
//

import Foundation

extension Bundle {

    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}
