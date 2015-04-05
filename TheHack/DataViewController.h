//
//  DataViewController.h
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchSuggestions.h"
#import "DataCruncher.h"
@interface DataViewController : UIViewController <FetchSuggestionsDelegate, DataCruncherDelegate>

@end
