//
//  TabBarController.m
//  GBAvia
//
//  Created by Nikita on 04.07.2021.
//

#import "TabBarController.h"
#import "MainViewController.h"
#import "MapViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype) init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.viewControllers = [self createViewControllers];
        self.tabBar.tintColor = UIColor.blackColor;
    }
    return self;
}

- (NSArray<UIViewController*> *) createViewControllers {
    NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
    MainViewController *mainViewController = [[MainViewController alloc] init];
    mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:@"search" selectedImage:@"search_selected"];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [controllers addObject:mainNavigationController];
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map" image:@"map" selectedImage:@"map_selected"];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    [controllers addObject: mapNavigationController];
    
    return controllers;
}

@end