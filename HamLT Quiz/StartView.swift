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
            questionViewController = QuestionViewController.init(nibName: NSNib.Name(rawValue:"QuestionViewController"), bundle: Bundle.main, category: Category.B_CATEGORY)
            if let questionViewController = questionViewController {
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
        if let mainViewController = mainViewController {
            removeAllSubviews()
            mainViewController.removeAllSubviews()
            questionViewController = QuestionViewController.init(nibName: NSNib.Name(rawValue:"QuestionViewController"), bundle: Bundle.main, category: Category.A_CATEGORY)
            if let questionViewController = questionViewController {
                mainViewController.view.addSubview(questionViewController.view)
                questionViewController.mainViewController = mainViewController
            }
        }
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
    
    @IBAction func santrumposPress(_ sender: Any) {
        documentController = DocumentController.init(windowNibName: NSNib.Name(rawValue:"DocumentController"))
        if let documentController = documentController {
            let url = Bundle.main.url(forResource: "santrupos", withExtension: "pdf")
            if let url = url {
                let pdf = PDFDocument(url: url)
                documentController.showWindow(self)
                documentController.window?.title = "Santrupos"
                documentController.pdfView.document  = pdf
            }
        }
    }
    
    @IBAction func AtstojamosiosPress(_ sender: Any) {
        documentController = DocumentController.init(windowNibName: NSNib.Name(rawValue:"DocumentController"))
        if let documentController = documentController {
            let url = Bundle.main.url(forResource: "atstojamosios", withExtension: "pdf")
            if let url = url {
                let pdf = PDFDocument(url: url)
                documentController.showWindow(self)
                documentController.window?.title = "Atstojamosios"
                documentController.pdfView.document  = pdf
            }
        }
    }
    
    
}
