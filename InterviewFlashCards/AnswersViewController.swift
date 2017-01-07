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
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var paginationLabel: UILabel!
    var tempAnswerImageView: UIImageView!
    var tempAnswerLabel: UILabel!
    var isTapped = false
    var index = 0
    var leftGesture: UISwipeGestureRecognizer!
    var rightGesture: UISwipeGestureRecognizer!
    var tapGesture: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
    }
    
    // MARK: Setup
    func setupUI() {
        self.paginationLabel.text = ""
        self.setupTempImageViewBounds()
        if (self.flashCard.answerImages != nil) {
            self.index = 0
            self.answerImageView.isUserInteractionEnabled = true
            self.answerImageView.image = self.flashCard.answerImages[0] as? UIImage
        }
        if (self.flashCard.answer != nil) {
            self.answerLabel.text = self.flashCard.answer
        }
        else {
            self.answerLabel.text = ""
        }
    }
    
    func setupTempImageViewBounds() {
        var width: CGFloat = self.answerImageView.bounds.size.width
        var height: CGFloat = self.answerImageView.bounds.size.height
        var x: CGFloat = self.answerImageView.bounds.origin.x
        var y: CGFloat = self.answerImageView.bounds.origin.y
        self.tempAnswerImageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    func setupGestures() {
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleLeftSwipe))
        leftSwipe.direction = .left
        self.leftGesture = leftSwipe
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleRightSwipe))
        rightSwipe.direction = .right
        self.rightGesture = rightSwipe
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        self.tapGesture = tapGesture
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinching))
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(tapGesture)
        answerImageView.addGestureRecognizer(pinchGesture)
    }
    
    func showPaginationLabel() {
        self.paginationLabel.text = "\(self.index + 1)/\(self.flashCard.answerImages.count)"
    }
    
    // MARK: Swipe Handlers
    
    func handleLeftSwipe(_ gesture: UISwipeGestureRecognizer) {
        if self.index < self.flashCard.answerImages.count - 1 {
            self.index += 1
            self.showPaginationLabel()
            self.answerImageView.image = self.flashCard.answerImages[self.index] as? UIImage
        }
    }
    
    func handleRightSwipe(_ gesture: UISwipeGestureRecognizer) {
        if self.index > 0 {
            self.index -= 1
            self.showPaginationLabel()
            self.answerImageView.image = self.flashCard.answerImages[self.index] as? UIImage
        }
    }
    
    func handlePinching(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed || gesture.state == .ended {
            gesture.view?.transform = (gesture.view?.transform.scaledBy(x: gesture.scale, y: gesture.scale))!
            gesture.scale = 1
        }
    }
    
    func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        if !self.isTapped {
            self.isTapped = true
            self.backButton.isHidden = true
            self.nextButton.isHidden = true
            if !(self.flashCard.answer != nil) {
                self.answerLabel.isHidden = true
                self.answer.isHidden = true
                self.answerImageView.frame = self.fullscreenFrame()
            }
            else if !(flashCard.answerImages != nil) {
                self.answerImageView.isHidden = true
                self.answer.isHidden = true
                self.answerLabel.frame = self.fullscreenFrame()
            }
        }
        else {
            self.isTapped = false
            self.backButton.isHidden = false
            self.nextButton.isHidden = false
            if !(self.flashCard.answer != nil) {
                self.answerLabel.isHidden = false
                self.answer.isHidden = false
                self.answerImageView.bounds = self.tempAnswerImageView.bounds
            }
            else if !(self.flashCard.answerImages != nil) {
                self.answerImageView.isHidden = false
                self.answer.isHidden = false
                self.answerLabel.frame = CGRect(x: CGFloat(10), y: CGFloat(60), width: CGFloat(self.view.bounds.size.width - 20), height: CGFloat(self.view.bounds.size.height - 20))
            }
        }
    }
    
    //MARK: Score Tracker Alert
    func displayScoreTrackerAlert() {
        var controller = UIAlertController(title: "Score Check Time", message: "Did you get it?", preferredStyle: .alert)
        var yesAction = UIAlertAction(title: "YES", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.dismiss(animated: false, completion: { _ in })
        })
        var noAction = UIAlertAction(title: "NO", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.dismiss(animated: false, completion: { _ in })
        })
        controller.addAction(yesAction)
        controller.addAction(noAction)
        self.present(controller, animated: true, completion: { _ in })
    }
    
    //MARK: Frame Maker
    func fullscreenFrame() -> CGRect {
        return CGRect(x: CGFloat(self.view.bounds.origin.x + 10), y: CGFloat(self.view.bounds.origin.y + 10), width: CGFloat(self.view.bounds.size.width - 20), height: CGFloat(self.view.bounds.size.height - 10))
    }
    
    //MARK: Navigation
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.displayScoreTrackerAlert()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        self.displayScoreTrackerAlert()
    }
}
