//
//  CustomEventsController.h
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 19/11/2019.
//  Updated by Jared Ornstead on 2021/11/19
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomEventsController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *eventNameField;
- (IBAction)sendEvent:(id)sender;
- (IBAction)sendEventsWithAttributes:(id)sender;

@end
