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
@interface DisplayLogViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSArray *activities;
@property (nonatomic, strong) NSArray *time;
@property (nonatomic, strong) NSString *startDate;


@end

@implementation DisplayLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _time = _log[@"calendarData"];
    _activities = _log[@"activitiesData"];
    _startDate = _log[@"dayStartTime"];
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
    cell.durationHours.text = [_time objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
    [dateComponents setHour:(timeInInt+modifier)];
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
@end
