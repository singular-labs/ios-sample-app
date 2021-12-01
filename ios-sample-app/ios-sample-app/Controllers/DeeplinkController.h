//
//  DeeplinkController.h
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 20/11/2019.
//  Updated by Jared Ornstead on 2021/11/19
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeeplinkController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *deeplinkField;
@property (weak, nonatomic) IBOutlet UILabel *passthroughField;
@property (weak, nonatomic) IBOutlet UILabel *isDeferredField;

@end
