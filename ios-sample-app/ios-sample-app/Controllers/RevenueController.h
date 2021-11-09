//
//  RevenueController.h
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Updated by Jared Ornstead on 2021/11/07
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevenueController : UIViewController

- (IBAction)send_iapCompleteEvent:(id)sender;

- (IBAction)send_iapCompleteWithNameEvent:(id)sender;

- (IBAction)sendRevenueEvent:(id)sender;

- (IBAction)sendRevenueWithProductDetailsEvent:(id)sender;

- (IBAction)sendCustomRevenueEvent:(id)sender;

- (IBAction)sendCustomRevenueWithProductDetailsEvent:(id)sender;

- (IBAction)sendRevenueEventWithArgs:(id)sender;

@end
