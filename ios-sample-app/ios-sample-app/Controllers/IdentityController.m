//
//  IdentifyController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 01/12/2019.
//  Updated by Jared Ornstead on 2021/11/19
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import "IdentityController.h"
#import "Singular.h"
#import "Utils.h"
#import "AppDelegate.h"
#import <AppTrackingTransparency/ATTrackingManager.h>
#import <AdSupport/ASIdentifierManager.h>

@interface IdentityController ()

@end

@implementation IdentityController
NSString* shareMessage;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestTrackingAuthorization];
}

- (IBAction)gdpr:(UISwitch *)sender {
    if (self.gdpr.isOn){
        [Singular event:@"GDPR_CCPA_OptOut"];
        [Singular stopAllTracking];
        
        //Logging for testing
        NSLog(@"GDPR_CCPA Tracking OptOut - Tracking Stopped");
        [Utils displayMessage:[[NSString alloc] initWithFormat:@"GDPR_CCPA Tracking OptOut - Tracking Stopped"] withView:self];
    } else {
        //[Singular trackingOptIn];
        if ([Singular isAllTrackingStopped] == TRUE){
            [Singular resumeAllTracking];
            [Singular event:@"GDPR_CCPA_OptIn"];
            
            //Logging for testing
            NSLog(@"GDPR_CCPA Tracking OptIn - Tracking Started");
            [Utils displayMessage:[[NSString alloc] initWithFormat:@"GDPR_CCPA Tracking OptIn - Tracking Started"] withView:self];
        }
    }
}

- (IBAction)limited_data_sharing:(UISwitch *)sender {
    if (self.limited_data_sharing.isOn){
        [Singular limitDataSharing:YES];
        [Singular event:@"LimitedDataSharing_OptIn"];
        
        //Logging for testing
        NSLog(@"Limited Data Sharing OptIn - Tracking remains enabled but limited data will not be shared with Networks");
        [Utils displayMessage:[[NSString alloc] initWithFormat:@"Limited Data Sharing OptIn - Tracking remains enabled but limited data will not be shared with Networks"] withView:self];
    } else {
        [Singular limitDataSharing:NO];
        [Singular event:@"LimitedDataSharing_OptOut"];
        
        //Logging for testing
        NSLog(@"Limited Data Sharing OptOut - All Data will be shared with networks");
        [Utils displayMessage:[[NSString alloc] initWithFormat:@"Limited Data Sharing OptOut - All Data will be shared with networks"] withView:self];
        }
}

- (IBAction)ccpa:(UISwitch *)sender {
    if (self.ccpa.isOn){
        [Singular event:@"CCPA_AgeUnder13_OptOut"];
        [Singular stopAllTracking];
        
        //Logging for testing
        NSLog(@"CCPA OptOut - Age is below 13 - Tracking Stopped");
        [Utils displayMessage:[[NSString alloc] initWithFormat:@"CCPA OptOut - Age is below 13 - Tracking Stopped"] withView:self];
    } else {
        [Singular resumeAllTracking];
        [Singular event:@"CCPA_Disabled"];
        
        //Logging for testing
        NSLog(@"CCPA OptOut Disabled - Tracking Started");
        [Utils displayMessage:[[NSString alloc] initWithFormat:@"CCPA OptOut Disabled - Tracking Started"] withView:self];
        }
}

- (IBAction)setCustomUserId:(id)sender {
    NSString* customUserId = self.customUserIdField.text;
    
    if([Utils isEmptyOrNull:customUserId]){
        [Utils displayMessage:@"Please enter a valid Custom User Id" withView:self];
    } else {
        // Once set, the Custom User Id will persist between runs until `[Singular unsetCustomUserId]` is called.
        // This can also be called before SDK init if you want the first session to include the Custom User Id.
        [Singular setCustomUserId:customUserId];
        
        // Logging for Testing
        NSLog(@"Custom User ID Set %@", customUserId);
        [Utils displayMessage:[[NSString alloc] initWithFormat:@"Custom User Id set to: %@", customUserId] withView:self];
    }
}

- (IBAction)unsetCustomUserId:(id)sender {
    [Singular unsetCustomUserId];
    
    // Logging for Testing
    NSLog(@"Custom User ID Unset");
    [Utils displayMessage:@"Custom User Id unset" withView:self];
}

- (void)requestTrackingAuthorization {
    // call requestTrackingAuthorizationWithCompletionHandler from ATTrackingManager to start the user consent process
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // Tracking authorization completed. Start loading ads here.
            switch (status) {
                case 0: self.att_state = @"(0) Not Determined";
                case 1: self.att_state = @"(1) Restricted";
                case 2: self.att_state = @"(2) Denied";
                case 3: self.att_state = @"(3) Authorized";
                }
            self.s_idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            self.s_idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            [self.idfa_value setText:self.s_idfa];
            [self.idfv_value setText:self.s_idfv];
            [self.att_value setText:self.att_state];
            shareMessage = [NSString stringWithFormat:@"Sample App Device Info:\nATT Status: %@ \nAdvertising IDs\n(IDFA): %@ \n(IDFV): %@ \n",self.att_state,self.s_idfa,self.s_idfv];
          }];
    } else {
        [self.idfa_value setText:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
        [self.idfv_value setText:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
        [self.att_value setText:@"(0) Not Determined < iOS14"];
        shareMessage = [NSString stringWithFormat:@"Sample App Device Info:\nATT Status: %@ \nAdvertising IDs\n(IDFA): %@ \n(IDFV): %@ \n",self.att_state,self.s_idfa,self.s_idfv];
    }
    
    // Logging for Testing
    NSLog(@"ATT Status: %@", self.att_value);
    NSLog(@"IDFA: %@", self.s_idfa);
    NSLog(@"IDFV: %@", self.s_idfv);
}

- (IBAction)shareText:(id)sender {
    // create a share message
    NSArray *items = @[ shareMessage ];
        
    // build an activity view controller and present it
    UIActivityViewController *shareController = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    [self presentActivityController:shareController];
}

- (void)presentActivityController:(UIActivityViewController *)shareController {
    // for iPad: make the presentation a Popover
    shareController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:shareController animated:YES completion:nil];

    UIPopoverPresentationController *popController = [shareController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;

    // access the completion handler
    shareController.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {

            // user shared an item
            NSLog(@"We used activity type%@", activityType);

        } else {

            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }

        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}

@end
