//
//  DataManager.h
//  GBAvia
//
//  Created by Nikita on 20.06.2021.
//

#import <Foundation/Foundation.h>
#import "Country.h"
#import "City.h"
#import "Airport.h"

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

NS_ASSUME_NONNULL_BEGIN

typedef enum DataSourceType{
    DataSourceTypeCountry,
    DataSourceTypeCity,
    DataSourceTypeAirport
} DataSourceType;

typedef struct SearchRequest {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destination;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;

@interface DataManager : NSObject

@property(nonatomic, strong, readonly) NSArray *countries;
@property(nonatomic, strong, readonly) NSArray *cities;
@property(nonatomic, strong, readonly) NSArray *airports;

+(instancetype) sharedInstance;

-(void) loadData;

@end

NS_ASSUME_NONNULL_END
