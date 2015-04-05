//
//  DataCruncher.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "DataCruncher.h"
#import <Parse/Parse.h>

@interface DataCruncher()

@end

@implementation DataCruncher

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setToZero];
    }
    return self;
}

-(NSString *)getPercentageOfTotalHours:(int)categoryHours
{
    double percentage = ((float)categoryHours/(float)_totalHoursCrunched)*100;
    return [NSString stringWithFormat:@"%.2f%%",percentage];
}

-(void)feedDataCrunch:(NSArray *)allLogData
{
    for (PFObject *logData in allLogData)
    {
        NSArray *categories = logData[@"categories"];
        NSArray *timeData = logData[@"calendarData"];
        [self countCategories:categories andTimeData:timeData];
    }
    [_delegate dataCrunchFinished];

}

-(void)countCategories:(NSArray *)categoryStrings andTimeData:(NSArray *)timeData
{
    for (int i = 0; i < [categoryStrings count]; i++)
    {
        NSString *category = [categoryStrings objectAtIndex:i];
        int timeSpent = [[timeData objectAtIndex:i] integerValue];;
        _totalNumberOfCategoriesAnalyzed++;
        _totalHoursCrunched += timeSpent;
        if ([category isEqualToString:@"Leisure"])
        {
            _leisure++;
            _leisureHours += timeSpent;
        }
        else if ([category isEqualToString:@"Work"])
        {
            _work++;
            _workHours += timeSpent;
        }else if ([category isEqualToString:@"Fitness"])
        {
            _fitness++;
            _fitnessHours += timeSpent;
        }
        else if ([category isEqualToString:@"Social"])
        {
            _social++;
            _socialHours += timeSpent;
        }
        else if ([category isEqualToString:@"Motivated"])
        {
            _motivated++;
            _motivatedHours += timeSpent;
        }
        else if ([category isEqualToString:@"Routine"])
        {
            _routine++;
            _routineHours += timeSpent;
        }
        
    }

}

-(void)setToZero
{
    _fitness = 0;
    _leisure = 0;
    _work = 0;
    _motivated = 0;
    _routine = 0;
    _social = 0;
    _totalNumberOfCategoriesAnalyzed = 0;
    _fitnessHours = 0;
    _leisureHours = 0;
    _workHours =0;
    _socialHours =0;
    _routineHours =0;
    _motivatedHours =0;
    _totalHoursCrunched = 0;
}

@end
