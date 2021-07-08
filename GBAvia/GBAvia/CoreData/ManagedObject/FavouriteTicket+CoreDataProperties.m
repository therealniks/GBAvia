//
//  FavouriteTicket+CoreDataProperties.m
//  GBAvia
//
//  Created by therealniks on 08.07.2021.
//
//

#import "FavouriteTicket+CoreDataProperties.h"

@implementation FavouriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavouriteTicket *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavouriteTicket"];
}

@dynamic airline;
@dynamic created;
@dynamic departure;
@dynamic expires;
@dynamic from;
@dynamic to;
@dynamic flightNumber;
@dynamic returnDate;
@dynamic price;

@end
