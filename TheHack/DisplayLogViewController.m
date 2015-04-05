//
//  DisplayLogViewController.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "DisplayLogViewController.h"
#import "CalendarTableViewCell.h"
#import "AppDelegate.h"
#include <stdlib.h>
#import "ColorViewCreator.h"
@interface DisplayLogViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UILabel *username;
@property (nonatomic, weak) IBOutlet UILabel *day;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *activities;
@property (nonatomic, strong) NSArray *time;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSMutableArray *displayTime;


@end

@implementation DisplayLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _displayTime = [[NSMutableArray alloc] init];
    _time = _log[@"calendarData"];
    _activities = _log[@"activitiesData"];
    _categories = _log[@"categories"];
    _startDate = _log[@"dayStartTime"];
    _endDate = _log[@"dayEndTime"];
    _username.text = _log[@"username"];
    _day.text = [self selectRandomDay];
    [self why];
}
-(void)viewWillAppear:(BOOL)animated
{
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
-(IBAction)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_activities count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
    
    CalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CalendarTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    cell.activity.text = [_activities objectAtIndex:indexPath.row];
    cell.durationHours.text = [_displayTime objectAtIndex:indexPath.row];
    cell.colorView.backgroundColor = [ColorViewCreator getBackgroundColorFromKey:[_categories objectAtIndex:indexPath.row]];
    
    if (indexPath.row == [_activities count] - 1)
    {
        cell.p1.hidden = NO;
        cell.p2.hidden = NO;
        cell.lastEvent.hidden = NO;
        cell.lastEvent.text = [_displayTime objectAtIndex:indexPath.row+1];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(IBAction)startShadow:(UIButton *)sender
{
    [self something];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sweet!" message:@"You're all set, we'll notify you when you need to start a new event for your shadow day." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
}
-(void)something
{
    int totalTime = 0;
    for (int i = 0; i < [_time count]; i++)
    {
        NSDate *pushNotificationTime = [self chooseDateBasedOnHourInterval:totalTime];
        [self setNotificationForThisTime:pushNotificationTime andIndex:i];
        totalTime = (totalTime + [[_time objectAtIndex:i] floatValue]);
        
    }
}
#pragma mark - Helper functions
-(void)setNotificationForThisTime:(NSDate *)date andIndex:(NSInteger)index
{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    [localNotif setFireDate:date];
    [localNotif setAlertAction:@"New Task"];
    NSString *bodyString = [NSString stringWithFormat:@"Start %@ing", [_activities objectAtIndex:index]];
    [localNotif setAlertBody:bodyString];
    [localNotif setSoundName:UILocalNotificationDefaultSoundName];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
}
-(NSDate *)chooseDateBasedOnHourInterval:(CGFloat)hoursDuration
{
    NSDate *now = [NSDate date];
    NSDate *later = [self timeTillSpecificedTime:_startDate];
    NSInteger hoursTillStart = [self getHoursDifferenceBetween:now andDate:later];
    
    int seconds = (hoursTillStart*3600);
    NSDate *timeToSendPushNotification = [NSDate dateWithTimeInterval:seconds sinceDate:now];
    return timeToSendPushNotification;
    
}

-(NSDate *)timeTillSpecificedTime:(NSString *)timeAMPM
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    int totalTime = [self timeInAMPMFromString:timeAMPM];
    [dateComponents setHour:totalTime];
    NSCalendar *gregorian = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:dateComponents];
    return date;
}
-(int)getHoursDifferenceBetween:(NSDate *)dateO1 andDate:(NSDate *)dateO2
{
    NSDate* date1 = dateO1;
    NSDate* date2 = dateO2;
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    return hoursBetweenDates;
}
-(NSString *)selectRandomDay
{
    int r = arc4random_uniform(7);
    if (r == 0)
    {
        return @"Monday";
    } else if (r == 1) {
        return @"Tuesday";
    } else if (r == 2) {
        return @"Wednesday";
    } else if (r == 3) {
        return @"Thursday";
    } else if (r == 4 ) {
        return @"Friday";
    } else if (r == 5) {
        return @"Saturday";
    } else {
        return @"Sunday";
    }
}
-(void)why
{
    int totalTime = 0;
    for (int i = 0; i < [_time count] ; i++)
    {
        if (i == 0)
        {
            totalTime = [self timeInAMPMFromString:_startDate];
        }
        [_displayTime addObject:[self convertHourDurationToTimeStamp:totalTime]];
        totalTime = totalTime + [[_time objectAtIndex:i] integerValue];
    }
    int damnit = [self timeInAMPMFromString:_endDate];
    [_displayTime addObject:[self convertHourDurationToTimeStamp:damnit]];
}

-(NSString *)convertHourDurationToTimeStamp:(int)hourDuration
{
    if (hourDuration == 12)
    {
//        int newDuration = hourDuration - 12;
        return [NSString stringWithFormat:@"%d:00 PM", hourDuration];
    }
    else if (hourDuration > 12)
    {
        int newDuration = hourDuration -12;
        return [NSString stringWithFormat:@"%d:00 PM", newDuration];
    }
    else if (hourDuration < 12)
    {
        return [NSString stringWithFormat:@"%d:00 AM", hourDuration];
    }
    else if (hourDuration == 0)
    {
        int newDuration = hourDuration + 12;
        return [NSString stringWithFormat:@"%d:00 AM", hourDuration];
    }
    return @"12:00 AM";
}
-(int)timeInAMPMFromString:(NSString *)timeAMPM
{
    int modifier = 0;
    if ([timeAMPM containsString:@"pm"]) {
        modifier = 12;
    } else if ([timeAMPM containsString:@"am"]) {
        modifier = 0;
    } else {
        NSLog(@"ERROR");
    }
    NSString *onlyTime = [[timeAMPM componentsSeparatedByCharactersInSet:
                           [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                          componentsJoinedByString:@""];
    int timeInInt = onlyTime.intValue;
    int timeHours = timeInInt + modifier;
    if (timeHours > 24)
    {
        timeHours = timeHours - 24;
    }
    return timeHours;
}
@end

