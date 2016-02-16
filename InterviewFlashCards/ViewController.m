//
//  ViewController.m
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/11/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "ViewController.h"
#import "Firebase.h"
#import "IFCQueryManager.h"
#import "IFCFlashCard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *questionImageView;

@property (nonatomic) IFCQueryManager *queryManager;
@property (nonatomic) NSMutableArray <IFCFlashCard *> *flashCards;
@property (nonatomic) NSInteger currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavBar];

    self.flashCards = [NSMutableArray new];

    self.queryManager = [IFCQueryManager new];

    [self fetchData];

    self.currentIndex = 0;

}

- (void)setupNavBar {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    self.navigationItem.title = self.sectionName;

}

- (void)fetchData{
    Request type = [self requestType];

    [self.queryManager getDataForRequest:type completion:^(NSArray<NSDictionary *> *json) {

        self.flashCards = [NSMutableArray arrayWithArray:[IFCFlashCard flashCardsFromDictionaries:json]];
        [self prepareFlashCard:0];
    }];

}

- (Request)requestType{

    switch (self.section) {
        case iOSTechnical:
            return RequestTypeiOS;
            break;
        case DataStructures:
            return RequestTypeDataStructures;
            break;
        case Algorithms:
            return RequestTypeAlgorithms;
            break;
        default:
            break;
    }


}

- (void)prepareFlashCard:(NSInteger)index {

}

- (void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)prevButtonTapped:(UIButton *)sender {
}

- (IBAction)nextButtonTapped:(UIButton *)sender {
}


@end
