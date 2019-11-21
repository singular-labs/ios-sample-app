//
//  DeeplinkController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 20/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import "DeeplinkController.h"

@implementation DeeplinkController

@synthesize deeplinkData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!deeplinkData){
        return;
    }
    
    [self.deeplinkField setText:[deeplinkData objectForKey:@"deeplink"]];
    [self.passthroughField setText:[deeplinkData objectForKey:@"passthrough"]];
    [self.isDeferredField setText:[deeplinkData objectForKey:@"is_deferred"] ? @"Yes" : @"No"];
}

@end
