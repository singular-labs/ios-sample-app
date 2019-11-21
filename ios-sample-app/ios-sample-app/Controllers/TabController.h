//
//  MainTabController.h
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 20/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabController : UITabBarController{
    NSDictionary* deeplinkData;
}

@property (nonatomic, retain) NSDictionary* deeplinkData;

@end
