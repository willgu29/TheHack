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

@interface FindShadowsViewController : UIViewController <MDCSwipeToChooseDelegate, UITableViewDataSource, UITableViewDelegate,FetchSuggestionsDelegate>

@end
