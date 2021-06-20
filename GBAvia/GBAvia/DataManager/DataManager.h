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


@interface DataManager : NSObject

@property(nonatomic, strong, readonly) NSArray *country;
@property(nonatomic, strong, readonly) NSArray *city;
@property(nonatomic, strong, readonly) NSArray *airport;

+(instancetype) sharedInstance;

-(void) loadData;

@end

NS_ASSUME_NONNULL_END
