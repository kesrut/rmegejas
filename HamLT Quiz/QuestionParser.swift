//
//  Question.swift
//  Radijo mėgėjas
//
//  Created by planasb on 23/02/2018.
//  Copyright © 2018 Kęstutis Rutkauskas. All rights reserved.
//

import Cocoa

class Question {
    let question: String
    let answers: [String]
    let answer: Int
    var imageName: String?
    
    init(question: String, answers: [String], answer: Int) {
        self.question = question
        self.answers = answers
        self.answer = answer
    }
}

class QuizParser: NSObject, XMLParserDelegate   {
    var path: URL?
    let fileName: String? = "quiz"
    var data: Data?
    var parser: XMLParser?
    var insideQuestionItem: Bool = false
    var currentlyParsingItem: String = ""
    var question: String
    var choise: String
    var answer: String
    var choises: [String]
    var questions: [Question]
    var imageName: String?
    var isImage: Bool = false
    
    override init() {
        question = ""
        choise = ""
        choises = []
        questions = []
        answer = "0"
        imageName = nil
        isImage = false
        super.init()
        path = Bundle.main.url(forResource: fileName, withExtension: "xml")
        if let path = path {
            if let data = try? Data(contentsOf: path) {
                parser = XMLParser.init(data: data)
                if let parser = parser {
                    parser.delegate = self
                    parser.parse()
                }
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "question" {
            insideQuestionItem = true
        }
        if insideQuestionItem == true {
            switch elementName {
            case "text":
                question = ""
                currentlyParsingItem = "text"
            case "choice":
                choise = ""
                currentlyParsingItem = "choice"
            case "answer":
                answer = ""
                currentlyParsingItem = "answer"
            case "image":
                isImage = true
                imageName = ""
                currentlyParsingItem = "image"
            default:
                break
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if insideQuestionItem {
            switch currentlyParsingItem {
            case "text":
                question += string
            case "choice":
                choise += string
            case "answer":
                answer += string
            case "image":
                imageName! += string
            default:
                break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if insideQuestionItem {
            switch elementName {
            case "text":
                currentlyParsingItem = ""
            case "choice":
                choises.append(choise)
                currentlyParsingItem = ""
            case "answer":
                currentlyParsingItem = ""
            case "image":
                currentlyParsingItem = ""
                isImage = true
            default:
                break
            }
        }
        if elementName == "question" {
            if let answerNumber = NumberFormatter().number(from: answer) {
                let q = Question(question: question, answers: choises, answer: answerNumber.intValue)
                choises = []
                questions.append(q) ;
                if isImage == true {
                    q.imageName = imageName
                    isImage = false
                }
                else {
                    q.imageName = nil
                }
            }
        }
    }
}
