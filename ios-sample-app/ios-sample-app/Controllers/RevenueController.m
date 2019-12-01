//
//  RevenueController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 19/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import "RevenueController.h"
#import "Singular.h"
#import "Utils.h"

@implementation RevenueController

- (IBAction)sendRevenueEvent:(id)sender {
    NSString* eventName = self.eventNameField.text;
    NSString* currency = self.currencyField.text;
    double revenue = [self getRevenue];
    
    if([Utils isEmptyOrNull:eventName]){
        [Utils displayMessage:@"Please enter a valid event name" withView:self];
        return;
    }
    
    if([Utils isEmptyOrNull:currency]){
        [Utils displayMessage:@"Please enter a valid currency" withView:self];
        return;
    }
    
    if(revenue <= 0){
        [Utils displayMessage:@"Revenue can't be zero or empty" withView:self];
        return;
    }
    
    // Reporting a simple revenue event to Singular
    [Singular customRevenue:eventName currency:currency amount:revenue];
    
    [Utils displayMessage:@"Revenue event sent" withView:self];
}

- (IBAction)sendRevenueEventWithArgs:(id)sender {
    NSString* eventName = self.eventNameField.text;
    NSString* currency = self.currencyField.text;
    double revenue = [self getRevenue];
    
    if([Utils isEmptyOrNull:eventName]){
        [Utils displayMessage:@"Please enter a valid event name" withView:self];
        return;
    }
    
    if([Utils isEmptyOrNull:currency]){
        [Utils displayMessage:@"Please enter a valid currency" withView:self];
        return;
    }
    
    if(revenue <= 0){
        [Utils displayMessage:@"Revenue must be a number greater than 0" withView:self];
        return;
    }
    
    // Reporting a simple revenue event with your custom attributes to pass with the event
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:@"value1" forKey:@"key1"];
    [args setObject:@"value2" forKey:@"key2"];
    
    [Singular customRevenue:eventName currency:currency amount:revenue withAttributes:args];
    [Utils displayMessage:@"Revenue event sent" withView:self];
}

- (double)getRevenue{
    if ([Utils isEmptyOrNull:self.revenueField.text]){
        return 0;
    }
    
    return [self.revenueField.text doubleValue];
}

@end
