//
//  Utils.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 21/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"

@implementation Utils

+ (NSString*)getApiKey{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:APIKEY];
}

+ (NSString*)getSecret{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:SECRET];
}

+ (void)setApiKey:(NSString*)apikey{
    if([Utils isEmptyOrNull:apikey]){
        return;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:apikey forKey:APIKEY];
    [userDefaults synchronize];
}

+ (void)setSecret:(NSString*)secret{
    if([Utils isEmptyOrNull:secret]){
        return;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:secret forKey:SECRET];
    [userDefaults synchronize];
}

+ (BOOL)isEmptyOrNull:(NSString *)text{
    if(text == nil || [text isEqualToString:@"null"] || [text length] == 0 || [text isKindOfClass:[NSNull class]] || [text isEqualToString:@"NULL"]){
        return true;
    }
    return false;
}

@end
