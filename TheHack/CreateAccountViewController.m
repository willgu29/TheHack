//
//  CreateAccountViewController.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "CreateAccountOnServer.h"

@interface CreateAccountViewController ()

@property (nonatomic, strong) CreateAccountOnServer *createAccount;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _createAccount = [[CreateAccountOnServer alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)updateSave:(UIButton *)sender
{
    
}

@end
