//
//  QuestionViewController.swift
//  Radijo mėgėjas
//
//  Created by planasb on 23/02/2018.
//  Copyright © 2018 Kęstutis Rutkauskas. All rights reserved.
//

import Cocoa

enum Category {
    case A_CATEGORY
    case B_CATEGORY
}

enum Answer : Int {
    case answer1 = 0
    case answer2 = 1
    case answer3 = 2
}

class QuestionViewController: NSViewController {
    
    @IBOutlet weak var question: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var answer1: ClickableTextField!
    @IBOutlet weak var answer2: ClickableTextField!
    @IBOutlet weak var answer3: ClickableTextField!
    @IBOutlet weak var nextQuestion: NSButton!
    var mainViewController: MainViewController?
    var quizParser: QuizParser?
    var resultViewController: ResultViewController?
    var questionNumber: Int?
    var startView: StartView?
    var answerNumber: Int? = 0
    var answerClicked: Bool = false
    let bCategeryMaxQuestion: Int = 295
    var numberQuestions: Int = 0
    let quizQuestionsCount: Int = 30
    var correctQuestionsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadQuestion(category: Category) {
        if let quizParser = quizParser {
            switch category {
            case .A_CATEGORY:
                print("a category")
            case .B_CATEGORY:
                questionNumber = Int(arc4random_uniform(UInt32(bCategeryMaxQuestion + 1)))
                answerClicked = false
                if let questionNumber = questionNumber {
                    if questionNumber >= 0 && questionNumber <= bCategeryMaxQuestion {
                        if (numberQuestions < quizQuestionsCount) {
                            self.updateView(q: quizParser.questions[questionNumber])
                            numberQuestions = numberQuestions + 1
                        } else {
                            resultViewController = ResultViewController.init(nibName: NSNib.Name(rawValue: "ResultViewController"), bundle: Bundle.main, numberCorrrect: correctQuestionsCount, numberQuestions: numberQuestions)
                            if let resultViewController = resultViewController {
                                 NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue:"answerClick"), object: nil)
                                resultViewController.mainViewController = mainViewController
                                self.removeAllSubviews()
                                self.view.addSubview(resultViewController.view)
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        if (question != nil) {
            quizParser = QuizParser()
            loadQuestion(category: .B_CATEGORY)
            NotificationCenter.default.addObserver(self, selector: #selector(answerClick), name: Notification.Name(rawValue:"answerClick"), object: nil)
        }
    }
    
    @objc func answerClick(notification: NSNotification) {
        if answerClicked == false {
            let field : ClickableTextField? = notification.object as? ClickableTextField
            if let field = field {
                answerClicked = true
                switch field.tag {
                case Answer.answer1.rawValue:
                    if field.tag == answerNumber {
                        answer1.backgroundColor = NSColor.systemGreen
                        correctQuestionsCount = correctQuestionsCount + 1
                    } else {
                        answer1.backgroundColor = NSColor.systemRed
                        switch answerNumber! {
                        case Answer.answer2.rawValue:
                            answer2.backgroundColor = NSColor.systemGreen
                        case Answer.answer3.rawValue:
                            answer3.backgroundColor = NSColor.systemGreen
                        default:
                            break
                        }
                    }
                case Answer.answer2.rawValue:
                    if field.tag == answerNumber {
                        answer2.backgroundColor = NSColor.systemGreen
                        correctQuestionsCount = correctQuestionsCount + 1
                    } else {
                        answer2.backgroundColor = NSColor.systemRed
                        switch answerNumber! {
                        case Answer.answer1.rawValue:
                            answer1.backgroundColor = NSColor.systemGreen
                        case Answer.answer3.rawValue:
                            answer3.backgroundColor = NSColor.systemGreen
                        default:
                            break
                        }
                    }
                case Answer.answer3.rawValue:
                    if field.tag == answerNumber {
                        answer3.backgroundColor = NSColor.systemGreen
                        correctQuestionsCount = correctQuestionsCount + 1
                    } else {
                        answer3.backgroundColor = NSColor.systemRed
                        switch answerNumber! {
                        case Answer.answer1.rawValue:
                            answer1.backgroundColor = NSColor.systemGreen
                        case Answer.answer2.rawValue:
                            answer2.backgroundColor = NSColor.systemGreen
                        default:
                            break
                        }
                    }
                default:
                    break
                }
            }
        }
    }
    
    func updateView(q: Question) {
        if let image = q.imageName {
            
            let gifImage = Bundle.main.image(forResource: NSImage.Name(rawValue:(image as NSString).lastPathComponent))
            if let gifImage = gifImage {
                imageView.image = gifImage
                imageView.isHidden = false
            }
        } else {
            imageView.isHidden = true
        }
        answer1.backgroundColor = NSColor.white
        answer2.backgroundColor = NSColor.white
        answer3.backgroundColor = NSColor.white
        answerNumber = q.answer
        question.stringValue = q.question
        answer1.stringValue = q.answers[0]
        answer2.stringValue = q.answers[1]
        answer3.stringValue = q.answers[2]
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    @IBAction func endPress(_ sender: Any) {
        startView = StartView.init(nibName: NSNib.Name(rawValue:"StartView"), bundle: Bundle.main)
        if let startView = startView {
            self.removeAllSubviews()
            self.view.addSubview(startView.view)
            
            if let mainViewController = mainViewController {
                startView.mainViewController = mainViewController
                NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue:"answerClick"), object: nil)
            }
        }
    }
    
    @IBAction func nextButtonPress(_ sender: Any) {
        loadQuestion(category: Category.B_CATEGORY)
    }
    
    func removeAllSubviews() {
        for v in self.view.subviews {
            v.removeFromSuperview()
        }
    }
}
