
import UIKit

class MenuViewController: UIViewController {
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Interview Flash Cards"
    }
    
    // MARK: Actions
    @IBAction func sectionButtonTapped(sender: UIButton) {
        let questionVC = storyboard?.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        questionVC.sectionName = sender.titleLabel?.text ?? ""
        questionVC.setSectionTypeForViewController(questionVC, withValue: sender.tag)
        navigationController?.pushViewController(questionVC, animated: true)
    }    
}
