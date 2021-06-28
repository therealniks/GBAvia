//
//  TicketTableViewCell.h
//  GBAvia
//
//  Created by Nikita on 28.06.2021.
//

#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell
@property (nonatomic, strong) Ticket *ticket;
@end

NS_ASSUME_NONNULL_END
