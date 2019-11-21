//
//  ViewController.m
//  ios-sample-app
//
//  Created by Eyal Rabinovich on 13/11/2019.
//  Copyright © 2019 Singular Labs. All rights reserved.
//

#import "InitController.h"

@implementation InitController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)initSdk:(id)sender {
    UITabBarController *viewController =
    [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabController"];
    
    [self.navigationController presentViewController:viewController animated:YES completion:nil];
}
@end
