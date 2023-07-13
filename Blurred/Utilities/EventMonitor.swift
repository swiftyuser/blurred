//
//  EventMonitor.swift
//  Dimmer Bar
//
//  Created by phucld on 1/8/20.
//  Copyright © 2020 Dwarves Foundation. All rights reserved.
//

import Cocoa

public class EventMonitor {

    // MARK: - Variables
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> Void

    // MARK: - Init
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
        self.mask = mask
        self.handler = handler
    }

    // MARK: - Deinit
    deinit {
        stop()
    }

    // MARK: - Public
    public func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }

    public func stop() {
        guard let monitor else { return }
        NSEvent.removeMonitor(monitor)
        self.monitor = nil
    }
}
