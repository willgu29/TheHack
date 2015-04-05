//
//  DataViewController.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "DataViewController.h"
#import "SettingsViewController.h"
#import "RyanViewController.h"
#import "ColorViewController.h"

#import <Parse/Parse.h>
@interface DataViewController ()

@property (nonatomic, weak) IBOutlet UILabel *followingCount;
@property (nonatomic, weak) IBOutlet UILabel *followersCount;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setupLabels];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)testColor:(UIButton *)sender
{
    ColorViewController *colorVC = [[ColorViewController alloc] initWithNibName:@"ColorViewController" bundle:nil];
    [self presentViewController:colorVC animated:YES completion:nil];
}

-(IBAction)settings:(UIButton *)sender
{
    SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

#pragma mark - Helper functions
-(void)setupLabels
{
    PFUser *currentUser = [PFUser currentUser];
    _followersCount.text = [NSString stringWithFormat:@"%d",[currentUser[@"Followers"] count]];
    _followingCount.text = [NSString stringWithFormat:@"%d",[currentUser[@"Following"] count]];
}

@end
