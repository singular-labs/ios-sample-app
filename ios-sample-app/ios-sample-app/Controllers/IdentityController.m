//
//  IdentifyController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Updated by Jared Ornstead on 2021/11/07
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

- (void)viewDidLoad{
    [super viewDidLoad];
    [self requestTrackingAuthorization];
}

- (IBAction)gdpr:(UISwitch *)sender {
    if (self.gdpr.isOn){
        [Singular event:@"GDPR_CCPA_OptOut"];
        [Singular stopAllTracking];
        NSLog(@"GDPR_CCPA Tracking OptOut - Tracking Stopped");
    } else {
        //[Singular trackingOptIn];
        if ([Singular isAllTrackingStopped] == TRUE){
            [Singular resumeAllTracking];
            [Singular event:@"GDPR_CCPA_OptIn"];
            NSLog(@"GDPR_CCPA Tracking OptIn");
        }
    }
}

- (IBAction)limited_data_sharing:(UISwitch *)sender {
    if (self.limited_data_sharing.isOn){
        [Singular limitDataSharing:YES];
        [Singular event:@"LimitedDataSharing_OptIn"];
        NSLog(@"Limited Data Sharing OptIn");
    } else {
        [Singular limitDataSharing:NO];
        [Singular event:@"LimitedDataSharing_OptOut"];
        NSLog(@"Limited Data Sharing OptOut");
        }
}

- (IBAction)ccpa:(UISwitch *)sender {
    if (self.ccpa.isOn){
        [Singular event:@"CCPA_AgeUnder13_OptOut"];
        [Singular stopAllTracking];
        NSLog(@"CCPA OptOut SDK Tracking Stopped");
    } else {
        [Singular resumeAllTracking];
        [Singular event:@"CCPA_Disabled"];
        NSLog(@"CCPA Disabled SDK Tracking Started");
        }
}

- (IBAction)shareText:(id)sender {
    // create a share message
    AppDelegate *DataDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString* sharedText = DataDelegate.sharedMessage;
    NSArray *items = @[ sharedText ];
    
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


- (IBAction)setCustomUserId:(id)sender {
    self.custom_user_id = self.customUserIdField.text;
    
    if([Utils isEmptyOrNull:self.custom_user_id]){
        [Utils displayMessage:@"Please enter a valid Custom User Id" withView:self];
    }
    
    if ([self.custom_user_id length] > 0){
        // Once set, the Custom User Id will persist between runs until `[Singular unsetCustomUserId]` is called.
        // This can also be called before SDK init if you want the first session to include the Custom User Id.
        [Singular setCustomUserId:self.custom_user_id];
        [Singular event:@"SignIn_Success"];
        [Utils displayMessage:[[NSString alloc] initWithFormat:@"SignIn Success!\nwith Custom User Id set to: %@", self.custom_user_id] withView:self];
    }
}

- (IBAction)unsetCustomUserId:(id)sender {
    if ([self.custom_user_id length] > 0){
        // Once set, the Custom User Id will persist between runs until `[Singular unsetCustomUserId]` is called.
        // This can also be called before SDK init if you want the first session to include the Custom User Id.
        [Singular unsetCustomUserId];
        [Singular event:@"SignOut"];
        [Utils displayMessage:@"SignOut\nUserID unassociated with device" withView:self];
    } else {
        [Utils displayMessage:[[NSString alloc] initWithFormat:@"User not Signed In"] withView:self];
    }
    
}

- (void)requestTrackingAuthorization {
    AppDelegate *DataDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // call requestTrackingAuthorizationWithCompletionHandler from ATTrackingManager to start the user consent process
    if (@available(iOS 14, *)) {
        NSLog(@"\n**** - iOS 14 requestTrackingAuthorization - ****\n");
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
            NSLog(@"IDFA: %@", self.s_idfa);
            NSLog(@"IDFV: %@", self.s_idfv);
            NSLog(@"ATT Status: %lu", (unsigned long)status);
            //NSLog(@"Limited Ad Tracking (pre iOS14): %d", [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]);
            [self.idfa_value setText:self.s_idfa];
            [self.idfv_value setText:self.s_idfv];
            [self.att_value setText:self.att_state];
            DataDelegate.sharedMessage = [NSString stringWithFormat:@"Sample App Device Info:\n\nAdvertising ID (IDFA): %@ \n\nIDFV: %@",self.s_idfa,self.s_idfv];
          }];
    } else {
        [self.idfa_value setText:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
        [self.idfv_value setText:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
        [self.att_value setText:@"(0) Not Determined < iOS14"];
    }
}



@end
