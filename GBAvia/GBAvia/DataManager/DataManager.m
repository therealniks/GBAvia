//
//  DataManager.m
//  GBAvia
//
//  Created by Nikita on 20.06.2021.
//

#import "DataManager.h"

@interface DataManager()
    @property(nonatomic, strong) NSArray *countriesArray;
    @property(nonatomic, strong) NSArray *citiesArray;
    @property(nonatomic, strong) NSArray *airportsArray;
@end

@implementation DataManager

+(instancetype) sharedInstance {
    static DataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    return instance;
}

-(NSMutableArray *) createObjectsFromArray: (NSArray *) array withType: (DataSourceType) type {
    NSMutableArray * results = [NSMutableArray new];
    for (NSDictionary *jsonObject in array) {
        if (type == DataSourceTypeCountry) {
            Country *country = [[Country alloc] initWithDictionary:jsonObject];
            [results addObject:country];
        }
        if (type == DataSourceTypeCity) {
            City *city = [[City alloc] initWithDictionary:jsonObject];
            [results addObject:city];
        }
        if (type == DataSourceTypeAirport) {
            Airport *airport = [[Airport alloc] initWithDictionary:jsonObject];
            [results addObject:airport];
        }
    }
    return results;
}

-(void) loadData {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        NSArray *countriesJSON = [self arrayFromFileName:@"countries" ofType:@"json"];
        self->_countriesArray = [self createObjectsFromArray:countriesJSON withType:DataSourceTypeCountry];
        
        NSArray *citiesJSON = [self arrayFromFileName:@"cities" ofType:@"json"];
        self->_citiesArray = [self createObjectsFromArray:citiesJSON withType:DataSourceTypeCity];
        
        NSArray *airportsJSON = [self arrayFromFileName:@"airports" ofType:@"json"];
        self->_airportsArray = [self createObjectsFromArray:airportsJSON withType:DataSourceTypeAirport];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerLoadDataDidComplete object:nil];
        });
        NSLog(@"Complete load data");
    });
}

-(NSArray *) arrayFromFileName: (NSString *)fileName ofType: (NSString *) type  {
    NSArray *result = [NSArray new];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    result = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    return result;
}

- (NSArray *) countries {
    return _countriesArray;
}


- (NSArray *) cities {
    return _citiesArray;
}


- (NSArray *) airports {
    return _airportsArray;
}

- (City *)cityForIATA:(NSString *)iata {
    if (iata) {
            for (City *city in _citiesArray) {
                if ([city.code isEqualToString:iata]) {
                    return city;
                }
            }
    }
    return nil;
}

- (City *)cityForLocation:(CLLocation *)location {
    for (City *city in _citiesArray) {
        if (ceilf(city.coordinate.latitude) == ceilf(location.coordinate.latitude) && ceilf(city.coordinate.longitude) == ceilf(location.coordinate.longitude)) {
        return city;
        }
    }
    return nil;
}

@end
