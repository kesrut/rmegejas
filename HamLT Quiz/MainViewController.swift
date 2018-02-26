//
//  MainViewController.swift
//  HamLT Quiz
//
//  Created by planasb on 21/02/2018.
//  Copyright © 2018 Kęstutis Rutkauskas. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var mainView: NSView!
    var startView: StartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
       
    }
    
    override func awakeFromNib() {
        if mainView != nil {
            self.removeAllSubviews()
        }
    }
    
    override func viewWillAppear() {
        
    }
    
    override func viewDidAppear() {
        startView = StartView.init(nibName: NSNib.Name(rawValue:"StartView"), bundle: Bundle.main)
        if let startView = startView {
            self.removeAllSubviews()
            self.view.addSubview(startView.view)
            startView.view.needsDisplay = true
            startView.view.needsLayout = true
            startView.mainViewController = self
            
            
        }
    }

    func removeAllSubviews() {
        for v in self.mainView.subviews {
            v.removeFromSuperview()
        }
    }
    
}
