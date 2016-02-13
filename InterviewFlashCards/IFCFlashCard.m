//
//  IFCFlashCard.m
//  InterviewFlashCards
//
//  Created by Mesfin Bekele Mekonnen on 2/12/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "IFCFlashCard.h"

@implementation IFCFlashCard

-(instancetype)init {
    
    if (self = [super init]) {
        self.questions = [NSMutableArray new];
        self.answers = [NSMutableArray new];
        
        return  self;
    }
    return nil;
}

@end
