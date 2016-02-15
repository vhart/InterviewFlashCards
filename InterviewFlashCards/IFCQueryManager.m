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


- (void)getDataForRequest:(Request)type completion:(void (^)(NSArray *))completion{

    NSMutableArray <NSDictionary *> *fireBaseDataArray = [NSMutableArray new];

    Firebase *ref = [[Firebase alloc]initWithUrl:[self firebaseRequestStringForType:type]];
    
    [[ref queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {

        [fireBaseDataArray addObject:(NSDictionary *)[snapshot valueInExportFormat]];

        if (fireBaseDataArray.count == 25) {
            completion(fireBaseDataArray);
        }
    }];
}


- (NSString *)firebaseRequestStringForType:(Request)type {

    switch (type) {
        case RequestTypeiOS:
            return [BASE_URL stringByAppendingString:@"iOS technical questions"];
            break;
        case RequestTypeDataStructures:
            return [BASE_URL stringByAppendingString:@"data structure questions"];
            break;
        case RequestTypeAlgorithms:
            return [BASE_URL stringByAppendingString:@"algorithm questions"];
            break;
        default:
            return BASE_URL;
            break;
    }

}
@end
