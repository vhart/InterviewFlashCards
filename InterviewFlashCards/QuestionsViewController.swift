import UIKit
import BrightFutures

enum SectionQuestionType {
    case iOSTechnical
    case dataStructures
    case algorithms

}

class QuestionsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!

    // MARK: Private Properties
    fileprivate(set) var flashcards = [Flashcard]()
    fileprivate var currentIndex = 0
    fileprivate var section: SectionQuestionType = .dataStructures
    let segueIdentifier = "answerSegueIdentifier"

    // MARK: Public Properties
    var sectionName = ""
    var dataGenerator: DataGenerator? = JsonFileReader()

    // MARK: Actions

    @IBAction fileprivate func prevButtonTapped(_ sender: UIButton) {
        currentIndex = currentIndex - 1 < 0 ? (currentIndex - 1 + flashcards.count) : currentIndex - 1
        prepareFlashcard(currentIndex)
    }

    @IBAction fileprivate func nextButtonTapped(_ sender: UIButton) {
        currentIndex = (currentIndex + 1) % (flashcards.count)
        prepareFlashcard(currentIndex)
    }

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityLabels()
        setupNavBar()
        fetchData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some(segueIdentifier):
            guard let navController = segue.destination as? UINavigationController,
                let answerViewController = navController.topViewController as? AnswersViewController else { return }
                answerViewController.flashcard = flashcards[currentIndex]
        default: break
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
        dataGenerator?.getData(for: requestType()) { [weak self] flashcards in
            self?.flashcards = flashcards
            self?.prepareFlashcard(0)
        }
    }

    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(QuestionsViewController.dismissController))
        navigationItem.title = sectionName
    }

    private func requestType() -> FlashcardType {
        switch (section) {
        case .iOSTechnical:
            return .iOS
        case .dataStructures:
            return .dataStructures
        case .algorithms:
            return .algorithms
        }
    }

    fileprivate func prepareFlashcard(_ index: Int) {
        guard flashcards.count > index else { return }
        if let next = nextButton, let answer = answerButton {
            next.isHidden = true
            answer.isHidden = true
        }
        let nextCard = flashcards[index]
        nextCard.prepareQuestionImagesIfNeeded().onSuccess() { [weak self] in
            self?.prepareView(with: nextCard)
        }
    }

    fileprivate func prepareView(with flashCard: Flashcard) {
        questionLabel.text = flashCard.question
        questionImageView.image = flashCard.questionImage
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
