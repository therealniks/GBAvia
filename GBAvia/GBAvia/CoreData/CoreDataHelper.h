//
//  CoreDataHelper.h
//  GBAvia
//
//  Created by therealniks on 08.07.2021.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import "FavouriteTicket+CoreDataClass.h"
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject

+ (instancetype) sharedInstance;

- (BOOL) isFavouriteTicket: (Ticket *)ticket;
- (NSArray *) favourites;
- (void) addToFavourite: (Ticket *)ticket;
- (void) removeFromFavourite: (Ticket *)ticket;

@end

NS_ASSUME_NONNULL_END
