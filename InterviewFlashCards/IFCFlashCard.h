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
@property (nonatomic) NSString *questionImageURL;
@property (nonatomic) NSArray <NSString *> *answerImageURLs;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
