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
@property (nonatomic, weak) IBOutlet UIView *colorView;

@property (nonatomic, weak) IBOutlet UILabel *lastEvent;
@property (nonatomic, weak) IBOutlet UIProgressView *p1;
@property (nonatomic, weak) IBOutlet UIProgressView *p2;
@end
