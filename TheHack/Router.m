//
//  Router.m
//  TRN
//
//  Created by William Gu on 3/16/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "Router.h"
#import "FindShadowsViewController.h"
#import "DataViewController.h"
#import "ViewUserProfileViewController.h"

@implementation Router

+(UIViewController *)createMainInterfaceWithNavVC
{
    FindShadowsViewController *findVC = [[FindShadowsViewController alloc] initWithNibName:@"FindShadowsViewController" bundle:nil];
    DataViewController *dataVC = [[DataViewController alloc] initWithNibName:@"DataViewController" bundle:nil];
    
    findVC.title = @"Shadow";
    dataVC.title = @"Data";
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    tabBar.viewControllers = @[findVC,dataVC];
    return tabBar;
}
+(UIViewController *)createUserProfileVCWithUsername:(NSString *)username
{
    ViewUserProfileViewController *viewVC = [[ViewUserProfileViewController alloc] initWithNibName:@"ViewUserProfileViewController" bundle:nil];
    viewVC.username = username;
    return viewVC;
}

@end
