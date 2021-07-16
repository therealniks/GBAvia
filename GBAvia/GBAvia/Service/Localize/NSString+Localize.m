//
//  NSString+Localize.m
//  GBAvia
//
//  Created by therealniks on 16.07.2021.
//

#import "NSString+Localize.h"

@implementation NSString (Localize)
- (NSString *)localize {
    return NSLocalizedString(self, "");
}
@end
