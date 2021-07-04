//
//  MainViewController.m
//  GBAvia
//
//  Created by Nikita on 17.06.2021.
//

#import "MainViewController.h"
#import "DataManager.h"
#import "PlaceViewController.h"
#import "APIManager.h"
#import "TicketsTableViewController.h"
#import "MapViewController.h"
#import "LocationService.h"

@interface MainViewController () <PlaceViewControllerDelegate>
@property (nonatomic, strong) UIView *placeContainerView;
@property (nonatomic, strong) UIButton *departureButton;
@property (nonatomic, strong) UIButton *arrivalButton;
@property (nonatomic, strong) UIButton *searchButton;
//@property (nonatomic, strong) UIButton *mapPriceButton;
@property (nonatomic) SearchRequest searchRequest;
@property (nonatomic, strong) LocationService *locationService;
@property (nonatomic, strong) CLLocation *currentLocation;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DataManager sharedInstance] loadData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Search";
    
    _placeContainerView = [[UIView alloc] initWithFrame:CGRectMake(20, 140, [UIScreen mainScreen].bounds.size.width, 170)];
    _placeContainerView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
    _placeContainerView.layer.shadowOffset = CGSizeZero;
    _placeContainerView.layer.shadowRadius = 20;
    _placeContainerView.layer.shadowOpacity = 1.0;
    _placeContainerView.layer.cornerRadius = 6;
    
    
    _departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_departureButton setTitle:@"From" forState: UIControlStateNormal];
    _departureButton.tintColor = [UIColor blackColor];
    _departureButton.frame = CGRectMake(30.0, 140.0, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    _departureButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    _departureButton.layer.cornerRadius = 4;
    [_departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_departureButton];
    
    _arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_arrivalButton setTitle:@"To" forState: UIControlStateNormal];
    _arrivalButton.tintColor = [UIColor blackColor];
    _arrivalButton.frame = CGRectMake(30.0, CGRectGetMaxY(_departureButton.frame) + 20.0, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    _arrivalButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    _arrivalButton.layer.cornerRadius = 4;
    [_arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_arrivalButton];

    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_searchButton setTitle:@"Search" forState:UIControlStateNormal];
    _searchButton.tintColor = [UIColor whiteColor];
    _searchButton.frame = CGRectMake(30, CGRectGetMaxX(_placeContainerView.frame) + 30,
                                     [UIScreen mainScreen].bounds.size.width - 60, 60);
    _searchButton.backgroundColor = [UIColor systemBlueColor];
    _searchButton.layer.cornerRadius = 8;
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    [_searchButton addTarget:self action:@selector(searchButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
    [self.view addSubview:_searchButton];
    
//    _mapPriceButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [_mapPriceButton setTitle:@"Map price" forState:UIControlStateNormal];
//    _mapPriceButton.tintColor = [UIColor whiteColor];
//    _mapPriceButton.frame = CGRectMake(30, CGRectGetMaxX(_placeContainerView.frame) + 100,
//                                     [UIScreen mainScreen].bounds.size.width - 60, 60);
//    _mapPriceButton.backgroundColor = [UIColor systemBlueColor];
//    _mapPriceButton.layer.cornerRadius = 8;
//    _mapPriceButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
//    [_mapPriceButton addTarget:self action:@selector(mapPriceDidTap:) forControlEvents:UIControlEventTouchUpInside];

//    [self.view addSubview:_mapPriceButton];
    
    
}

- (void)dataLoadedSuccessfully {
    _locationService = [[LocationService alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
    }

- (void)updateCurrentLocation:(NSNotification *)notification {
    _currentLocation = notification.object;
    if (_currentLocation) {
        City *city = [[DataManager sharedInstance] cityForLocation:_currentLocation];
        if (city) {
            [self selectPlace:city withType:PlaceTypeDeparture andDataType:DataSourceTypeCity];
        }
    }
}

- (void)placeButtonDidTap:(UIButton *)sender {
    PlaceViewController *placeViewController;
    if ([sender isEqual:_departureButton]) {
        placeViewController = [[PlaceViewController alloc] initWithType: PlaceTypeDeparture];
    } else {
        placeViewController = [[PlaceViewController alloc] initWithType: PlaceTypeArrival];
    }
    placeViewController.delegate = self;
    [self.navigationController pushViewController: placeViewController animated:YES];
}

- (void)searchButtonDidTap:(UIButton *)sender {
    [[APIManager sharedInstance] ticketsWithRequest:_searchRequest withCompletion:^(NSArray *tickets)
    {
    if (tickets.count > 0) {
        TicketsTableViewController *ticketsTableViewController = [[TicketsTableViewController alloc] initWithTickets:tickets];
        [self.navigationController pushViewController:ticketsTableViewController animated:self];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Увы!"
        message:@"По данному направлению билетов не найдено" preferredStyle: UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть"
        style:(UIAlertActionStyleDefault) handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

//- (void)mapPriceDidTap: (UIButton *) sender {
//    MapViewController *mapViewController = [[MapViewController alloc] initWithLocation:_currentLocation];
//    [self.navigationController pushViewController:mapViewController animated:YES];
//}


//MARK:- Delegate

- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType {
    [self setPlace:place withDataType:dataType andPlaceType:placeType forButton: (placeType == PlaceTypeDeparture) ? _departureButton : _arrivalButton ];
}

- (void)setPlace:(id)place withDataType:(DataSourceType)dataType andPlaceType:(PlaceType)placeType forButton:(UIButton *)button {
    
    NSString *title;
    NSString *iata;
    
    if (dataType == DataSourceTypeCity) {
        City *city = (City *)place;
        title = city.name;
        iata = city.code;
    }
    else if (dataType == DataSourceTypeAirport) {
        Airport *airport = (Airport *)place;
        title = airport.name;
        iata = airport.cityCode;
    }
    
    if (placeType == PlaceTypeDeparture) {
        _searchRequest.origin = iata;
    } else {
        _searchRequest.destination = iata;
    }
    
    [button setTitle:title forState:UIControlStateNormal];
}


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





@end
