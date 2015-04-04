//
//  DataViewController.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "DataViewController.h"
#import "SettingsViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)settings:(UIButton *)sender
{
    SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

@end
