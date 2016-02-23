//
//  IFCFlashCard.m
//  InterviewFlashCards
//
//  Created by Mesfin Bekele Mekonnen on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "IFCFlashCard.h"
#import "NSMutableArray+Sizing.h"
#import "UIImage+AsyncFetch.h"

@implementation IFCFlashCard

- (instancetype)initWithDictionary:(NSDictionary *)dict {

    if (self = [super init]) {

        self.question         = dict[@"question"];
        self.answer           = dict[@"answer"];
        self.questionImageURL = dict[@"question_url"];

        NSDictionary *urls    = dict[@"answer_urls"];
        self.answerImageURLs = [self arrayOfUrlsFromDictionary:urls];

        if (self.questionImageURL) {
            self.questionImages = [NSMutableArray new];
        }
        if (self.answerImageURLs) {
            self.answerImages = [NSMutableArray new];
        }

    }

    return self;
}

- (NSArray *)arrayOfUrlsFromDictionary:(NSDictionary *)urlDict {

    if (urlDict) {
        NSMutableArray *urlArray = [NSMutableArray arrayWithSize:urlDict.allKeys.count];

        for (NSString *key in urlDict) {
            [urlArray replaceObjectAtIndex:[key integerValue] withObject:urlDict[key]];
        }

        return urlArray;
    }

    return nil;
}

- (void)prepareFlashCardWithCompletion:(void (^)())completion{

    if (self.questionImageURL && self.questionImages.count == 0) {
        [UIImage asyncFetchForUrl:self.questionImageURL withCompletion:^(UIImage *img, BOOL success) {
            [self.questionImages addObject:img];
            self.questionImagesLoaded = YES;
            if (self.answerImagesLoaded) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion();
                });
            }
        }];
    } else{
        self.questionImagesLoaded = YES;
    }

    if (self.answerImageURLs && self.answerImages.count == 0){
        dispatch_queue_t serial = dispatch_queue_create("com.answers.IFC", DISPATCH_QUEUE_SERIAL);
        for (NSString *url in self.answerImageURLs) {
            dispatch_async(serial, ^{

                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                UIImage *ansImage = [UIImage imageWithData:data];
                [self.answerImages addObject:ansImage];

                if (self.answerImages.count == self.answerImageURLs.count) {
                    self.answerImagesLoaded = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion();
                    });
                }
            });
        }
    } else {
        self.answerImagesLoaded = YES;
        if (self.questionImagesLoaded) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    }
}

+ (NSArray<IFCFlashCard *> *)flashCardsFromDictionaries:(NSArray<NSDictionary *> *)dictionaries{
    NSMutableArray <IFCFlashCard *> *flashCards = [NSMutableArray new];

    for (NSDictionary *dict in dictionaries) {
        IFCFlashCard *next = [[IFCFlashCard alloc] initWithDictionary:dict];
        [flashCards addObject:next];
    }

    return flashCards;
}




@end
