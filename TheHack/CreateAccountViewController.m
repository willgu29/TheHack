//
//  CreateAccountViewController.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()

@property (nonatomic, strong) CreateAccountOnServer *createAccount;

@property (nonatomic, weak) IBOutlet UITextField *email;


@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (nonatomic, weak) IBOutlet UITextField *firstName;
@property (nonatomic, weak) IBOutlet UITextField *lastName;


@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _createAccount = [[CreateAccountOnServer alloc] init];
    _createAccount.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -IBActions
-(IBAction)updateSave:(UIButton *)sender
{
    BOOL success = [_createAccount saveUserWithUsername:_username.text andPassword:_password.text andFirstName:_firstName.text andLastName:_lastName.text];
    if (success)
    {
        [_createAccount createAccount];
    }
    else
    {
        [self displayAlertError];
    }
}

#pragma mark - CreateAccountDelegate
-(void)createAccountSuccess
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Woo!" message:@"Your account has been created and can be searched by the world now!" delegate:nil cancelButtonTitle:@"Neato!" otherButtonTitles:nil];
    [alertView show];
}
-(void)createAccountWithFailure:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hmm.." message:@"We're sorry. There was some error with our server! Please try again in a minute." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark -Helper functions
-(void)displayAlertError
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hmm.." message:@"It seems like you've missed some fields! Please fill in the blanks." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
}

@end
