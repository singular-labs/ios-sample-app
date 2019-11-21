//
//  AppDelegate.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "Singular.h"
#import "Utils.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize deeplinkData;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [Singular startSession:[Utils getApiKey] withKey:[Utils getSecret]
          andLaunchOptions:launchOptions
   withSingularLinkHandler:^(SingularLinkParams * params) {
        [self handleSingularLink:params];
    }];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {
    
    [Singular startSession:[Utils getApiKey] withKey:[Utils getSecret]
           andUserActivity:userActivity
   withSingularLinkHandler:^(SingularLinkParams * params) {
        [self handleSingularLink:params];
    }];
    
    return YES;
}

- (void)handleSingularLink:(SingularLinkParams*)params{
    NSMutableDictionary* values = [[NSMutableDictionary alloc] init];
    
    [values setObject:[params getDeepLink] forKey:@"deeplink"];
    [values setObject:[params getPassthrough] forKey:@"passthrough"];
    [values setObject:[NSNumber numberWithBool:[params isDeferred]] forKey:@"is_deferred"];
    
    self.deeplinkData = values;
}

@end

