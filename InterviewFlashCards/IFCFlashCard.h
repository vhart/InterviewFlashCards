//
//  IFCFlashCard.h
//  InterviewFlashCards
//
//  Created by Mesfin Bekele Mekonnen on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFCFlashCard : NSObject

@property (nonatomic) NSString *question;
@property (nonatomic) NSString *answer;
@property (nonatomic) NSURL *questionImageURL;
@property (nonatomic) NSURL *answerImageURL;

@end
