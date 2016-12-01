
#import <UIKit/UIKit.h>

@interface UIImage (AsyncFetch)

+ (void)asyncFetchForUrl:(NSString *)url withCompletion:(void(^)(UIImage *img, BOOL success))completion;

@end
