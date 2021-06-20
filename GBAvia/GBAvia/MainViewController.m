//
//  MainViewController.m
//  GBAvia
//
//  Created by Nikita on 17.06.2021.
//

#import "MainViewController.h"
#import "DataManager.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataManager sharedInstance] loadData];
    self.view.backgroundColor = UIColor.cyanColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDidComplete) name:kDataManagerLoadDataDidComplete object:nil];
}


- (void) loadDidComplete {
    self.view.backgroundColor = UIColor.greenColor;
}




- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
