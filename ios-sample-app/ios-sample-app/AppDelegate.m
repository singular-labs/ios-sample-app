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
#import "TabController.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize deeplinkData;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Starts a new session when the user opens the app if the session timeout has passed / opened using a Singular Link
    [Singular startSession:APIKEY withKey:SECRET
          andLaunchOptions:launchOptions
   withSingularLinkHandler:^(SingularLinkParams * params) {
        [self handleSingularLink:params];
    }];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {
    
    // Starts a new session when the user opens the app using a Singular Link while it was in the background
    [Singular startSession:APIKEY withKey:SECRET
           andUserActivity:userActivity
   withSingularLinkHandler:^(SingularLinkParams * params) {
        [self handleSingularLink:params];
    }];
    
    return YES;
}

- (void)handleSingularLink:(SingularLinkParams*)params{
    NSMutableDictionary* values = [[NSMutableDictionary alloc] init];
    
    [values setObject:[params getDeepLink] forKey:DEEPLINK];
    [values setObject:[params getPassthrough] forKey:PASSTHROUGH];
    [values setObject:[NSNumber numberWithBool:[params isDeferred]] forKey:IS_DEFERRED];
    
    self.deeplinkData = values;
    
    [self navigateToDeeplinkController];
}

-(void)navigateToDeeplinkController{
    
    // UI changes must run on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        TabController* tabBar = (TabController*)self.window.rootViewController;
    
        // Signal to the TabController the app opened using a Singular Link
        [tabBar openedWithDeeplink];
    });
}

@end

