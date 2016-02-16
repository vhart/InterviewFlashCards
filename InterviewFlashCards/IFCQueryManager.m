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

    NSMutableArray <NSDictionary *> *fireBaseDataArray = [NSMutableArray new];

    __block NSInteger childrenCount;

    dispatch_queue_t serial = dispatch_queue_create("fetching", DISPATCH_QUEUE_SERIAL);

    dispatch_async(serial, ^{
        [self childrenCountForSection:type withCompletion:^(NSInteger count) {

            childrenCount = count;

            Firebase *ref = [[Firebase alloc]initWithUrl:[self firebaseRequestStringForType:type]];

            dispatch_async(serial, ^{
                [[ref queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {

                    [fireBaseDataArray addObject:(NSDictionary *)[snapshot valueInExportFormat]];

                    if (fireBaseDataArray.count == childrenCount) {
                        completion(fireBaseDataArray);
                    }
                }];
            });

        }];
    });


}

- (void)childrenCountForSection:(Request)type withCompletion:(void(^)(NSInteger count))completion{
    Firebase *ref = [[Firebase alloc]initWithUrl:BASE_URL];
    [[[ref queryOrderedByChild:
           [self destinationPathForSection:type]]
                 queryLimitedToFirst:1]
                     observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {

        NSInteger children = snapshot.childrenCount ;
        completion(children);
    }];

}
- (NSString *)firebaseRequestStringForType:(Request)type {

    return [BASE_URL stringByAppendingString:[self destinationPathForSection:type]];
}

- (NSString *)destinationPathForSection:(Request)type {

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
@end
