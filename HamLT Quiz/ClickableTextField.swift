//
//  ClickableTextField.swift
//  Radijo mėgėjas
//
//  Created by planasb on 25/02/2018.
//  Copyright © 2018 Kęstutis Rutkauskas. All rights reserved.
//

import Cocoa

class ClickableTextField: NSTextField {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func mouseDown(with event: NSEvent) {
       // super.mouseDown(with: event)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "answerClick"), object: self)
       
    }
    
}
