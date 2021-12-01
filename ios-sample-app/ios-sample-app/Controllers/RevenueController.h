//
//  RevenueController.h
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 19/11/2019.
//  Updated by Jared Ornstead on 2021/11/19
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevenueController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray* pickerData;
}

@property (strong, nonatomic) IBOutlet UITextField *eventNameField;
@property (strong, nonatomic) IBOutlet UITextField *currencyField;
@property (strong, nonatomic) IBOutlet UITextField *revenueField;
@property (strong, nonatomic) IBOutlet UIPickerView *currencyPicker;

@end
