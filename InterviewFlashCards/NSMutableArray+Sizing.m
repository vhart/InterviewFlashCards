//
//  NSMutableArray+Sizing.m
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/13/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "NSMutableArray+Sizing.h"

@implementation NSMutableArray (Sizing)

+ (instancetype)arrayWithSize:(NSUInteger)size {

    NSMutableArray *array = [NSMutableArray new];

    for (int i = 0; i < size; i++){
        [array addObject:@" "];
    }

    return array;
}

@end
