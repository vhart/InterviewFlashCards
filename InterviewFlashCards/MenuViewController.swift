import UIKit

class MenuViewController: UIViewController {

    enum Section: Int {
        case ios
        case dataStructures
        case algorithms
    }

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Interview Flash Cards"
    }

    // MARK: Actions
    @IBAction func sectionButtonTapped(_ sender: UIButton) {
        guard let section = Section(rawValue: sender.tag),
            let storyboard = storyboard,
            let questionVC = storyboard
                .instantiateViewController(withIdentifier: "QuestionsViewController")
                as? QuestionsViewController
            else {
                fatalError("Invalid Section")
        }
        questionVC.sectionName = sender.titleLabel?.text ?? ""

        switch section {
        case .ios:
            questionVC.set(sectionType: .iOSTechnical)
        case .dataStructures:
            questionVC.set(sectionType: .dataStructures)
        case .algorithms:
            questionVC.set(sectionType: .algorithms)
        }
        navigationController?.pushViewController(questionVC, animated: true)
    }

}
