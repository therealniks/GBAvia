//
//  TicketTableViewCell.h
//  GBAvia
//
//  Created by Nikita on 28.06.2021.
//

#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"
#import "FavouriteTicket+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *airlineLogoView;
@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic, strong) FavouriteTicket *favouriteTicket;
@end

NS_ASSUME_NONNULL_END
