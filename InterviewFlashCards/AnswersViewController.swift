
import UIKit

class AnswersViewController: UITableViewController {

    var flashCard = IFCFlashCard()

    //MARK: IBOutlets
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var paginationLabel: UILabel!

    //MARK: Properties
    var tempAnswerImageView: UIImageView?
    var tempAnswerLabel: UILabel?
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    //MARK: Setup
    func setupUI() {
        paginationLabel.text = ""
        setupTempImageViewBounds()
        if (flashCard.answerImages != nil) {
            index = 0
            answerImageView.isUserInteractionEnabled = true
            answerImageView.image = flashCard.answerImages[0]
            answerLabel.text = ""
        } else {
            answerLabel.text = flashCard.answer
        }
    }

    func setupTempImageViewBounds() {
        tempAnswerImageView = UIImageView(frame: answerImageView.frame)
    }

    func showPaginationLabel() {
        paginationLabel.text = "\(index + 1)/\(flashCard.answerImages.count)"
    }

    //MARK: Frame Maker
    func fullscreenFrame() -> CGRect {
        return CGRect(x: CGFloat(view.bounds.origin.x + 10), y: CGFloat(view.bounds.origin.y + 10), width: CGFloat(view.bounds.size.width - 20), height: CGFloat(view.bounds.size.height - 10))
    }
    //MARK: Navigation
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
