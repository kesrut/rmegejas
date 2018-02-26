//
//  StartView.swift
//  HamLT Quiz
//
//  Created by planasb on 21/02/2018.
//  Copyright © 2018 Kęstutis Rutkauskas. All rights reserved.
//

import Cocoa
import Quartz

class StartView: NSViewController {

    var mainViewController: MainViewController?
    var documentController: DocumentController?
    var questionViewController: QuestionViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    @IBAction func bLevelTestPress(_ sender: Any) {
        
       
        if let mainViewController = mainViewController {
            removeAllSubviews()
            mainViewController.removeAllSubviews()
            questionViewController = QuestionViewController.init(nibName: NSNib.Name(rawValue:"QuestionViewController"), bundle: Bundle.main)
            if let questionViewController = questionViewController {
                mainViewController.view.needsLayout = true
                mainViewController.view.needsDisplay = true
                mainViewController.view.addSubview(questionViewController.view)
                questionViewController.mainViewController = mainViewController
            }
        }

    }
    
    func removeAllSubviews() {
        for v in self.view.subviews {
            v.removeFromSuperview()
        }
    }
    
    @IBAction func aLevelTestPress(_ sender: Any) {
        
    }
    @IBAction func teisesAktaiPress(_ sender: Any) {
        documentController = DocumentController.init(windowNibName: NSNib.Name(rawValue:"DocumentController"))
        if let documentController = documentController {
            let url = Bundle.main.url(forResource: "istatymas", withExtension: "pdf")
            if let url = url {
                let pdf = PDFDocument(url: url)
                documentController.showWindow(self)
                documentController.window?.title = "Teisės aktai"
                documentController.pdfView.document  = pdf
            }
        }
    }
    
   /*
    @IBAction func teisesAktaiPress(_ sender: NSButton) {
       
        print(mainViewController)
        if let mainViewController = mainViewController {
            print("hello world")
            //mainViewController.removeAllSubviews()
            documentController = DocumentController.init(nibName: NSNib.Name(rawValue:"DocumentController"), bundle:Bundle.main)
            if let documentController = documentController {
                print("hello world")
                mainViewController.view.addSubview(documentController.view)
                let url =  Bundle.main.url(forResource: "istatymas.pdf", withExtension: "pdf")
                if let url = url {
                    print("hello world")
                }
            }
        }
    }*/
    
    
}
