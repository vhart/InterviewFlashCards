import UIKit

class AnswersViewController: UIViewController {

    struct ViewModel {
        let flashcard: Flashcard

        let answerTitleText = NSLocalizedString("Answer", comment: "")
        let backButtonText = NSLocalizedString("Back", comment: "")
        var answerText: String? {
            guard flashcard.type != .algorithms
                else { return nil }
            return NSLocalizedString(flashcard.answer, comment: "")
        }
    }

    var flashcard: Flashcard!

    //MARK: IBOutlets

    @IBOutlet weak var backBarButtonItem: UIBarButtonItem!

    fileprivate var answerLabel: UILabel?

    fileprivate var scrollView: UIScrollView?


    //MARK: Properties
    fileprivate var tempAnswerImageView: UIImageView?
    fileprivate var tempAnswerLabel: UILabel?
    fileprivate var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(flashcard: flashcard)
        setupUI()
    }

    //MARK: Setup
    fileprivate func setupUI() {
        setUpScrollView()
        setUpAnswerLabel()
        addBackButton()
        navigationItem.title = viewModel.answerTitleText
    }

    fileprivate func setUpScrollView() {
        scrollView = UIScrollView()
        guard let scrollView = self.scrollView else { fatalError() }
        let views: [String: UIView] = ["scrollView": scrollView]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(20)-[scrollView]|", options: [], metrics: nil, views: views)

        NSLayoutConstraint.activate(constraints)
    }

    fileprivate func setUpAnswerLabel() {
        answerLabel = UILabel()
        answerLabel?.translatesAutoresizingMaskIntoConstraints = false
        switch flashcard.type {
        case .algorithms:
            break
        case .iOS, .dataStructures:
            scrollView?.addSubview(answerLabel!)
            answerLabel?.font = UIFont.systemFont(ofSize: 14.0)
            answerLabel?.numberOfLines = 0
            answerLabel?.text = viewModel.answerText
            var constraints = [NSLayoutConstraint(item: answerLabel!,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: scrollView!,
                               attribute: .width,
                               multiplier: 1.0,
                               constant: -8),
                               NSLayoutConstraint(item: answerLabel!,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: scrollView!,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0)]

            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[answerLabel]", options: [], metrics: nil, views: ["answerLabel": answerLabel!])
            NSLayoutConstraint.activate(constraints)
        }
    }

    fileprivate func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: viewModel.backButtonText,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }

    //MARK: Navigation

    @objc fileprivate func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
