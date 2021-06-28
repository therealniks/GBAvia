//
//  APIManager.h
//  GBAvia
//
//  Created by Nikita on 27.06.2021.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

+ (instancetype)sharedInstance;
- (void)cityForCurrentIP:(void (^)(City *city))completion;
- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion

@end

NS_ASSUME_NONNULL_END
