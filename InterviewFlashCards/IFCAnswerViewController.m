//
//  IFCAnswerViewController.m
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "IFCAnswerViewController.h"
#import "UIImage+AsyncFetch.h"

@interface IFCAnswerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *answerImageView;

@end

@implementation IFCAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIImage asyncFetchForUrl:@"https://s3-us-west-2.amazonaws.com/interviewflashcardsbucket/integerPalindrome.png" withCompletion:^(UIImage *img, BOOL success) {
        self.answerImageView.image = img;
    }];
}
- (IBAction)backButtonTapped:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButtonTapped:(UIButton *)sender {

    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
