
#import "NSMutableArray+Sizing.h"

@implementation NSMutableArray (Sizing)

+ (instancetype)arrayWithSize:(NSUInteger)size {

    NSMutableArray *array = [NSMutableArray new];

    for (int i = 0; i < size; i++){
        [array addObject:@" "];
    }

    return array;
}

@end
