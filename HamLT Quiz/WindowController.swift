//
//  WindowController.swift
//  Radijo mėgėjas
//
//  Created by planasb on 26/02/2018.
//  Copyright © 2018 Kęstutis Rutkauskas. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    override func awakeFromNib() {
        self.window?.delegate = self
    }
    
    func windowWillClose(_ notification: Notification) {
        NSApplication.shared.terminate(self)
    }

}
