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
    if ([sender.titleLabel.text isEqualToString:@"Follow"])
    {
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"Following"])
    {
        
    }
}


@end
