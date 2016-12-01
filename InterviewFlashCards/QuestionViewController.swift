
import UIKit

enum SectionQuestionType: Int {
    case iOSTechnical
    case DataStructures
    case Algorithms
    
}

class QuestionViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    
    // MARK: Private Properties
    private let queryManager = QueryManager()
    private var flashCards = [IFCFlashCard]()
    private var currentIndex = 0
    private var section: SectionQuestionType = .DataStructures
    
    // MARK: Public Properties
    var sectionName = ""
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        fetchData()
    }
    
    // MARK: Actions
    private func fetchData() {
        let type = requestType
        queryManager.getData(for: type()) { [weak self] json in
            self?.flashCards = IFCFlashCard.flashCardsFromDictionaries(json)
            self?.prepareFlashCard(0)
        }
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: #selector(QuestionViewController.dismiss))
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
        nextCard.prepareFlashCardWithCompletion({ [weak self] Void in
            self?.prepareUIwithCard(nextCard)
        })
    }
    
    private func prepareUIwithCard(flashCard: IFCFlashCard) {
        if let question = flashCard.question {
            questionLabel.text = question
        }
        questionImageView.image = nil
        if flashCard.questionImages != nil && flashCard.questionImages.count > 0 {
            let questionImage = (flashCard.questionImages[0] as! UIImage)
            questionImageView.image = questionImage
        }
        nextButton.hidden = false
        answerButton.hidden = false
    }
    
    @IBAction private func prevButtonTapped(sender: UIButton) {
        currentIndex = currentIndex - 1 < 0 ? (currentIndex - 1 + flashCards.count) : 0
        prepareFlashCard(currentIndex)
    }
    
    @IBAction private func nextButtonTapped(sender: UIButton) {
        currentIndex = (currentIndex + 1) % (flashCards.count)
        prepareFlashCard(currentIndex)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.destinationViewController is AnswerViewController) {
            (segue.destinationViewController as! AnswerViewController).flashCard = flashCards[currentIndex]
        }
    }
    
    func setSectionTypeForViewController(vc: QuestionViewController, withValue value: Int) {
        if let sectionValue = SectionQuestionType(rawValue: value) {
            vc.section = sectionValue
        }
    }
    
    func dismiss() {
        navigationController?.popViewControllerAnimated(true)!
    }
}
