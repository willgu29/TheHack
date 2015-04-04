//
//  FetchSuggestions.h
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FetchSuggestionsDelegate <NSObject>

-(void)fetchSuccess:(NSArray *)data;
-(void)fetchFailureWithError:(NSError *)error;

@end

@interface FetchSuggestions : NSObject

@property (nonatomic, assign) id delegate;

-(void)getAllLogs;

@end
