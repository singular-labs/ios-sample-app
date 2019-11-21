//
//  MainNavigationController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 20/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import "NavigationController.h"
#import "AppDelegate.h"
#import "TabController.h"

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSDictionary* deeplinkData = appDelegate.deeplinkData;
    appDelegate.deeplinkData = nil;
    
    if(!deeplinkData){
        return;
    }
     
    TabController *tabController =
    [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabController"];
    tabController.deeplinkData = deeplinkData;
    
    [self setViewControllers:[NSArray arrayWithObject: tabController] animated: YES];
//
//    [self.window presentViewController:tabController animated:YES completion:nil];
}

@end
