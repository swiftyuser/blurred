//
//  AppDelegate.swift
//  dimmerBarLauncher
//
//  Created by phucld on 1/7/20.
//  Copyright © 2020 Dwarves Foundation. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainAppIdentifier = "foundation.dwarves.blurred"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty

        switch isRunning {
        case false:
            launchApp(with: mainAppIdentifier)
        case true:
            terminate()
        }
    }
}

// MARK: - Actions
private extension AppDelegate {

    @objc
    private func terminate() {
        NSApp.terminate(nil)
    }
}

// MARK: - Private
private extension AppDelegate {

    private func launchApp(with mainAppIdentifier: String) {
        DistributedNotificationCenter.default().addObserver(self,
                                                            selector: #selector(terminate),
                                                            name: Notification.Name("killLauncher"),
                                                            object: mainAppIdentifier)

        let path = Bundle.main.bundlePath as NSString
        var components = path.pathComponents
        components.removeLast(3)
        components.append("MacOS")
        let appName = "Blurred"
        // Main app name
        components.append(appName)
        let newPath = NSString.path(withComponents: components)
        NSWorkspace.shared.launchApplication(newPath)
    }
}
