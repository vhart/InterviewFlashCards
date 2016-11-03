//
//  MenuViewController.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 11/2/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Interview Flash Cards"
    }
    
    // MARK: Actions
    @IBAction func sectionButtonTapped(sender: UIButton) {
        let questionVC = storyboard?.instantiateViewControllerWithIdentifier("QuestionsViewController") as! QuestionsViewController
        questionVC.sectionName = (sender.titleLabel?.text)!
        self.setSectionTypeForViewController(questionVC, withValue: sender.tag)
        self.navigationController!.pushViewController(questionVC, animated: true)
    }
    
    func setSectionTypeForViewController(vc: QuestionsViewController, withValue value: Int) {
        guard let value = SectionQuestionType(rawValue: value) else { fatalError() }
        vc.section = value
        print(vc.section)
    }
}