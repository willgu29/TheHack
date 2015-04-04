//
//  LoginViewController.m
//  TheHack
//
//  Created by William Gu on 4/3/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "LoginViewController.h"
#import "Router.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)login:(UIButton *)sender
{
    UIViewController *mainVC = [Router createMainInterfaceWithNavVC];
    
    [self presentViewController:mainVC animated:YES completion:nil];
}


@end
