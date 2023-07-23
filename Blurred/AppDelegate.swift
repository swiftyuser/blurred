//
//  AppDelegate.swift
//  Dimmer Bar
//
//  Created by phucld on 12/17/19.
//  Copyright © 2019 Dwarves Foundation. All rights reserved.
//

import Cocoa
import SwiftUI
import HotKey

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Variable(s)
    let statusBarController = StatusBarController()

    var hotKey: HotKey? {
        didSet {
            guard let hotKey = hotKey else { return }
            hotKey.keyDownHandler = {
                DimManager.shared.setting.isEnabled.toggle()
            }
        }
    }

    let eventMonitor = EventMonitor(mask: .leftMouseUp) { _ in
        // Hanlde this without delay
        DimManager.shared.dim(runningApplication: NSWorkspace.shared.frontmostApplication,
                              withDelay: false)
    }

    // MARK: - Life cycle
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        hideDockIcon()
        setupAutoStartAtLogin()
        openPrefWindowIfNeeded()
        setupHotKey()
        eventMonitor.start()
    }

    func applicationDidChangeScreenParameters(_ notification: Notification) {
        DimManager.shared.dim(runningApplication: NSWorkspace.shared.frontmostApplication)
    }
}

// MARK: - Private
private extension AppDelegate {

    private func setupHotKey() {
        guard let globalKey = UserDefaults.globalKey else { return }
        hotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: globalKey.keyCode,
                                           carbonModifiers: globalKey.carbonFlags))
    }

    private func openPrefWindowIfNeeded() {
        guard UserDefaults.isOpenPrefWhenOpenApp else { return }
        PreferencesWindowController.shared.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    private func setupAutoStartAtLogin() {
        let isAutoStart = UserDefaults.isStartWhenLogin
        Util.setUpAutoStart(isAutoStart: isAutoStart)
    }

    private func hideDockIcon() {
        NSApp.setActivationPolicy(.accessory)
    }
}
