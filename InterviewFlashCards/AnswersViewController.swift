import UIKit
import SyntaxKit
import BrightFutures

class AnswersViewController: UIViewController {

    enum ThemeApplied: Int {
        case tomorrow = 0
        case tomorrowBright = 1
    }

    struct ViewModel {
        let flashcard: Flashcard

        let answerTitleText = NSLocalizedString("Answer", comment: "")
        let backButtonText = NSLocalizedString("Back", comment: "")
        let darkOptionText = NSLocalizedString("Dark", comment: "")
        let lightOptionText = NSLocalizedString("Light", comment: "")

        var answerText: String {
            guard flashcard.type != .algorithms
                else { return flashcard.answer }
            return NSLocalizedString(flashcard.answer, comment: "")
        }
    }

    var flashcard: Flashcard!

    //MARK: IBOutlets

    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!

    fileprivate var answerLabel: UILabel?

    fileprivate var scrollView: UIScrollView?

    fileprivate var manager = BundleManager {
        (identifier, isLanguage) -> (URL?) in
        typealias TmTypeGenerator = (String) -> TmType?

        let languageGen: TmTypeGenerator = { id in return TmLanguage(rawValue: id) }
        let themeGen: TmTypeGenerator = { id in return TmTheme(rawValue: id) }

        guard let type: TmType = isLanguage ? languageGen(identifier) : themeGen(identifier)
            else { return nil }

        return Bundle.main.url(forResource: type.fileName,
                               withExtension: type.extensionType)
    }


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
        addBackButton()

        switch flashcard.type {
        case .algorithms:
            themeSegmentedControl.setTitle(viewModel.lightOptionText,
                                           forSegmentAt: 0)
            themeSegmentedControl.setTitle(viewModel.darkOptionText,
                                           forSegmentAt: 1)
            setUpCodeLabel(with: .tomorrow)
        case .iOS, .dataStructures:
            themeSegmentedControl.isHidden = true
            setUpTextAnswerLabel()
        }

        navigationItem.title = viewModel.answerTitleText
    }

    fileprivate func setUpScrollView() {
        scrollView = UIScrollView()
        guard let scrollView = self.scrollView else { fatalError() }
        let views: [String: UIView] = ["scrollView": scrollView, "segmentedControl": themeSegmentedControl]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[segmentedControl]-(4)-[scrollView]|", options: [], metrics: nil, views: views)

        NSLayoutConstraint.activate(constraints)
    }

    fileprivate func setUpTextAnswerLabel() {
        answerLabel = UILabel()
        answerLabel?.translatesAutoresizingMaskIntoConstraints = false
        scrollView?.addSubview(answerLabel!)
        answerLabel?.font = UIFont.systemFont(ofSize: 16.0)
        answerLabel?.numberOfLines = 0
        answerLabel?.text = viewModel.answerText
        var constraints = [NSLayoutConstraint(item: answerLabel!,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: scrollView!,
                                              attribute: .width,
                                              multiplier: 0.9,
                                              constant: 0),
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

    fileprivate func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: viewModel.backButtonText,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }

    fileprivate func setUpCodeLabel(with theme: ThemeApplied) {
        let codeString = generateCodeString(styledFor: theme)

        answerLabel?.removeFromSuperview()
        let codeLabel = UILabel()
        codeLabel.attributedText = codeString
        codeLabel.frame.size = codeString.size()
        codeLabel.frame.origin = CGPoint(x: 5, y: 5)
        codeLabel.numberOfLines = 0
        answerLabel = codeLabel
        scrollView?.contentSize = CGSize(width: codeString.size().width + 10, height: codeString.size().height + 10)
        scrollView?.addSubview(codeLabel)
    }

    fileprivate func generateCodeString(styledFor theme: ThemeApplied) -> NSAttributedString {
        let themeString: String

        switch theme {
        case .tomorrow: themeString = "Tomorrow"
        case .tomorrowBright: themeString = "Tomorrow-Night-Bright"
        }

        guard let font = UIFont(name: "Menlo-Regular", size: 14.0),
            let yaml = manager.language(withIdentifier: "Swift"),
            let themeToApply = manager.theme(withIdentifier: themeString) else { fatalError("Developer Error") }

        let layoutHandler = StringLayoutHandler(tabLength: .regular, font: font)
        let deserializedCode = layoutHandler.deserializedString(input: viewModel.answerText)
        let attributedParser = AttributedParser(language: yaml, theme: themeToApply)
        let attributedCodeString = attributedParser.attributedString(for: deserializedCode)
        return layoutHandler.applyFont(to: attributedCodeString)
    }

    fileprivate func updateAnswerLabel(with theme: ThemeApplied) {
        switch theme {
        case .tomorrow:
            scrollView?.backgroundColor = .white
        case .tomorrowBright:
            scrollView?.backgroundColor = .black
        }
        setUpCodeLabel(with: theme)
    }

    // MARK: IBAction

    @IBAction func themeChanged(_ sender: UISegmentedControl) {
        guard let theme = ThemeApplied(rawValue: sender.selectedSegmentIndex) else { return }

        updateAnswerLabel(with: theme)
    }

    //MARK: Navigation

    @objc fileprivate func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
