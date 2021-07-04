//
//  MapViewController.h
//  GBAvia
//
//  Created by Nikita on 30.06.2021.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController
- (instancetype)initWithLocation:(CLLocation *)location;
@end

NS_ASSUME_NONNULL_END
