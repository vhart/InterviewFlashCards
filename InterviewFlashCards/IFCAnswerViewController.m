//
//  IFCAnswerViewController.m
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "IFCAnswerViewController.h"
#import "UIImage+AsyncFetch.h"

@interface IFCAnswerViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *answerImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *answer;
@property (weak, nonatomic) IBOutlet UILabel *paginationLabel;

@property (nonatomic) UIImageView *tempAnswerImageView;
@property (nonatomic) UILabel *tempAnswerLabel;
@property (nonatomic) BOOL isTapped;

@property (nonatomic) UISwipeGestureRecognizer *leftGesture;
@property (nonatomic) UISwipeGestureRecognizer *rightGesture;
@property (nonatomic) UITapGestureRecognizer *tapGesture;

@property (nonatomic) NSInteger index;

@end

@implementation IFCAnswerViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupGestures];
}

#pragma mark - Setup

- (void)setupUI {
    
    self.paginationLabel.text = @"";
    [self setupTempImageViewBounds];
    
    if(self.flashCard.answerImages){
        self.index = 0;
        self.answerImageView.userInteractionEnabled = YES;
        self.answerImageView.image = self.flashCard.answerImages[0];
    }
    
    if(self.flashCard.answer) {
        self.answerLabel.text = self.flashCard.answer;
    }
    else {
        self.answerLabel.text = @"";
    }
}

- (void)setupTempImageViewBounds {
    
    CGFloat width = self.answerImageView.bounds.size.width;
    CGFloat height = self.answerImageView.bounds.size.height;
    CGFloat x = self.answerImageView.bounds.origin.x;
    CGFloat y = self.answerImageView.bounds.origin.y;
    
    self.tempAnswerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
}

- (void)setupGestures {
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe:)];
    
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.leftGesture = leftSwipe;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    self.rightGesture = rightSwipe;

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    self.tapGesture = tapGesture;
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinching:)];
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    [self.view addGestureRecognizer:tapGesture];
    [self.answerImageView addGestureRecognizer:pinchGesture];
}

- (void)showPaginationLabel {
    self.paginationLabel.text = [NSString stringWithFormat:@"%d/%d",self.index+1,self.flashCard.answerImages.count];
}

#pragma mark - Swipe Handlers

- (void)handleLeftSwipe:(UISwipeGestureRecognizer *)gesture {
    if (self.index < self.flashCard.answerImages.count-1) {
        self.index += 1;
        [self showPaginationLabel];
        self.answerImageView.image = self.flashCard.answerImages[self.index];
    }
}

- (void)handleRightSwipe:(UISwipeGestureRecognizer *)gesture {
    if (self.index > 0) {
        self.index -= 1;
        [self showPaginationLabel];
        self.answerImageView.image = self.flashCard.answerImages[self.index];
    }
}

- (void)handlePinching:(UIPinchGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded) {
        
        gesture.view.transform = CGAffineTransformScale(gesture.view.transform, gesture.scale, gesture.scale);
        gesture.scale = 1;
    }
}

- (void)handleTapGesture:(UITapGestureRecognizer *)gesture {
    
    if (!self.isTapped) {
        
        self.isTapped = YES;
        self.backButton.hidden = YES;
        self.nextButton.hidden = YES;
        
        if (!self.flashCard.answer) {
            
            self.answerLabel.hidden = YES;
            self.answer.hidden = YES;
            self.answerImageView.frame = [self fullscreenFrame];
        }
        else if(!self.flashCard.answerImages){
            
            self.answerImageView.hidden = YES;
            self.answer.hidden = YES;
            self.answerLabel.frame  = [self fullscreenFrame];
        }
    }
    else {

        self.isTapped = NO;
        self.backButton.hidden = NO;
        self.nextButton.hidden = NO;
        
        if (!self.flashCard.answer) {
            
            self.answerLabel.hidden = NO;
            self.answer.hidden = NO;
            self.answerImageView.bounds = self.tempAnswerImageView.bounds;
        }
        else if(!self.flashCard.answerImages) {
            
            self.answerImageView.hidden = NO;
            self.answer.hidden = NO;
            self.answerLabel.frame = CGRectMake(10, 60, self.view.bounds.size.width-20, self.view.bounds.size.height-20);
        }
    }
}

#pragma mark - Frame Maker

- (CGRect)fullscreenFrame {
    return CGRectMake(self.view.bounds.origin.x+10, self.view.bounds.origin.y+10, self.view.bounds.size.width-20, self.view.bounds.size.height-10);
}

#pragma mark - Navigation
- (IBAction)backButtonTapped:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButtonTapped:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
