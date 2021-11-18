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

#import <AppTrackingTransparency/ATTrackingManager.h>
#import <AdSupport/ASIdentifierManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize deeplinkData;

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Request user consent to use the Advertising Identifier (idfa)
    [self requestTrackingAuthorization];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"SDK Version: %@", Singular.version);
    
    // If your app uses scenes and you want to support Singular Links, please refer to the documentation here:
    // https://support.singular.net/hc/en-us/articles/360038341692
    
    // Starts a new session when the user opens the app if the session timeout has passed / opened using a Singular Link
    SingularConfig *config = [self getConfig];
    config.launchOptions = launchOptions;
    [Singular start:config];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {
    
    // Starts a new session when the user opens the app using a Singular Link while it was in the background
    SingularConfig *config = [self getConfig];
    config.userActivity = userActivity;
    [Singular start:config];
        
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    // Starts a new session when the user opens the app using a Non Singular Link, like a traditional App scheme.
    // This code block will provide the Non Singular link value to the Singular Deeplink Handler
    SingularConfig *config = [self getConfig];
    [Singular start:config];
            
    // Replace this code with your own logic to handle Non Singular Deeplinks
    NSLog(@"Handle URL: %@", url);
    NSString *deeplink = url.absoluteString;
    if (deeplink == (id)[NSNull null] || deeplink.length == 0 ) deeplink = @"";
    NSMutableDictionary* values = [[NSMutableDictionary alloc] init];
    [values setObject:deeplink forKey:DEEPLINK];
    self.deeplinkData = values;
    [self navigateToDeeplinkController];
    
    return YES;
}

- (SingularConfig *)getConfig {
    // Singular Configuration
        
    // Optional: Modifying the Session Timeout
    // By default, if the app runs in the background for 60 seconds or more before returning
    // to the foreground, the SDK registers a new session.
    //[Singular setSessionTimeout:60];
    
    // Optional: Setting the Custom User ID
    // If you already know the user ID when the app opens, set it before initializing the
    // Singular SDK. This way, Singular will have the user ID from the very first session.
    // Otherwise, set the user ID during Authentication.
    //[Singular setCustomUserId:@"a_user_id"];
    
    // Invoke the Config Object
    SingularConfig *config = [[SingularConfig alloc] initWithApiKey:APIKEY andSecret:SECRET];
    
    // Initialize the Singular Links Handler and Callback to retreive the deeplink or deferred
    // deeplink values.
    config.singularLinksHandler = ^(SingularLinkParams * params) {
        [self handleSingularLink:params];
    };
        
    // Enable skAdNetwork support for iOS14+ tracking. Singular will call
    // registerAppForAdNetworkAttribution for you.
    config.skAdNetworkEnabled = YES;
    
    // Optional: To enable manual conversion value updates, set this to YES
    // IMPORTANT: The default is NO, allowing Singular to manage your Conversion Values.
    //config.manualSkanConversionManagement = YES;
    
    // Optional: Receive a callback whenever the Conversion Value is updated
    config.conversionValueUpdatedCallback = ^(NSInteger newConversionValue) {
        NSLog(@"Conversion Value Callback: %lu", (unsigned long)newConversionValue);
    };
    
    // Optional: To delay the firing of a user session, you can initialize the Singular SDK
    // with the waitForTrackingAuthorizationWithTimeoutInterval. Singular will then start the
    // attribution process, taking advantage of the IDFA if it is available or using probabilistic
    // attribution if the IDFA is not available. Delay sending events for up to 3 minutes,
    // or until Tracking is Authorized (only on iOS 14)
    config.waitForTrackingAuthorizationWithTimeoutInterval = 300;
    
    // Optional: Setting Global Properties through SingularConfig
    // You can define up to 5 global properties.
    // They persist between app runs (with the latest value you gave them) until you unset them
    // or the user uninstalls the app.
    // Each property name and value can be up to 200 characters long. If you pass a longer property
    // name or value, it will be truncated to 200 characters.
    //
    // Note that since global properties and their values persist between app runs, the property
    // that you are setting may already be set to a different value. Use the overrideExisting
    // parameter to tell the SDK whether to override an existing property with the new value or not.
    [config setGlobalProperty:@"example_key" withValue:@"example_value" overrideExisting:YES];
    
    return config;
}

// This function is used to display the ATT Pop up for consent. It is assumed that your App is already managing ATT.
- (void)requestTrackingAuthorization {
    if (@available(iOS 14, *)) {
        NSLog(@"Requesting ATT Consent");
        // call requestTrackingAuthorizationWithCompletionHandler from ATTrackingManager to start the user consent process
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status){
            // your authorization handler here
            // note: the Singular SDK will automatically detect if authorization has been given and initialize itself
        }];
    }
}

// This is function will parse the parameters from a Singular Link or from the Response of
// the first session to provide the deeplink, deferred deeplink, and passthrough values.
- (void)handleSingularLink:(SingularLinkParams*)params{
    NSLog(@"\n**** - handleSingularLink - ****\n");
    NSString* deeplink = [params getDeepLink];
    NSString* passthrough = [params getPassthrough];
    BOOL isDeferredDeeplink = [params isDeferred];
    
    // Handle the Deeplink and Passthorugh Values
    if (deeplink == (id)[NSNull null] || deeplink.length == 0 ) deeplink = @"";
    if (passthrough == (id)[NSNull null] || passthrough.length == 0 ) passthrough = @"";
    NSLog(@"Deeplink: %@", deeplink);
    NSLog(@"Passthrough: %@", passthrough);
    
    NSMutableDictionary* values = [[NSMutableDictionary alloc] init];
    [values setObject:deeplink forKey:DEEPLINK];
    [values setObject:passthrough forKey:PASSTHROUGH];
    [values setObject:[NSNumber numberWithBool:isDeferredDeeplink] forKey:IS_DEFERRED];
    self.deeplinkData = values;
    [self navigateToDeeplinkController];
}

// This function opens the deeplink view controller to display the provided deeplink data
-(void)navigateToDeeplinkController{
    // UI changes must run on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        TabController* tabBar = (TabController*)self.window.rootViewController;
        // Signal to the TabController the app opened using a Singular Link
        [tabBar openedWithDeeplink];
    });
}

@end

