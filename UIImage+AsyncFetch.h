//
//  UIImage+AsyncFetch.h
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/13/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AsyncFetch)

+ (void)asyncFetchForUrl:(NSString *)url withCompletion:(void(^)(UIImage *img, BOOL success))completion;

@end
