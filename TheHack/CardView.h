//
//  CardView.h
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic, weak) IBOutlet UILabel *username;
@property (nonatomic, weak) IBOutlet UILabel *catchPhrase;
@property (nonatomic, weak) IBOutlet UILabel *profession;
@property (nonatomic, weak) IBOutlet UILabel *interestingFact;


@end
