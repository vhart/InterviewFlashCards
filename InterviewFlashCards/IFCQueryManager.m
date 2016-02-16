//
//  IFCQueryManager.m
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/15/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "IFCQueryManager.h"
#import "Firebase.h"

@implementation IFCQueryManager

NSString *BASE_URL = @"https://fiery-torch-4131.firebaseio.com/";


- (void)getDataForRequest:(Request)type completion:(void (^)(NSArray<NSDictionary *> *))completion{

    Firebase *ref = [[Firebase alloc]initWithUrl:BASE_URL];
    
    [[ref queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {

        if ([snapshot.key isEqualToString:[self firebaseRequestStringForType:type]]) {
            NSMutableArray <NSDictionary *> *fireBaseDataArray = [self populateArrayWithSnapshot:snapshot];
            completion(fireBaseDataArray);
        }

    }];
}


- (NSString *)firebaseRequestStringForType:(Request)type {

    switch (type) {
        case RequestTypeiOS:
            return @"iOS technical questions";
            break;
        case RequestTypeDataStructures:
            return @"data structure questions";
            break;
        case RequestTypeAlgorithms:
            return @"algorithm questions";
            break;
        default:
            return @"";
            break;
    }

}

- (NSMutableArray <NSDictionary *> *)populateArrayWithSnapshot:(FDataSnapshot *)snapshot{
    NSMutableArray <NSDictionary *> *firebaseArray = [NSMutableArray new];

    for (NSDictionary *dict in [(NSDictionary *)snapshot.valueInExportFormat allValues]) {
        [firebaseArray addObject:dict];
    }

    return firebaseArray;
}

@end
