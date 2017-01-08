//
//  AnswersViewController.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 1/5/17.
//  Copyright © 2017 Varindra Hart. All rights reserved.
//

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
    
    // MARK: Properties
    var tempAnswerImageView: UIImageView?
    var tempAnswerLabel: UILabel?
    var isTapped = false
    var index = 0
    var leftGesture: UISwipeGestureRecognizer?
    var rightGesture: UISwipeGestureRecognizer?
    var tapGesture: UITapGestureRecognizer?
    
    
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
            answerImageView.isUserInteractionEnabled = true
            answerImageView.image = flashCard.answerImages[0] as? UIImage
        } else if flashCard.answer == nil {
            answerLabel.text = ""
        } else {
            answerLabel.text = flashCard.answer
        }
    }
    
    func setupTempImageViewBounds() {
        tempAnswerImageView = UIImageView(frame: answerImageView.frame)
    }
    
    func setupGestures() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinching))
        answerImageView.addGestureRecognizer(pinchGesture)
    }
    
    func showPaginationLabel() {
        paginationLabel.text = "\(index + 1)/\(flashCard.answerImages.count)"
    }
    
    func handlePinching(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed || gesture.state == .ended {
            if let gestureView = (gesture.view?.transform.scaledBy(x: gesture.scale, y: gesture.scale)) {
                gesture.view?.transform = gestureView
                gesture.scale = 1
            }
        }
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
