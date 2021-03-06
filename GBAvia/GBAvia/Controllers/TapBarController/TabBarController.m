//
//  TabBarController.m
//  GBAvia
//
//  Created by Nikita on 04.07.2021.
//

#import "TabBarController.h"
#import "MainViewController.h"
#import "MapViewController.h"
#import "TicketsTableViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.viewControllers = [self createViewControllers];
        self.tabBar.tintColor = [UIColor systemBlueColor];
    }
    return self;
}


- (NSArray<UIViewController*> *)createViewControllers {
    NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
    
    MainViewController *mainViewController = [[MainViewController alloc] init];
    mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage systemImageNamed:@"magnifyingglass.circle"] selectedImage:[UIImage systemImageNamed:@"magnifyingglass.circle.fill"]];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [controllers addObject:mainNavigationController];
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Price map" image:[UIImage systemImageNamed:@"map"] selectedImage:[UIImage systemImageNamed:@"map.fill"]];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    [controllers addObject:mapNavigationController];
    
    TicketsTableViewController *favoriteViewController = [[TicketsTableViewController alloc] initFavouriteTicketController];
    favoriteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: @"Favourite"
    image:[UIImage systemImageNamed:@"star"] selectedImage:[UIImage systemImageNamed:@"star.fill"]];
    UINavigationController *favoriteNavigationController = [[UINavigationController alloc] initWithRootViewController:favoriteViewController];
    [controllers addObject:favoriteNavigationController];
    return controllers;
}

@end
