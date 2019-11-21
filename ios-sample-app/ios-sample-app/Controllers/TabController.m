//
//  MainTabController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 20/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import "TabController.h"
#import "DeeplinkController.h"

@implementation TabController

@synthesize deeplinkData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(deeplinkData){
        DeeplinkController* deeplinkController = [self.viewControllers objectAtIndex:3];
        deeplinkController.deeplinkData = deeplinkData;
        self.deeplinkData = nil;
        [self setSelectedIndex:3];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
