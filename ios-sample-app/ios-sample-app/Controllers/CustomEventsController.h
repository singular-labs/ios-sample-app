//
//  CustomEventsController.h
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Updated by Jared Ornstead on 2021/11/07
//  Copyright © 2021 Singular Labs. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CustomEventsController : UIViewController

- (IBAction)sendEvent:(id)sender;

- (IBAction)sendEventWithArgs:(id)sender;

- (IBAction)sendEventsWithArgsWithDictionary:(id)sender;

@end
