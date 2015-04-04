//
//  CalendarTableViewCell.h
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *activity;
@property (nonatomic, weak) IBOutlet UILabel *durationHours;


@end
