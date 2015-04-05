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

@property (nonatomic) int fitness;
@property (nonatomic) int leisure;
@property (nonatomic) int work;
@property (nonatomic) int social;
@property (nonatomic) int routine;
@property (nonatomic) int motivated;

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

-(void)feedDataCrunch:(NSArray *)allLogData
{
    for (PFObject *logData in allLogData)
    {
        NSArray *categories = logData[@"categories"];
        [self countCategories:categories];
    }

}
-(void)countCategories:(NSArray *)categoryStrings
{
    for (NSString *category in categoryStrings)
    {
        if ([category isEqualToString:@"Leisure"])
        {
            _leisure++;
        }
        else if ([category isEqualToString:@"Work"])
        {
            _work++;
        }else if ([category isEqualToString:@"Fitness"])
        {
            _fitness++;
        }
        else if ([category isEqualToString:@"Social"])
        {
            _social++;
        }
        else if ([category isEqualToString:@"Motivated"])
        {
            _motivated++;
        }
        else if ([category isEqualToString:@"Routine"])
        {
            _routine++;
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
}

@end
