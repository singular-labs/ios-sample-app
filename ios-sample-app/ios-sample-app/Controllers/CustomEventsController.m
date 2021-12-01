//
//  CustomEventsController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 19/11/2019.
//  Updated by Jared Ornstead on 2021/11/19
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import "CustomEventsController.h"
#import "Singular.h"
#import "Utils.h"

@implementation CustomEventsController

- (IBAction)sendEvent:(id)sender {
    NSString* eventName = self.eventNameField.text;
    
    if([Utils isEmptyOrNull:eventName]){
        [Utils displayMessage:@"Please enter a valid event name." withView:self];
    } else {
        if(eventName.length <= 32){
            //Add code here
            // Set Conversion Value manually (when using manualSkanConversionManagement)
            // Note that conversion values may only increase, so only the first call will update it
            [Singular skanUpdateConversionValue:7];
            
            // Reporting a simple Custom Event to Singular
            [Singular event:eventName];
            
            // Logging for Testing
            NSLog(@"Event Sent: %@", eventName);
            [Utils displayMessage:@"Event sent" withView:self];
            
        } else {
            [Utils displayMessage:@"Event name is too long. Event name length limit is 32 characters." withView:self];
        }
    }
    return;
}

- (IBAction)sendEventsWithAttributes:(id)sender {
    NSString* eventName = self.eventNameField.text;
    
    if([Utils isEmptyOrNull:eventName]){
        [Utils displayMessage:@"Please enter a valid event name." withView:self];
    } else {
        if(eventName.length <= 32){
            NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
            [args setObject:@"value1" forKey:@"key1"];
            [args setObject:@"value2" forKey:@"key2"];
            
            // Set Conversion Value manually (when using manualSkanConversionManagement)
            // Note that conversion values may only increase, so only the first call will update it
            [Singular skanUpdateConversionValue:3];
            
            // Reporting a Custom Event with custom attributes in a Dictionary
            [Singular event:eventName withArgs:args];
            
            // Logging for Testing
            NSLog(@"Event Sent with Args: %@", eventName);
            [Utils displayMessage:@"Event sent" withView:self];
            
        } else {
            [Utils displayMessage:@"Event name is too long. Event name length limit is 32 characters." withView:self];
        }
    }
    return;
}

@end
