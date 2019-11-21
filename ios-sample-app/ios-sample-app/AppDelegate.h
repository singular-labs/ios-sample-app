//
//  AppDelegate.h
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSDictionary* deeplinkData;
}

@property (nonatomic, retain) NSDictionary* deeplinkData;

@end

