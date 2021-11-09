//
//  main.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Updated by Jared Ornstead on 2021/11/07
//  Copyright © 2021 Singular Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    printf("**** - In MAIN - ****\n");
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    
    
    
}
