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
#import "IFCAnswerViewController.h"

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


//TODO: Swift Conversion
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
    
    __weak typeof(self) weakSelf = self;
    [self.queryManager getDataForRequest:type completion:^(NSArray<NSDictionary *> *json) {
        
        weakSelf.flashCards = [NSMutableArray arrayWithArray:[IFCFlashCard flashCardsFromDictionaries:json]];
        [weakSelf prepareFlashCard:0];
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
    
    self.nextButton.hidden = YES;
    self.answerButton.hidden = YES;
    
    IFCFlashCard *nextCard = self.flashCards[index];
    
    __weak typeof(self) weakSelf = self;
    [nextCard prepareFlashCardWithCompletion:^{
        [weakSelf prepareUIwithCard:nextCard];
    }];
}

- (void)prepareUIwithCard:(IFCFlashCard *)flashCard {
    
    self.questionLabel.text = flashCard.question;
    
    self.questionImageView.image = nil;
    
    if(flashCard.questionImages && flashCard.questionImages.count > 0){
        UIImage *questionImage = (UIImage *)flashCard.questionImages[0];
        self.questionImageView.image = questionImage;
    }
    
    self.nextButton.hidden = NO;
    self.answerButton.hidden = NO;
}

- (void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)prevButtonTapped:(UIButton *)sender {
    self.currentIndex = self.currentIndex - 1 < 0 ? (self.currentIndex - 1 + self.flashCards.count) : 0;
    [self prepareFlashCard:self.currentIndex];
}

- (IBAction)nextButtonTapped:(UIButton *)sender {
    self.currentIndex = (self.currentIndex + 1)%(self.flashCards.count);
    [self prepareFlashCard:self.currentIndex];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if( [segue.destinationViewController isKindOfClass:[IFCAnswerViewController class]]) {
        
        ((IFCAnswerViewController *)segue.destinationViewController).flashCard = self.flashCards[self.currentIndex];
    }
}


@end
