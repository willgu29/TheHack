//
//  ShadowTableViewCell.h
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColoredView.h"

@interface ShadowTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *username;
@property (nonatomic, weak) IBOutlet UILabel *whyFollow;
@property (nonatomic, weak) IBOutlet UIButton *follow;
@property (nonatomic, weak) IBOutlet ColoredView *colorView;


@end
