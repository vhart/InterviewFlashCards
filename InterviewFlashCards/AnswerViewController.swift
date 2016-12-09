
import UIKit

class AnswerViewController: UITableViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var paginationLabel: UILabel!
    
    // MARK: Properties
    var flashCard = IFCFlashCard()
    var tempAnswerImageView: UIImageView?
    var tempAnswerLabel: UILabel?
    var index = 0
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Setup
    func setupUI() {
        paginationLabel.text = ""
        setupTempImageViewBounds()
        
        if (flashCard.answerImages != nil) {
            index = 0
            answerImageView.userInteractionEnabled = true
            answerImageView.image = flashCard.answerImages[0] as? UIImage
        }
        if (flashCard.answer != nil) {
            answerLabel.text = flashCard.answer
        } else {
            answerLabel.text = ""
        }
    }
    
    func setupTempImageViewBounds() {
        let width: CGFloat = answerImageView.bounds.size.width
        let height: CGFloat = answerImageView.bounds.size.height
        let x: CGFloat = answerImageView.bounds.origin.x
        let y: CGFloat = answerImageView.bounds.origin.y
        tempAnswerImageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    func showPaginationLabel() {
        paginationLabel.text = "\(index+1)/\(flashCard.answerImages.count)"
    }

    // MARK: Frame Maker
    func fullscreenFrame() -> CGRect {
        return CGRectMake(view.bounds.origin.x+10, view.bounds.origin.y+10, view.bounds.size.width-20, view.bounds.size.height-10)
    }
    
    // MARK: Navigation
    @IBAction func backButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
    }
}
