
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
    var isTapped = true
    var leftGesture = UISwipeGestureRecognizer()
    var rightGesture = UISwipeGestureRecognizer()
    var tapGesture = UITapGestureRecognizer()
    var index = 0
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
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
    
    func setupGestures() {
        let leftSwipeRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(AnswerViewController.handleLeftSwipe(_:)))
        leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        leftGesture = leftSwipeRecognizer
        let rightSwipeRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(AnswerViewController.handleRightSwipe(_:)))
        rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        rightGesture = rightSwipeRecognizer
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AnswerViewController.handleRightSwipe(_:)))
        tapGesture = tapGestureRecognizer
        let pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(AnswerViewController.handleTap(_:)))
        view.addGestureRecognizer(leftSwipeRecognizer)
        view.addGestureRecognizer(rightSwipeRecognizer)
        view.addGestureRecognizer(tapGestureRecognizer)
        answerImageView.addGestureRecognizer(pinchGesture)
    }
    
    func showPaginationLabel() {
        paginationLabel.text = "\(index+1)/\(flashCard.answerImages.count)"
    }
    
    func handleLeftSwipe(gesture: UISwipeGestureRecognizer) {
        if index < flashCard.answerImages.count-1 {
            index+=1
            showPaginationLabel()
            answerImageView.image = flashCard.answerImages[index] as? UIImage
        }
    }
    
    func handleRightSwipe(gesture: UISwipeGestureRecognizer) {
        if index > 0 {
            index+=1
            showPaginationLabel()
            answerImageView.image = flashCard.answerImages[index] as? UIImage
        }
    }
    
    func handlePinching(gesture: UIPinchGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.Changed || gesture.state == UIGestureRecognizerState.Ended {
            gesture.view!.transform = CGAffineTransformScale(gesture.view!.transform, gesture.scale, gesture.scale)
            gesture.scale = 1
        }
    }
    
    func handleTap(gesture: UITapGestureRecognizer) {
        if !isTapped {
            isTapped = true
            backButton.hidden = true
            nextButton.hidden = true
            
            if (flashCard.answer == nil) {
                answerLabel.hidden = true
                answer.hidden = true
                answerImageView.frame = fullscreenFrame()
            } else if (flashCard.answerImages == nil) {
                answerImageView.hidden = true
                answer.hidden = true
                answerLabel.frame = fullscreenFrame()
            }
        } else {
            isTapped = false
            backButton.hidden = false
            nextButton.hidden = false
            
            if (flashCard.answer == nil) {
                answerLabel.hidden = false
                answer.hidden = false
                if let tempImageBounds = tempAnswerImageView?.bounds {
                    answerImageView.bounds = tempImageBounds
                }
                answerImageView.bounds = tempAnswerImageView!.bounds
            } else if (flashCard.answerImages == nil) {
                answerImageView.hidden = false
                answer.hidden = false
                answerLabel.frame = CGRectMake(10, 60, view.bounds.size.width-20, view.bounds.size.height-20)
            }
        }
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
