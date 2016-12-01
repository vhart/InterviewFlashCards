
#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>
#import "IFCFlashCard.h"

@interface InterviewFlashCardsTests : XCTestCase

@property (nonatomic) IFCFlashCard *flashCard;

@end

@implementation InterviewFlashCardsTests

- (void)setUp {
    [super setUp];
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

    [qman getDataForRequest:RequestTypeiOS completion:^(NSArray *json) {
        XCTAssert(json.count > 0);
        testArray = [NSArray arrayWithArray: json];
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        NSLog(@"Successful getData - QUERY MANAGER");
        NSLog(@"%@",testArray);
    }];
}

- (void)testFlashCardPreparation {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Image Fetching"];
    
    flashCard = [[IFCFlashCard alloc] init];
    flashCard.answerImages = [NSMutableArray new];
    flashCard.questionImages = [NSMutableArray new];
    
    flashCard.answerImageURLs = @[@"https://s3-us-west-2.amazonaws.com/interviewflashcardsbucket/changeMaker.png"];
    
    flashCard.questionImageURL = @"http://www.cs.wcupa.edu/rkline/assets/img/DS/bst2.png?1264796754";
    
    [flashCard prepareFlashCardWithCompletion:^{
        
        
        XCTAssert(flashCard.questionImages != nil);
        
        XCTAssert(flashCard.answerImages.count == flashCard.answerImageURLs.count && flashCard.answerImages != nil);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error in preparing flash card: %@",error.localizedDescription);
        }
    }];
}

@end
