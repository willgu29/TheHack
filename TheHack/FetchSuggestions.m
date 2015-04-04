//
//  FetchSuggestions.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "FetchSuggestions.h"
#import <Parse/Parse.h>

@implementation FetchSuggestions

-(void)getAllLogs
{
    PFQuery *query = [PFQuery queryWithClassName:@"Logs"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects)
        {
            [_delegate fetchSuccess:objects];
        }
        else
        {
            [_delegate fetchFailureWithError:error];
        }
    }];
}

@end
