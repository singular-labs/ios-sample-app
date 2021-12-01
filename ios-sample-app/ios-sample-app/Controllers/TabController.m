//
//  MainTabController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 20/11/2019.
//  Updated by Jared Ornstead on 2021/11/19
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import "TabController.h"

@implementation TabController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)openedWithDeeplink{
    // Display the DeeplinkController
    [self setSelectedIndex:3];
}

// Minimizes the keyboard when it's not needed
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
