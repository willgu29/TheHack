//
//  ColorViewCreator.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorViewCreator.h"

const NSInteger height = 45;
const NSInteger yPos = 0;
const NSInteger xlimit = 280;

@implementation ColorViewCreator

-(NSArray *)createViewsArrayWithKeys:(NSArray *)keys
{
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    int x = 0;
    for (int i = 0; i < [_hoursDuration count]; i++)
    {
        CGFloat hours  = [[_hoursDuration objectAtIndex:i] integerValue];
        CGFloat length = [self convertHoursToPixels:hours];
        UIView *newViewSegment = [ColorViewCreator createView:x andXLength:length andKey:[keys objectAtIndex:i]];
        x = x + length;
        [viewArray addObject:newViewSegment];
        
    }
    return viewArray;
    
}

#pragma mark -Helper functions

-(CGFloat)convertHoursToPixels:(int)hours
{
    //TODO: AVG
    CGFloat avg = [self getAverageHourPixels:_hoursDuration];
    return avg*hours;
}
-(CGFloat)getAverageHourPixels:(NSArray *)hoursDurations
{
    CGFloat totalHours = 0;
    for (NSNumber *hours in hoursDurations)
    {
        totalHours = totalHours + hours.floatValue;
    }
    return (xlimit/totalHours);
}



+(UIView *)createView:(NSInteger)x andXLength:(NSInteger)xLength andKey:(NSString *)string
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, yPos, xLength, height)];
    view.backgroundColor = [ColorViewCreator getBackgroundColorFromKey:string];
  
    return view;
}

+(UIColor *)getBackgroundColorFromKey:(NSString *)key
{
    if ([key isEqualToString:@"Sports"])
    {
        return [UIColor redColor];
    }
    else if ([key isEqualToString:@"Leisure"])
    {
        return [UIColor blueColor];
    }
    else if ([key isEqualToString:@"Work"])
    {
        return [UIColor greenColor];
    }
    return [UIColor blackColor];
}

@end
