//
//  AppDelegate.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Updated by Jared Ornstead on 2021/11/07
//  Copyright © 2021 Singular Labs. All rights reserved.
//
/*
 This sample app illustrates working examples of a Singular implementation in Obj-C.
 Console Logging and Event have been configured to out activity to the Singular SDK Console.
 To build this App you must:
    1. update your SDK Key and Secret in the Constants File.
    2. update your Associated Domain capabilitiy per: https://support.singular.net/hc/en-us/articles/360031371451-Singular-Links-Prerequisites?navigation_side_bar=true
    3. update your URL scheme in the Target App > Info > URL Types
    4. update the bundle identifier in the Target App > General tab to something unqiue
    5. Add the Push Notification capability per: https://support.singular.net/hc/en-us/articles/360000269811-Uninstall-Tracking-APNS-Apple-Push-Notification-Service
 
 You will find a View Controller illustrating each method to invoke Events and Revenue events. Examples
 are provided where possible.
 
 The Identity Controller will demonstrate the methods for Data Privacy and allows you to share
 your identifiers or test purposes.
*/

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "Singular.h"
#import "Utils.h"
#import "TabController.h"
#import "Constants.h"
#import <AdServices/AdServices.h>

#import <UserNotifications/UserNotifications.h>
#import <AppTrackingTransparency/ATTrackingManager.h>
#import <AdSupport/ASIdentifierManager.h>

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()
@end

@implementation AppDelegate

@synthesize deeplinkData;
@synthesize att_state;
@synthesize s_idfa;
@synthesize s_idfv;
@synthesize sharedMessage;

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
    
    // This code block will Register for Push Notifications to obtain Token for Uninstall Tracking.
    NSError *error = nil;
    Class AAAttributionClass = NSClassFromString(@"AAAttribution");
    if (AAAttributionClass) {
        NSString *attributionToken = [AAAttributionClass attributionTokenWithError:&error];
        if (!error && attributionToken) {
            NSLog(@"AdServices attribution_token: %@", attributionToken);
        }
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
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
    
    // Replace this code with your own logic to handle Non Singular Links
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
        [tabBar openedWithDeeplink];
    });
}

// This function is used to display the ATT Pop up for consent. It is assumed that your App is already managing ATT.
- (void)requestTrackingAuthorization {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // Tracking authorization completed. Start loading ads here.
            NSLog(@"ATT Requested");
          }];
    }
}

// Handle remote notification registration.
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    // This is used to forward the token to Singular for Uninstall Tracking
    [Singular registerDeviceTokenForUninstall:devToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    // The token is not currently available.
    NSLog(@"Remote notification support is unavailable due to error: %@", err);
    //[self disableRemoteNotificationFeatures];
}

@end
