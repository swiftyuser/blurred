//
//  GlobalKeyBindPreferences.swift
//  Blurred
//
//  Created by phucld on 2/19/20.
//  Copyright © 2020 Dwarves Foundation. All rights reserved.
//

import Foundation

struct GlobalKeybindPreferences: Codable, CustomStringConvertible {

    let function: Bool
    let control: Bool
    let command: Bool
    let shift: Bool
    let option: Bool
    let capsLock: Bool
    let carbonFlags: UInt32
    let characters: String?
    let keyCode: UInt32

    var description: String {
        var stringBuilder = ""
        if function {
            stringBuilder += "Fn"
        }
        if control {
            stringBuilder += "⌃"
        }
        if option {
            stringBuilder += "⌥"
        }
        if command {
            stringBuilder += "⌘"
        }
        if shift {
            stringBuilder += "⇧"
        }
        if capsLock {
            stringBuilder += "⇪"
        }
        if let characters {
            stringBuilder += characters.uppercased()
        }

        return "\(stringBuilder)"
    }
}
