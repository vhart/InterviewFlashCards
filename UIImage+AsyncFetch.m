//
//  UIImage+AsyncFetch.m
//  InterviewFlashCards
//
//  Created by Varindra Hart on 2/13/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

#import "UIImage+AsyncFetch.h"

@implementation UIImage (AsyncFetch)

+ (void)asyncFetchForUrl:(NSString *)url withCompletion:(void (^)(UIImage *, BOOL))completion{

    NSURL *urlFromString = [NSURL URLWithString:url];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

        NSData *data = [NSData dataWithContentsOfURL:urlFromString];
        UIImage *img = [UIImage imageWithData:data];

        dispatch_async(dispatch_get_main_queue(), ^{
            completion(img, YES);
        });

    });

}

@end
