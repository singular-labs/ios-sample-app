//
//  RevenueController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 19/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import "RevenueController.h"
#import "Singular.h"

@implementation RevenueController

- (IBAction)sendRevenueEvent:(id)sender {
    NSString* eventName = [self getEventName];
    NSString* currency = [self getCurrency];
    double revenue = [self getRevenue];
    
    if(!eventName || !currency || revenue <= 0){
        return;
    }
    
    [Singular customRevenue:eventName currency:currency amount:revenue];
}

- (IBAction)sendRevenueEventWithArgs:(id)sender {
    NSString* eventName = [self getEventName];
    NSString* currency = [self getCurrency];
    double revenue = [self getRevenue];
    
    if(!eventName || !currency || revenue <= 0){
        return;
    }
    
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:@"value1" forKey:@"key1"];
    [args setObject:@"value2" forKey:@"key2"];
    
    [Singular customRevenue:eventName currency:currency amount:revenue withAttributes:args];
}

- (NSString*)getEventName{
    if (!self.eventNameField.text || self.eventNameField.text.length == 0){
        return nil;
    }
    
    return self.eventNameField.text;
}

- (NSString*)getCurrency{
    if (!self.currencyField.text || self.currencyField.text.length == 0){
        return nil;
    }
    
    return self.currencyField.text;
}

- (double)getRevenue{
    if (!self.revenueField.text || self.revenueField.text.length == 0){
        return 0;
    }
    
    return [self.revenueField.text doubleValue];
}

@end
