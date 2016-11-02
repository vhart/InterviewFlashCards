//
//  IFCQueryManager.h
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/15/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum RequestType{
    RequestTypeiOS = 1,
    RequestTypeDataStructures,
    RequestTypeAlgorithms,
    RequestTypeError
}Request;

@interface IFCQueryManager : NSObject

- (void)getDataForRequest:(Request)type completion:(void(^)(NSArray<NSDictionary*> * json))completion;

@end
