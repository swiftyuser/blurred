//
//  StatusBarController.swift
//  Dimmer Bar
//
//  Created by Trung Phan on 1/7/20.
//  Copyright © 2020 Dwarves Foundation. All rights reserved.
//

import Combine
import SwiftUI

class StatusBarController {

    // MARK: - Variables
    private let menuStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let slider = NSSlider()
    private var cancellableSet: Set<AnyCancellable> = []

    // MARK: - Init
    init() {
        setupView()
        setupSlider()
    }
}

// MARK: - Actions
private extension StatusBarController {

    @objc
    private func sliderChanged() {
        DimManager.shared.setting.alpha = slider.doubleValue
    }
    @objc
    private func toggleEnable() {
        DimManager.shared.setting.isEnabled.toggle()
    }

    @objc
    private func openPreferences() {
        PreferencesWindowController.shared.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}

// MARK: - Private
private extension StatusBarController {

    private func setupView() {
        if let button = menuStatusItem.button {
            button.image = #imageLiteral(resourceName: "ico_menu")

            let swipeView = StatusBarSwipeToSetAlphaView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: button.frame.size))
            button.addSubview(swipeView)
        }
        menuStatusItem.menu = getContextMenu()
    }

    private func setupSlider() {
        slider.minValue = 10.0
        slider.maxValue = 100.0
        slider.doubleValue = DimManager.shared.setting.alpha

        DimManager.shared.setting.$alpha
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \.doubleValue, on: self.slider)
            .store(in: &cancellableSet)

        DimManager.shared.setting.$isEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: self.slider)
            .store(in: &cancellableSet)

        slider.target = self
        slider.action = #selector(sliderChanged)
    }

    private func getContextMenu() -> NSMenu {
        let menu = NSMenu()
        let sliderMenuItem = NSMenuItem()
        let titleEnable = DimManager.shared.setting.isEnabled ? "Disable".localized : "Enable".localized

        let enableButton = NSMenuItem(title: titleEnable, action: #selector(toggleEnable), keyEquivalent: "E")
        enableButton.target = self

        DimManager.shared.setting.$isEnabled
            .receive(on: DispatchQueue.main)
            .sink {[weak enableButton] isEnabled in
                let title = isEnabled ? "Disable".localized : "Enable".localized
                enableButton?.title = title
        }
        .store(in: &cancellableSet)

        let view = NSView()
        view.setFrameSize(NSSize(width: 100, height: 22))
        view.autoresizingMask = .width
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: slider, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: slider, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: slider, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: slider, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
        ])

        sliderMenuItem.view = view
        menu.addItem(withTitle: "Slide to set Dim level".localized, action: nil, keyEquivalent: "")
        menu.addItem(sliderMenuItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(enableButton)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Preferences...".localized, action: #selector(openPreferences), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit".localized, action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        menu.item(withTitle: "Preferences...".localized)?.target = self

        return menu
    }
}
