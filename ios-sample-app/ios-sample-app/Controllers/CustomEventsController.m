//
//  CustomEventsController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 19/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import "CustomEventsController.h"
#import "Singular.h"

@implementation CustomEventsController

- (IBAction)sendEvent:(id)sender {
    NSString* eventName = [self getEventName];
    
    if(!eventName){
        return;
    }
    
    [Singular event:eventName];
}

- (IBAction)sendEventsWithAttributes:(id)sender {
    NSString* eventName = [self getEventName];
    
    if(!eventName){
        return;
    }
    
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:@"value1" forKey:@"key1"];
    [args setObject:@"value2" forKey:@"key2"];
    
    [Singular event:eventName withArgs:args];
}

- (NSString*)getEventName{
    if (!self.eventNameField.text || self.eventNameField.text.length == 0){
        return nil;
    }
    
    return self.eventNameField.text;
}

@end
