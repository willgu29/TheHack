//
//  ShadowTableViewCell.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "ShadowTableViewCell.h"
#import <Parse/Parse.h>

@interface ShadowTableViewCell()

@end

@implementation ShadowTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)followButton:(UIButton *)sender
{
    if ([PFUser currentUser])
    {
        if ([sender.titleLabel.text isEqualToString:@"Follow"])
        {
            [self followUser:_username.text];
            [sender setTitle:@"Following" forState:UIControlStateNormal];
        }
        else if ([sender.titleLabel.text isEqualToString:@"Following"])
        {
            [self unfollowUser:_username.text];
            [sender setTitle:@"Follow" forState:UIControlStateNormal];
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"In order to follow, please make an account in data -> Settings" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
    }

}

#pragma mark - Helper functions

-(void)followUser:(NSString *)username
{
    PFUser *currentUser = [PFUser currentUser];
    [currentUser addObject:username forKey:@"Following"];
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            
        }
        else
        {
            
        }
    }];
}
-(void)unfollowUser:(NSString *)username
{
    PFUser *currentUser = [PFUser currentUser];
    [currentUser removeObject:username forKey:@"Following"];
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            
        }
        else
        {
            
        }
    }];
}


@end
