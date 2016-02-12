//
//  ViewController.h
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/11/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SectionQuestionType {
    iOSTechnical = 0,
    DataStructures,
    Algorithms
} SectionType;

@interface ViewController : UIViewController

@property (nonatomic) NSString *sectionName;
@property (nonatomic) SectionType section;

@end

