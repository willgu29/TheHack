//
//  FetchSuggestions.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "FetchSuggestions.h"
#import <Parse/Parse.h>
#import "ParseDatabase.h"
#import "FetchConstants.h"
@implementation FetchSuggestions

-(void)getAllLogs
{
    PFQuery *query = [PFQuery queryWithClassName:@"Logs"];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser)
    {
        NSArray *following = [ParseDatabase lookupFollowListForUsername:currentUser.username];
        [query whereKey:@"username" notContainedIn:following];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects)
        {
            [_delegate fetchSuccess:objects withIndex:FETCH_FIND];
        }
        else
        {
            [_delegate fetchFailureWithError:error];
        }
    }];
}
-(void)getFollowingLogs
{
    PFQuery *query = [PFQuery queryWithClassName:@"Logs"];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser)
    {
        NSArray *following = [ParseDatabase lookupFollowListForUsername:currentUser.username];
        [query whereKey:@"username" containedIn:following];
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects)
        {
            [_delegate fetchSuccess:objects withIndex:FETCH_FOLLOWING];
        }
        else
        {
            [_delegate fetchFailureWithError:error];
        }
    }];
}
-(void)getTrendingLogs
{
    PFQuery *query = [PFQuery queryWithClassName:@"Logs"];
    [query whereKey:@"views" greaterThan:[NSNumber numberWithInt:10]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects)
        {
            [_delegate fetchSuccess:objects withIndex:FETCH_TRENDING];
        }
        else
        {
            [_delegate fetchFailureWithError:error];
        }
    }];
}
-(void)getFetchFromIndex:(int)index
{
    if (index == 0)
    {
        [self getAllLogs];
    }
    else if (index == 1)
    {
        [self getFollowingLogs];
    }
    else if (index == 2)
    {
        [self getTrendingLogs];
    }
}

@end
