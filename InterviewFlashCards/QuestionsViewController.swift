
import UIKit

enum SectionQuestionType {
    case iOSTechnical
    case dataStructures
    case algorithms

}

class QuestionsViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!

    //MARK: Private Properties
    fileprivate(set) var flashCards = [IFCFlashCard]()
    fileprivate var currentIndex = 0
    fileprivate var section: SectionQuestionType = .dataStructures
    let segueIdentifier = "answerSegueIdentifier"

    //MARK: Public Properties
    var sectionName = ""
    var dataGenerator: Networking? = QueryManager()

    //MARK: Actions
    @IBAction fileprivate func prevButtonTapped(_ sender: UIButton) {
        currentIndex = currentIndex - 1 < 0 ? (currentIndex - 1 + flashCards.count) : 0
        prepareFlashCard(currentIndex)
    }

    @IBAction fileprivate func nextButtonTapped(_ sender: UIButton) {
        currentIndex = (currentIndex + 1) % (flashCards.count)
        prepareFlashCard(currentIndex)
    }

    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityLabels()
        setupNavBar()
        fetchData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == segueIdentifier {
            (segue.destination as! AnswersViewController).flashCard = flashCards[currentIndex]
        }
    }

    //MARK: Public Functions
    func set(sectionType value: SectionQuestionType) {
        section = value
    }

    func dismissController() {
        _ = navigationController?.popViewController(animated: true)
    }

    //MARK: Private Functions
    private func fetchData() {
        dataGenerator?.getData(for: requestType()) { [weak self] json in
            self?.flashCards = IFCFlashCard.flashCards(fromDictionaries: json)
            self?.prepareFlashCard(0)
        }
    }

    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(QuestionsViewController.dismissController))
        navigationItem.title = sectionName
    }

    private func requestType() -> RequestType {
        switch (section) {
        case .iOSTechnical:
            return .iOS
        case .dataStructures:
            return .dataStructures
        case .algorithms:
            return .algorithms
        }
    }

    fileprivate func prepareFlashCard(_ index: Int) {
        if let next = nextButton, let answer = answerButton {
            next.isHidden = true
            answer.isHidden = true
        }
        let nextCard = flashCards[index]
        nextCard.prepare() { [weak self] in
            self?.prepareUIwithCard(nextCard)
        }
    }

    fileprivate func prepareUIwithCard(_ flashCard: IFCFlashCard) {
        questionLabel.text = flashCard.question
        questionImageView.image = nil
        if flashCard.questionImages != nil && flashCard.questionImages.count > 0 {
            let questionImage = flashCard.questionImages[0]
            questionImageView.image = questionImage
        }
        nextButton.isHidden = false
        answerButton.isHidden = false
    }

    fileprivate func setAccessibilityLabels() {
        answerButton.accessibilityLabel = "answer button"
        nextButton.accessibilityLabel = "next button"
        prevButton.accessibilityLabel = "previous button"
        questionLabel.accessibilityLabel = "question label"
        questionImageView.accessibilityLabel = "question image view"
    }
}
