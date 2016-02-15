//
//  InterviewFlashCardsTests.m
//  InterviewFlashCardsTests
//
//  Created by Varindra Hart on 2/11/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>
#import "IFCQueryManager.h"

@interface InterviewFlashCardsTests : XCTestCase

@property (nonatomic) IFCQueryManager *qman;

@end

@implementation InterviewFlashCardsTests

- (void)setUp {
    [super setUp];
    self.qman = [IFCQueryManager new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testQueryManagerGetData {

    XCTestExpectation *expectation = [self expectationWithDescription:@"AsyncFetch"];

    __block NSArray *testArray;

    [self.qman getDataForRequest:RequestTypeiOS completion:^(NSArray *json) {
        XCTAssert(json.count > 0);
        testArray = [NSArray arrayWithArray: json];
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        NSLog(@"Successful getData - QUERY MANAGER");
        NSLog(@"%@",testArray);
    }];
}

@end
