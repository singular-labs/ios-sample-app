//
//  IdentifyController.h
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 01/12/2019.
//  Updated by Jared Ornstead on 2021/11/19
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdentityController : UIViewController

@property (weak, nonatomic) NSString *custom_user_id;
@property (weak, nonatomic) NSString *att_state;
@property (weak, nonatomic) NSString *s_idfa;
@property (weak, nonatomic) NSString *s_idfv;
@property (weak, nonatomic) NSString *shareMessage;

@property (weak, nonatomic) IBOutlet UITextField *customUserIdField;
@property (weak, nonatomic) IBOutlet UILabel *idfa_value;
@property (weak, nonatomic) IBOutlet UILabel *idfv_value;
@property (weak, nonatomic) IBOutlet UILabel *att_value;

@property (weak, nonatomic) IBOutlet UISwitch *gdpr;
@property (weak, nonatomic) IBOutlet UISwitch *limited_data_sharing;
@property (weak, nonatomic) IBOutlet UISwitch *ccpa;
@property (weak, nonatomic) IBOutlet UIButton *share;


- (IBAction)gdpr:(UISwitch *)sender;
- (IBAction)limited_data_sharing:(UISwitch *)sender;
- (IBAction)ccpa:(UISwitch *)sender;

- (IBAction)shareText:(id)sender;

- (void)presentActivityController:(UIActivityViewController *)shareController;

@end
