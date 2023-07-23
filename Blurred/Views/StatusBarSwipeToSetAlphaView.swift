//
//  MySwipeStatusBar.swift
//  Blurred
//
//  Created by Trung Phan on 5/19/20.
//  Copyright © 2020 Dwarves Foundation. All rights reserved.
//

import Cocoa

class StatusBarSwipeToSetAlphaView: NSView {

    override func wantsScrollEventsForSwipeTracking(on axis: NSEvent.GestureAxis) -> Bool {
        axis == .vertical
    }

    override func scrollWheel(with event: NSEvent) {
        let setting = DimManager.shared.setting

        if event.deltaY > 0, setting.alpha > 10.0 {
            setting.alpha -= 1.0
        }
        else if event.deltaY < 0, setting.alpha < 100 {
            setting.alpha += 1
        }
    }
}
