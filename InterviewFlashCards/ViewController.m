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
@property (nonatomic) NSInteger previousIndex;
@property (nonatomic) NSInteger nextIndex;
@property (nonatomic) IFCFlashCard *currentFlushCard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavBar];

    self.flashCards = [NSMutableArray new];

    self.queryManager = [IFCQueryManager new];

    [self fetchData];

    self.currentIndex = 0;
    self.previousIndex = 0;
    self.nextIndex = 0;
}

- (void)setupNavBar {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    self.navigationItem.title = self.sectionName;

}

- (void)fetchData {
    Request type = [self requestType];

    [self.queryManager getDataForRequest:type completion:^(NSArray<NSDictionary *> *json) {

        self.flashCards = [NSMutableArray arrayWithArray:[IFCFlashCard flashCardsFromDictionaries:json]];
        [self prepareFlashCard:0];
        [self setupIndex];
        [self setupLabel:self.currentIndex];
    }];

}

-(void) setupIndex {
    
    if (self.previousIndex <=24 && self.currentIndex <= 24 && self.nextIndex <= 23) {
        self.previousIndex = self.currentIndex;
        self.nextIndex = self.currentIndex + 1;
        self.currentIndex = self.nextIndex;
    }
}

-(void)setupLabel:(NSInteger)index {
    self.questionLabel.text = self.flashCards[index].question;
    [self prepareFlashCard:self.nextIndex];
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
    
    IFCFlashCard *flashCardToPrepare = self.flashCards[index];
    
    [flashCardToPrepare prepareFlashCardWithCompletion:^{
        self.currentFlushCard = flashCardToPrepare;
    }];
}

- (void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)prevButtonTapped:(UIButton *)sender {
    
    self.questionLabel.text = self.flashCards[self.previousIndex].question;
    [self setupIndex];
}

- (IBAction)nextButtonTapped:(UIButton *)sender {
    self.questionLabel.text = self.flashCards[self.nextIndex].question;
     [self setupIndex];
}


@end
