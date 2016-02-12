//
//  ViewController.m
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/11/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "ViewController.h"
#import "Firebase.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavBar];

    Firebase *ref = [[Firebase alloc]initWithUrl:@"https://fiery-torch-4131.firebaseio.com/"];

    [[ref queryOrderedByKey] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ with value %@", snapshot.key, snapshot.value);
    }];

}

- (void)setupNavBar {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    self.navigationItem.title = self.sectionName;

}

- (void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
