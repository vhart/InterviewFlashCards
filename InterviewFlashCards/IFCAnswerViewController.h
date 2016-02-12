//
//  IFCAnswerViewController.h
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFCAnswerViewController : UITableViewController

@property (nonatomic) BOOL hasImage;
@property (nonatomic) UIImage *answerImage;
@property (nonatomic) NSString *answerString;

@end
