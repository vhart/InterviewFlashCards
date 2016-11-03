
//  QuestionsViewController.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 10/14/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit
import Firebase

enum SectionQuestionType: String {
    case iOSTechnical
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
        queryManager.getData(for: type()) { [weak self] json in
            self?.flashCards = IFCFlashCard.flashCardsFromDictionaries(json)
            self?.prepareFlashCard(0)
        }
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: #selector(QuestionsViewController.dismiss))
        navigationItem.title = sectionName
    }
    
    func requestType() -> RequestType {
        switch (section) {
        case .iOSTechnical:
            return .RequestTypeiOS
        case .DataStructures:
            return .RequestTypeDataStructures
        case .Algorithms:
            return .RequestTypeAlgorithms
        }
    }
    
    func prepareFlashCard(index: Int) {
        if let next = nextButton, answer = answerButton {
            next.hidden = true
            answer.hidden = true
        }
        let nextCard = flashCards[index]
        nextCard.prepareFlashCardWithCompletion({ [weak self] Void in
            self?.prepareUIwithCard(nextCard)
        })
    }
    
    func prepareUIwithCard(flashCard: IFCFlashCard) {
        if let question = flashCard.question {
            questionLabel.text = question
        }
        questionImageView.image = nil
        if flashCard.questionImages != nil && flashCard.questionImages.count > 0 {
            let questionImage = (flashCard.questionImages[0] as! UIImage)
            questionImageView.image! = questionImage
        }
        nextButton.hidden = false
        answerButton.hidden = false
    }
    
    @IBAction func prevButtonTapped(sender: UIButton) {
        currentIndex = currentIndex - 1 < 0 ? (currentIndex - 1 + flashCards.count) : 0
        prepareFlashCard(currentIndex)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        currentIndex = (currentIndex + 1) % (flashCards.count)
        prepareFlashCard(currentIndex)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.destinationViewController is IFCAnswerViewController) {
            (segue.destinationViewController as! IFCAnswerViewController).flashCard = flashCards[currentIndex]
        }
    }
    
    func setSectionTypeForViewController(vc: QuestionsViewController, withValue value: Int) {
        guard let value = SectionQuestionType(rawValue: "\(value)") else { fatalError() }
        vc.section = value
    }
    
    func dismiss() {
        navigationController?.popViewControllerAnimated(true)!
    }
}
