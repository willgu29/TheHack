//
//  ColoredView.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "ColoredView.h"
#import "ColorViewCreator.h"

@implementation ColoredView



-(void)addViewsFromArrayToColoredView:(NSArray *)viewsToAdd
{
    
    for (int i=0; i < [viewsToAdd count]; i++) {
        [self addSubview:[viewsToAdd objectAtIndex:i]];

    }
}


@end
