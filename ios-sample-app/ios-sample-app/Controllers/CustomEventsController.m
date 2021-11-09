//
//  CustomEventsController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Updated by Jared Ornstead on 2021/11/07
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import "CustomEventsController.h"
#import "Singular.h"
#import "Utils.h"

@implementation CustomEventsController

- (IBAction)sendEvent:(id)sender {
    NSString* eventName = @"ViewItem";
    
    // Set Conversion Value manually (when using manualSkanConversionManagement)
    // Note that conversion values may only increase, so only the first call will update it
    //[Singular skanUpdateConversionValue:7];
    
    // Reporting a simple event to Singular
    [Singular event:eventName];
    [Utils displayMessage:@"Event sent" withView:self];
}

- (IBAction)sendEventWithArgs:(id)sender {
    NSString* eventName = @"ViewItem_WithArgs";
    NSString* sku = @"12345";
    NSString* price = @"123.45";
        
    // Set Conversion Value manually (when using manualSkanConversionManagement)
    // Note that conversion values may only increase, so only the first call will update it
    //[Singular skanUpdateConversionValue:7];
    
    // Reporting a simple event with Arguments to Singular
    [Singular eventWithArgs:eventName, @"sku", sku, @"price", price, nil];
    [Utils displayMessage:@"ViewItem_WithArgs sent" withView:self];
}


- (IBAction)sendEventsWithArgsWithDictionary:(id)sender {
    NSString* eventName = @"ViewItem_WithDictionary";
    
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:@"value1" forKey:@"key1"];
    [args setObject:@"value2" forKey:@"key2"];
    [args setObject:@"value3" forKey:@"key3"];
    
    // Set Conversion Value manually (when using manualSkanConversionManagement)
    // Note that conversion values may only increase, so only the first call will update it
    //[Singular skanUpdateConversionValue:3];
    
    // Reporting a simple event with Arguments in a Dictionary
    [Singular event:eventName withArgs:args];
    [Utils displayMessage:@"ViewItem_WithDictionary sent" withView:self];
}

@end
