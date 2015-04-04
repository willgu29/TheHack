//
//  LoginViewController.m
//  TheHack
//
//  Created by William Gu on 4/3/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "LoginViewController.h"
#import "Router.h"
#import <Parse/Parse.h>
@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;

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
    [PFUser logInWithUsernameInBackground:_username.text password:_password.text block:^(PFUser *user, NSError *error) {
        if (user)
        {
            UIViewController *mainVC = [Router createMainInterfaceWithNavVC];
            [self presentViewController:mainVC animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"We couldn't log you in. Try again in a minute" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            [alertView show];
        }
    }];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
}


@end
