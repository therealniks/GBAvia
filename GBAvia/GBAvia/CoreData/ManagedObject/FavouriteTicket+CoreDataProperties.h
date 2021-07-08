//
//  FavouriteTicket+CoreDataProperties.h
//  GBAvia
//
//  Created by therealniks on 08.07.2021.
//
//

#import "FavouriteTicket+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavouriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavouriteTicket *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *airline;
@property (nullable, nonatomic, copy) NSDate *created;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nullable, nonatomic, copy) NSDate *expires;
@property (nullable, nonatomic, copy) NSString *from;
@property (nullable, nonatomic, copy) NSString *to;
@property (nonatomic) int16_t flightNumber;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nonatomic) int64_t price;

@end

NS_ASSUME_NONNULL_END
