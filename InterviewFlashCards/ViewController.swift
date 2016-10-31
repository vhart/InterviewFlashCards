
//  ViewController.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 10/14/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    
    let queryManager = IFCQueryManager()
    let flashCards = [IFCFlashCard]()
    var sectionName = ""
    let currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        fetchData()
        
        let blue = UIColor.blue
    }
    
    func setupNavBar {
//        navigationItem.leftBarButtonItem.
        navigationItem.title = sectionName
    }
    
    func fetchData {
        Request.type = requestType
    
}

