//
//  RevenueController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Updated by Jared Ornstead on 2021/11/07
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import "RevenueController.h"
#import "Singular.h"
#import "Utils.h"

@implementation RevenueController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (IBAction)send_iapCompleteEvent:(id)sender {
    // Send a transaction event to Singular with the transaction receipt.
    
    //SKPaymentTransaction* transaction = ...;
    //[Singular iapComplete:transaction];
    [Utils displayMessage:@"iapComplete Event \nrequires SKPaymentTransaction" withView:self];
}

- (IBAction)send_iapCompleteWithNameEvent:(id)sender {
    // Send a transaction event to Singular with a custom name for the event
    
    //[Singular iapComplete:transaction withName:@"MyCustomRevenue"];
    [Utils displayMessage:@"iapCompleteWithName Event \nrequires SKPaymentTransaction" withView:self];
}

- (IBAction)sendRevenueEvent:(id)sender {
    // Settig the Event Name, Currency, and total revenue amount for the event
    NSString* currency = @"USD";
    double revenue = 1.99;
    
    // Reporting a simple revenue event to Singular will send __iap__ revenue event with no attributes
    [Singular revenue:currency amount:revenue];
    [Utils displayMessage:@"IAP Revenue Event sent" withView:self];
}

- (IBAction)sendRevenueWithProductDetailsEvent:(id)sender {
    // Reporting a simple revenue event to Singular with product details
    NSString* currency = @"USD";
    double revenue = 5.00;
    NSString* productSKU = @"SKU1928375";
    NSString* productName = @"Reservation Fee";
    NSString* productCategory = @"Fee";
    int productQuantity = 1;
    double productPrice = 5.00;
    
    // Reporting a simple revenue event to Singular will send __iap__ revenue event with no attributes
    [Singular revenue:currency amount:revenue productSKU:productSKU productName:productName productCategory:productCategory productQuantity:productQuantity productPrice:productPrice];
    [Utils displayMessage:@"Revenue Event\nwith product details\nsent" withView:self];
}

- (IBAction)sendCustomRevenueEvent:(id)sender {
    // Setting the Event Name, Currency, and total revenue amount for the event
    NSString* eventName = @"CustomRevenue";
    NSString* currency = @"USD";
    double revenue = 1.99;
    
    // Reporting a simple revenue event to Singular
    [Singular customRevenue:eventName currency:currency amount:revenue];
    [Utils displayMessage:@"CustomRevenue Event sent" withView:self];
}

- (IBAction)sendCustomRevenueWithProductDetailsEvent:(id)sender {
    // Reporting a simple revenue event to Singular with product details
    NSString* eventName = @"MyCustomRevenue";
    NSString* currency = @"USD";
    double revenue = 5.00;
    NSString* productSKU = @"SKU1928375";
    NSString* productName = @"Reservation Fee";
    NSString* productCategory = @"Fee";
    int productQuantity = 1;
    double productPrice = 5.00;
    
    // Reporting a Custom revenue event to Singular with Product Details
    [Singular customRevenue:eventName currency:currency amount:revenue productSKU:productSKU productName:productName productCategory:productCategory productQuantity:productQuantity productPrice:productPrice];
    
    [Utils displayMessage:@"Custom Revenue Event\nwith product details\nsent" withView:self];
}

- (IBAction)sendRevenueEventWithArgs:(id)sender {
    // Settig the Event Name, Currency, and total revenue amount for the event
    NSString* eventName = @"CustomRevenueWithArgs";
    NSString* currency = @"USD";
    double revenue = 19.99;
    
    // Adding your custom revenue arguments into a dictionary
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:@"value1" forKey:@"key1"];
    [args setObject:@"value2" forKey:@"key2"];
    [args setObject:@"value3" forKey:@"key3"];
    
    [Singular customRevenue:eventName currency:currency amount:revenue withAttributes:args];
    [Utils displayMessage:@"CustomRevenueWithArgs event sent" withView:self];
}


@end
