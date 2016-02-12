//
//  IFCMenuViewController.m
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "IFCMenuViewController.h"
#import "ViewController.h"

@interface IFCMenuViewController ()

@end

@implementation IFCMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)sectionButtonTapped:(UIButton *)sender {

    ViewController *questionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionsViewController"];

    questionVC.sectionName = sender.titleLabel.text;
    [self setSectionTypeForViewController:questionVC withValue:sender.tag];

    [self.navigationController pushViewController:questionVC animated:YES];

}

- (void)setSectionTypeForViewController:(ViewController *)vc withValue:(NSUInteger)value {

    switch (value) {
        case 0:
            vc.section = iOSTechnical;
            break;
        case 1:
            vc.section = DataStructures;
            break;
        case 2:
            vc.section = Algorithms;
            break;
        default:
            break;
    }
}

@end
