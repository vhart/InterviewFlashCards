//
//  IFCAnswerViewController.m
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "IFCAnswerViewController.h"

@interface IFCAnswerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *answerImageView;

@end

@implementation IFCAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (IBAction)backButtonTapped:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButtonTapped:(UIButton *)sender {

    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
