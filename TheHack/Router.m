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
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[findVC,dataVC];
    
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
    [item1 setImage:[UIImage imageNamed:@"home.png"]];
    [item2 setImage:[UIImage imageNamed:@"profile.png"]];

    
    return tabBarController;
}
+(UIViewController *)createUserProfileVCWithUsername:(NSString *)username
{
    ViewUserProfileViewController *viewVC = [[ViewUserProfileViewController alloc] initWithNibName:@"ViewUserProfileViewController" bundle:nil];
    viewVC.username = username;
    return viewVC;
}

@end
