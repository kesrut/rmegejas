//
//  ResultViewController.swift
//  Radijo mėgėjas
//
//  Created by planasb on 25/02/2018.
//  Copyright © 2018 Kęstutis Rutkauskas. All rights reserved.
//

import Cocoa

class ResultViewController: NSViewController {
    
    @IBOutlet weak var result: NSTextField!
    var startView: StartView?
    var mainViewController: MainViewController?
    var numberCorrect: Int?
    var numberQuestion: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?, numberCorrrect correctInt: Int, numberQuestions questionsCount: Int) {
        numberCorrect = correctInt
        numberQuestion = questionsCount
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        if let numberCorrect = numberCorrect, let numberQuestion = numberQuestion {
            let resultString = String(format: "Rezultatas: %d/%d", arguments: [numberCorrect, numberQuestion])
            result.stringValue = resultString
        }
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        startView = StartView.init(nibName: NSNib.Name(rawValue:"StartView"), bundle: Bundle.main)
        if let startView = startView {
            self.removeAllSubviews()
            self.view.addSubview(startView.view)
            
            if let mainViewController = mainViewController {
                startView.mainViewController = mainViewController
            }
        }
    }
    
    func removeAllSubviews() {
        for v in self.view.subviews {
            v.removeFromSuperview()
        }
    }
}
