
//  QuestionsViewController.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 10/14/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit
import Firebase

enum SectionQuestionType: Int {
    case iOSTechnical = 0
    case DataStructures
    case Algorithms
}

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    
    let queryManager = QueryManager()
    var flashCards = [IFCFlashCard]()
    var sectionName = ""
    var currentIndex = 0
    var section: SectionQuestionType = .iOSTechnical
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        fetchData()
    }
    
    // MARK: Actions
    func fetchData() {
        let type = requestType
        weak var weakSelf = self
        queryManager.getDataForRequest(type()) { (json) in
            weakSelf?.flashCards = IFCFlashCard.flashCardsFromDictionaries(json)
            weakSelf?.prepareFlashCard(0)
        }
    }
    
    func setupNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: #selector(QuestionsViewController.dismiss))
        navigationItem.title = sectionName
    }
    
    func requestType() -> RequestType {
        guard let value = SectionQuestionType(rawValue: 0) else { return .Error }
        switch value {
        case .iOSTechnical:
            return .iOS
        case .DataStructures:
            return .DataStructures
        case .Algorithms:
            return .Algorithms
        }
    }
    
    func prepareFlashCard(index: Int) {
        if let next = nextButton, answer = answerButton {
            next.hidden = true
            answer.hidden = true
        }
        
        let nextCard = flashCards[index]
        weak var weakSelf = self
        nextCard.prepareFlashCardWithCompletion({() -> Void in
            weakSelf!.prepareUIwithCard(nextCard)
        })
    }
    
    func prepareUIwithCard(flashCard: IFCFlashCard) {
        if let question = flashCard.question {
            questionLabel.text = question
        }
        self.questionImageView.image = nil
        
        if flashCard.questionImages != nil && flashCard.questionImages.count > 0 {
            let questionImage = (flashCard.questionImages[0] as! UIImage)
            self.questionImageView.image! = questionImage
        }
        self.nextButton.hidden = false
        self.answerButton.hidden = false
    }
    
    @IBAction func prevButtonTapped(sender: UIButton) {
        self.currentIndex = self.currentIndex - 1 < 0 ? (self.currentIndex - 1 + self.flashCards.count) : 0
        self.prepareFlashCard(self.currentIndex)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        self.currentIndex = (self.currentIndex + 1) % (self.flashCards.count)
        self.prepareFlashCard(self.currentIndex)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.destinationViewController is IFCAnswerViewController) {
            (segue.destinationViewController as! IFCAnswerViewController).flashCard = self.flashCards[self.currentIndex]
        }
    }
    
    func dismiss() {
        self.navigationController?.popViewControllerAnimated(true)!
    }
}