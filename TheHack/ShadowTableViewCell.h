//
//  ShadowTableViewCell.h
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShadowTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *whyFollow;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *follow;


@end
