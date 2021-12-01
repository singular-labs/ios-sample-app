//
//  RevenueController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 19/11/2019.
//  Updated by Jared Ornstead on 2021/11/19
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import "RevenueController.h"
#import "Singular.h"
#import "Utils.h"

@implementation RevenueController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    pickerData = @[@"EUR",@"GBP",@"ILS",@"INR",@"JPY",@"KRW",@"USD"];
}

- (IBAction)sendRevenueEvent:(id)sender {
    NSString* eventName = self.eventNameField.text;
    NSString* currency = self.currencyField.text;
    double revenue = [self getRevenue];
    
    if([Utils isEmptyOrNull:eventName]){
        [Utils displayMessage:@"Please enter a valid event name" withView:self];
    } else {
        if(eventName.length <= 32){
            if([Utils isEmptyOrNull:currency]){
                [Utils displayMessage:@"Please enter a valid currency" withView:self];
            } else {
                if(revenue <= 0){
                    [Utils displayMessage:@"Revenue can't be zero or empty" withView:self];
                } else {
                    // Reporting a simple Revenue Event to Singular
                    [Singular customRevenue:eventName currency:currency amount:revenue];
                    
                    // Logging for Testing
                    NSLog(@"Revenue Event Sent: %@ %@ %f", eventName, currency, revenue);
                    [Utils displayMessage:@"Revenue event sent" withView:self];
                }
            }
        } else {
            [Utils displayMessage:@"Event name is too long. Event name length limit is 32 characters." withView:self];
        }
    }
    return;
}

- (IBAction)sendRevenueEventWithArgs:(id)sender {
    NSString* eventName = self.eventNameField.text;
    NSString* currency = self.currencyField.text;
    double revenue = [self getRevenue];
    
    if([Utils isEmptyOrNull:eventName]){
        [Utils displayMessage:@"Please enter a valid event name" withView:self];
    } else {
        if(eventName.length <= 32){
            if([Utils isEmptyOrNull:currency]){
                [Utils displayMessage:@"Please enter a valid currency" withView:self];
            } else {
                if(revenue <= 0){
                    [Utils displayMessage:@"Revenue can't be zero or empty" withView:self];
                } else {
                    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
                    [args setObject:@"value1" forKey:@"key1"];
                    [args setObject:@"value2" forKey:@"key2"];
                    
                    // Reporting a Custom Revenue Event to Singular with Arguments in a Dictionary
                    [Singular customRevenue:eventName currency:currency amount:revenue withAttributes:args];
                    
                    // Logging for Testing
                    NSLog(@"Revenue Event Sent: %@ %@ %f %@", eventName, currency, revenue, args);
                    [Utils displayMessage:@"Revenue event sent" withView:self];
                }
            }
        } else {
            [Utils displayMessage:@"Event name is too long. Event name length limit is 32 characters." withView:self];
        }
    }
    return;
}

- (IBAction)sendRevenueEventWithProductDetails:(id)sender {
    NSString* eventName = self.eventNameField.text;
    NSString* currency = self.currencyField.text;
    double revenue = [self getRevenue];
    NSString* productSKU = @"SKU1928375";
    NSString* productName = @"Reservation Fee";
    NSString* productCategory = @"Fee";
    int productQuantity = 1;
    
    if([Utils isEmptyOrNull:eventName]){
        [Utils displayMessage:@"Please enter a valid event name" withView:self];
    } else {
        if(eventName.length <= 32){
            if([Utils isEmptyOrNull:currency]){
                [Utils displayMessage:@"Please enter a valid currency" withView:self];
            } else {
                if(revenue <= 0){
                    [Utils displayMessage:@"Revenue can't be zero or empty" withView:self];
                } else {
                    // Reporting a Custom Revenue Event to Singular with Product Details
                    [Singular customRevenue:eventName currency:currency amount:revenue productSKU:productSKU productName:productName productCategory:productCategory productQuantity:productQuantity productPrice:revenue];
                    
                    // Logging for Testing
                    NSLog(@"Revenue Event Sent: %@ %@ %f \nproductSKU: %@ productName: %@ productCategory: %@ productQuantity: %i productPrice: %f", eventName, currency, revenue, productSKU, productName, productCategory, productQuantity, revenue);
                    [Utils displayMessage:@"Custom Revenue Event\nwith product details\nsent" withView:self];
                }
            }
        } else {
            [Utils displayMessage:@"Event name is too long. Event name length limit is 32 characters." withView:self];
        }
    }
    return;
}


- (double)getRevenue{
    if ([Utils isEmptyOrNull:self.revenueField.text]){
        return 0;
    }
    
    return [self.revenueField.text doubleValue];
}

// Currency Picker logic
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return pickerData[row];
}

- (IBAction)showCurrencyPicker:(id)sender {
    self.currencyPicker = [[UIPickerView alloc] init];
    self.currencyPicker.dataSource = self;
    self.currencyPicker.delegate = self;
    
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.translucent = YES;
    [toolbar sizeToFit];
    
    // Aligns the done button to the right
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    self.currencyField.inputView = self.currencyPicker;
    self.currencyField.inputAccessoryView = toolbar;
}

-(void)doneClicked:(id)sender{
    [self.currencyField resignFirstResponder];
    NSString* currency = [self pickerView:self.currencyPicker titleForRow:[self.currencyPicker selectedRowInComponent:0] forComponent:0];
    [self.currencyField setText:currency];
}

@end
