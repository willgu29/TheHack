//
//  FindShadowsViewController.h
//  TheHack
//
//  Created by William Gu on 4/3/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>
#import "FetchSuggestions.h"
#import "SwipeView.h"

@interface FindShadowsViewController : UIViewController <MDCSwipeToChooseDelegate, UITableViewDataSource, UITableViewDelegate,FetchSuggestionsDelegate, SwipeViewDataSource, SwipeViewDelegate>

@property (nonatomic, strong) IBOutlet SwipeView *swipeView;


@end
