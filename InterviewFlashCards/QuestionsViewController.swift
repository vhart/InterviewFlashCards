
//  QuestionsViewController.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 10/14/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit

enum SectionQuestionType {
    case iOSTechnical
    case DataStructures
    case Algorithms

}

class QuestionsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!

    // MARK: Private Properties
    private(set) var flashCards = [IFCFlashCard]()
    private var currentIndex = 0
    private var section: SectionQuestionType = .DataStructures

    // MARK: Public Properties
    var sectionName = ""
    var dataGenerator: Networking? = QueryManager()

    // MARK: Actions

    @IBAction private func prevButtonTapped(sender: UIButton) {
        currentIndex = currentIndex - 1 < 0 ? (currentIndex - 1 + flashCards.count) : 0
        prepareFlashCard(currentIndex)
    }

    @IBAction private func nextButtonTapped(sender: UIButton) {
        currentIndex = (currentIndex + 1) % (flashCards.count)
        prepareFlashCard(currentIndex)
    }

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityLabels()
        setupNavBar()
        fetchData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.destinationViewController is IFCAnswerViewController) {
            (segue.destinationViewController as! IFCAnswerViewController).flashCard = flashCards[currentIndex]
        }
    }

    //MARK: Public functions

    func set(sectionType value: SectionQuestionType) {
            section = value
    }

    func dismiss() {
        navigationController?.popViewControllerAnimated(true)!
    }

    //MARK: Private functions

    private func fetchData() {
        dataGenerator?.getData(for: requestType()) { [weak self] json in
            self?.flashCards = IFCFlashCard.flashCardsFromDictionaries(json)
            self?.prepareFlashCard(0)
        }
    }

    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: #selector(QuestionsViewController.dismiss))
        navigationItem.title = sectionName
    }

    private func requestType() -> RequestType {
        switch (section) {
        case .iOSTechnical:
            return .iOS
        case .DataStructures:
            return .DataStructures
        case .Algorithms:
            return .Algorithms
        }
    }

    private func prepareFlashCard(index: Int) {
        if let next = nextButton, answer = answerButton {
            next.hidden = true
            answer.hidden = true
        }
        let nextCard = flashCards[index]
        nextCard.prepareFlashCardWithCompletion() { [weak self] in
            self?.prepareUIwithCard(nextCard)
        }
    }

    private func prepareUIwithCard(flashCard: IFCFlashCard) {
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

    private func setAccessibilityLabels() {
        answerButton.accessibilityLabel = "answer button"
        nextButton.accessibilityLabel = "next button"
        prevButton.accessibilityLabel = "previous button"
        questionLabel.accessibilityLabel = "question label"
        questionImageView.accessibilityLabel = "question image view"
    }
}
