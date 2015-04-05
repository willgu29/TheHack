//
//  SettingsViewController.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "SettingsViewController.h"
#import "Audio.h"
#import "SpeechToText.h"
#import "LoginViewController.h"
#import "CreateAccountViewController.h"

@interface SettingsViewController ()

@property (nonatomic, strong) Audio *audioPlayer;
@property (nonatomic, strong) SpeechToText *speechConverter;


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _audioPlayer = [[Audio alloc] init];
    _speechConverter = [[SpeechToText alloc] init];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
-(IBAction)testOpenEars:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Open"])
    {
        [_speechConverter startAcousticModel];
        [sender setTitle:@"Closed" forState:UIControlStateNormal];
    }
    else
    {
        [_speechConverter stopAcousticModel];
        [sender setTitle:@"Open" forState:UIControlStateNormal];
    }
}


-(IBAction)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


-(IBAction)adminLogin:(UIButton *)sender
{
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self presentViewController:loginVC animated:YES completion:nil];
}
-(IBAction)createAccount:(UIButton *)sender
{
    CreateAccountViewController *createVC = [[CreateAccountViewController alloc] initWithNibName:@"CreateAccountViewController" bundle:nil];
    [self.navigationController pushViewController:createVC animated:YES];
}
@end
