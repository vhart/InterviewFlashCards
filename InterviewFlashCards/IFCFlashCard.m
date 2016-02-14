//
//  IFCFlashCard.m
//  InterviewFlashCards
//
//  Created by Mesfin Bekele Mekonnen on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "IFCFlashCard.h"
#import "NSMutableArray+Sizing.h"

@implementation IFCFlashCard

- (instancetype)initWithDictionary:(NSDictionary *)dict {

    if (self = [super init]) {

        self.question         = dict[@"question"];
        self.answer           = dict[@"answer"];
        self.questionImageURL = dict[@"question_url"];

        NSDictionary *urls    = dict[@"answer_urls"];
        self.answerImageURLs = [self arrayOfUrlsFromDictionary:urls];

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
@end
