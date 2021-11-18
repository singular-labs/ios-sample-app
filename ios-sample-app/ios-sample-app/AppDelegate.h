//
//  AppDelegate.h
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSDictionary* deeplinkData;
    NSString* att_state;
    NSString* s_idfa;
    NSString* s_idfv;
    NSString* sharedMessage;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSDictionary* deeplinkData;
@property (nonatomic, retain) NSString* att_state;
@property (nonatomic, retain) NSString* s_idfa;
@property (nonatomic, retain) NSString* s_idfv;
@property (nonatomic, retain) NSString* sharedMessage;

@end

