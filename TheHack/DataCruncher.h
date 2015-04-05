//
//  DataCruncher.h
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataCruncherDelegate <NSObject>

-(void)dataCrunchFinished;


@end

@interface DataCruncher : NSObject

@property (nonatomic, assign) id delegate;

@property (nonatomic) int totalNumberOfCategoriesAnalyzed;
@property (nonatomic) int totalHoursCrunched;

@property (nonatomic) int fitness;
@property (nonatomic) int leisure;
@property (nonatomic) int work;
@property (nonatomic) int social;
@property (nonatomic) int routine;
@property (nonatomic) int motivated;
@property (nonatomic) int fitnessHours;
@property (nonatomic) int leisureHours;
@property (nonatomic) int workHours;
@property (nonatomic) int socialHours;
@property (nonatomic) int routineHours;
@property (nonatomic) int motivatedHours;

-(void)feedDataCrunch:(NSArray *)allLogData;
-(NSString *)getPercentageOfTotalHours:(int)categoryHours;

@end
