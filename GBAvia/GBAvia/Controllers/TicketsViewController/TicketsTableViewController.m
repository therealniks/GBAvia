//
//  TicketsTableViewController.m
//  GBAvia
//
//  Created by Nikita on 28.06.2021.
//

#import "TicketsTableViewController.h"
#import "TicketTableViewCell.h"
#import "CoreDataHelper.h"
#import "NotificationCenter.h"
#define TicketCellReuseIdentifier @"TicketCellIdentifier"



@interface TicketsTableViewController ()
@property (nonatomic, strong) NSArray *tickets;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;

@end

@implementation TicketsTableViewController {
    BOOL isFavourite;
    TicketTableViewCell *notificationCell;
}

- (instancetype) initFavouriteTicketController {
    self = [super init];
    if (self) {
        isFavourite = YES;
        self.tickets = [NSArray new];
        self.title = @"Favourite";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass: [TicketTableViewCell class] forCellReuseIdentifier: TicketCellReuseIdentifier];
    }
    return self;
}

- (instancetype)initWithTickets:(NSArray *)tickets {
    self = [super init];
    if (self) {
        _tickets = tickets;
        self.title = @"Tickets";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class]
        forCellReuseIdentifier:TicketCellReuseIdentifier];
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [NSDate date];        
        [_datePicker setPreferredDatePickerStyle: UIDatePickerStyleWheels];
        _dateTextField = [[UITextField alloc] initWithFrame:self.view.bounds];
        _dateTextField.hidden = YES;
        _dateTextField.inputView = _datePicker;
        UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
        [keyboardToolbar sizeToFit];
        UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil action:nil];
        UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                       target:self action:@selector(doneButtonDidTap:)];
        keyboardToolbar.items = @[flexBarButton, doneBarButton];
        _dateTextField.inputAccessoryView = keyboardToolbar;
        [self.view addSubview:_dateTextField];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (isFavourite) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        _tickets = [[CoreDataHelper sharedInstance] favourites];
        [self.tableView reloadData];
    }
}


    #pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];
    if (isFavourite) {
            cell.favouriteTicket = [_tickets objectAtIndex:indexPath.row];
        } else {
            cell.ticket = [_tickets objectAtIndex:indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFavourite) return;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом"
                                                                             message:@"Что необходимо сделать с выбранным билетом?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    if ([[CoreDataHelper sharedInstance] isFavouriteTicket: [_tickets objectAtIndex:indexPath.row]]) {
        favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного"
        style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] removeFromFavourite:[self->_tickets objectAtIndex:indexPath.row]];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное"
        style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavourite:[self->_tickets objectAtIndex:indexPath.row]];
        }];
    }
    
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:@"Напомнить"
                                                                 style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self->notificationCell = [tableView cellForRowAtIndexPath:indexPath];
        [self->_dateTextField becomeFirstResponder];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel
    handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:notificationAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)doneButtonDidTap:(UIBarButtonItem *)sender {
if (_datePicker.date && notificationCell) {
    NSString *message = [NSString stringWithFormat:@"%@ - %@ за %@ руб.",
                         notificationCell.ticket.from,
                         notificationCell.ticket.to,
                         notificationCell.ticket.price];
    NSURL *imageURL;
    if (notificationCell.airlineLogoView.image) { NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
    NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", notificationCell.ticket.airline]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        UIImage *logo = notificationCell.airlineLogoView.image;
        NSData *pngData = UIImagePNGRepresentation(logo);
        [pngData writeToFile:path atomically:YES];
        }
        imageURL = [NSURL fileURLWithPath:path];
    }
    Notification notification = NotificationMake(@"Напоминание о билете", message,_datePicker.date, imageURL);
    [[NotificationCenter sharedInstance] sendNotification:notification];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Успешно" message:
                                          [NSString stringWithFormat:@"Уведомление будет отправлено - %@",
                                           _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];

    _datePicker.date = [NSDate date];
    notificationCell = nil;
    [self.view endEditing:YES];
    [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

@end
