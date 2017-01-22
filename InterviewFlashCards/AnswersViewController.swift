
import UIKit

class AnswersViewController: UITableViewController {

    var flashCard = IFCFlashCard()

    //MARK: IBOutlets
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!

    //MARK: Properties
    fileprivate var tempAnswerImageView: UIImageView?
    fileprivate var tempAnswerLabel: UILabel?
    fileprivate var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    //MARK: Setup
    fileprivate func setupUI() {
        questionNumberLabel.text = ""
        setupTempImageViewBounds()
        if (flashCard.answerImages != nil) {
            answerImageView.isUserInteractionEnabled = true
            answerImageView.image = flashCard.answerImages.first
            answerLabel.text = ""
        } else {
            answerLabel.text = flashCard.answer
        }
    }

    fileprivate func setupTempImageViewBounds() {
        tempAnswerImageView = UIImageView(frame: answerImageView.frame)
    }

    fileprivate func updateQuestionNumberLabel() {
        questionNumberLabel.text = "\(index + 1)/\(flashCard.answerImages.count)"
    }

    //MARK: Frame Maker
    fileprivate func fullscreenFrame() -> CGRect {
        return CGRect(x: CGFloat(view.bounds.origin.x + 10), y: CGFloat(view.bounds.origin.y + 10), width: CGFloat(view.bounds.size.width - 20), height: CGFloat(view.bounds.size.height - 10))
    }
    //MARK: Navigation
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
