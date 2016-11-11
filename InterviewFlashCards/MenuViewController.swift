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
        navigationItem.title = "Interview Flash Cards"
    }
    
    // MARK: Actions
    @IBAction func sectionButtonTapped(sender: UIButton) {
        let questionVC = storyboard?.instantiateViewControllerWithIdentifier("questionsVC") as! QuestionsViewController
        questionVC.sectionName = sender.titleLabel?.text ?? ""
        questionVC.setSectionTypeForViewController(questionVC, withValue: sender.tag)
        navigationController?.pushViewController(questionVC, animated: true)
    }
    
}
