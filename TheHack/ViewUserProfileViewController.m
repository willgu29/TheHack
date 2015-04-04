//
//  ViewUserProfileViewController.m
//  TRN
//
//  Created by William Gu on 3/22/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "ViewUserProfileViewController.h"

@interface ViewUserProfileViewController ()

@end

@implementation ViewUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Username's Profile";
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
