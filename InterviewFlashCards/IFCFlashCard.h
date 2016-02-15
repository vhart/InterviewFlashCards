//
//  IFCFlashCard.h
//  InterviewFlashCards
//
//  Created by Mesfin Bekele Mekonnen on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IFCFlashCard : NSObject

@property (nonatomic) NSString *question;
@property (nonatomic) NSString *answer;
@property (nonatomic) NSString *questionImageURL;
@property (nonatomic) NSArray <NSString *> *answerImageURLs;
@property (nonatomic) NSMutableArray *questionImages;
@property (nonatomic) NSMutableArray *answerImages;
@property (nonatomic) BOOL questionImagesLoaded;
@property (nonatomic) BOOL answerImagesLoaded;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (void)prepareFlashCardWithCompletion:(void(^)())completion;
+ (NSArray<IFCFlashCard *> *)flashCardsFromDictionaries:(NSArray <NSDictionary *> *)dictionaries;

@end
