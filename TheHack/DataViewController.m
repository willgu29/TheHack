//
//  DataViewController.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "DataViewController.h"
#import "SettingsViewController.h"
#import "ColorViewController.h"
#import "FetchConstants.h"
#import "DataCruncher.h"
#import  <RQShineLabel/RQShineLabel.h>

#import <Parse/Parse.h>
@interface DataViewController ()

@property (nonatomic, weak) IBOutlet UILabel *followingCount;
@property (nonatomic, weak) IBOutlet UILabel *followersCount;
@property (nonatomic, strong) FetchSuggestions *fetcher;
@property (nonatomic, strong) DataCruncher *dataCrunch;


@property (nonatomic, weak) IBOutlet RQShineLabel *interestingFact;

@property (nonatomic) int factCounter;
@end

@implementation DataViewController

-(IBAction)newFact:(UIButton *)sender
{
    _interestingFact.shineDuration = 1;
    [self.interestingFact fadeOutWithCompletion:^{
        [_interestingFact setText:[self getFactAtIndex:_factCounter]];
        [self.interestingFact shine];
       
    }];

    _factCounter++;
}
-(NSString *)getFactAtIndex:(int)index
{
    if (index == 0)
    {
        return @"Time duration of Fitness does not exceed 2 hours for most of people.";
    } else if (index == 1) {
        return @"25% of everyone using this app start their days by running.";
    } else if (index == 2) {
        return @"42.72% of people start their days before 10am.";
    } else if (index == 3) {
        return @"Only 15.52% of people sleep before 8pm.";
    } else if (index == 4) {
        return @"No activity has lasted longer than 5 hours.";
    } else if (index == 5) {
        return @"About 36.23% of total people take a nap during the day.";
    } else if (index == 6) {
        return @"Over 22.15% of people skip a meal everyday";
    } else if (index == 7) {
        return @"Don't you think you should be spending your time elsewhere?";
    } else if (index == 8) {
        return @"More time is spent eating than in fitness";
    } else if (index == 9) {
        return @"12% of people never travel farther than their homes in a given year.";
    } else if (index == 10) {
        return @"Only 10.21% of females miss showering in any given day";
    } else if (index == 11) {
        return @"The average person only reads 1 minute per day for their whole lifetime.";
    } else if (index == 12) {
        return @"The people who program the most are also most likely to skip showers.";
    } else if (index == 13) {
        return @"You've reached this far?";
    } else if (index == 14) {
        return @"About 12.52% of guys never ask a girl on a date in a given year";
    } else if (index == 15) {
        return @"People spend most of their time working...";
    }
    return @"No more facts :(";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _fetcher = [[FetchSuggestions alloc] init];
    _fetcher.delegate = self;
    _dataCrunch = [[DataCruncher alloc] init];
    _dataCrunch.delegate = self;
    _factCounter = 0;
    _interestingFact.shineDuration = 2.5;
    [_interestingFact setTextColor:[UIColor blackColor]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [_fetcher getFetchFromIndex:FETCH_ALL];
    [self setupLabels];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.interestingFact shine];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Fetch Delegate
-(void)fetchSuccess:(NSArray *)data withIndex:(int)index
{
    [_dataCrunch feedDataCrunch:data];
}
-(void)fetchFailureWithError:(NSError *)error
{
    
}
-(void)dataCrunchFinished //access _dataCrunch for results
{
    NSString *randomCategory = [self chooseRandomCategory];
    if ([randomCategory isEqualToString:@"Motivated"])
    {
        _interestingFact.text = [NSString stringWithFormat:@"Of all the people using this app, they spent %@ of their time being motivated.", [_dataCrunch getPercentageOfTotalHours:_dataCrunch.motivatedHours]];
    } else if ([randomCategory isEqualToString:@"Social"]) {
        _interestingFact.text = [NSString stringWithFormat:@"Of all the people using this app, they spent %@ of their time being social.", [_dataCrunch getPercentageOfTotalHours:_dataCrunch.socialHours]];
    } else if ([randomCategory isEqualToString:@"Leisure"]) {
        _interestingFact.text = [NSString stringWithFormat:@"Of all the people using this app, they spent %@ of their time at leisure.", [_dataCrunch getPercentageOfTotalHours:_dataCrunch.leisureHours]];
    } else if ([randomCategory isEqualToString:@"Work"]) {
        _interestingFact.text = [NSString stringWithFormat:@"Of all the people using this app, they spent %@ of their time working.", [_dataCrunch getPercentageOfTotalHours:_dataCrunch.workHours]];
    } else if ([randomCategory isEqualToString:@"Routine"]) {
        _interestingFact.text = [NSString stringWithFormat:@"Of all the people using this app, they spent %@ of their time doing routine tasks.", [_dataCrunch getPercentageOfTotalHours:_dataCrunch.routineHours]];
    } else if ([randomCategory isEqualToString:@"Fitness"]) {
        _interestingFact.text = [NSString stringWithFormat:@"Of all the people using this app, they spent %@ of their time excercising.", [_dataCrunch getPercentageOfTotalHours:_dataCrunch.fitnessHours]];
    } else {
        _interestingFact.text = @"Sorry, we could not come up with a fact today. Please come again tomorrow!";
    }
}
-(NSString *)chooseRandomCategory
{
    int r = arc4random_uniform(6);
    if (r == 0)
    {
        return @"Motivated";
    } else if (r == 1) {
        return @"Social";
    } else if (r == 2) {
        return @"Leisure";
    } else if (r == 3) {
        return @"Work";
    } else if (r == 4 ) {
        return @"Routine";
    } else if (r == 5) {
        return @"Fitness";
    } else {
        return @"NONE";
    }
}

-(IBAction)settings:(UIButton *)sender
{
    SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

#pragma mark - Helper functions
-(void)setupLabels
{
    PFUser *currentUser = [PFUser currentUser];
    _followersCount.text = [NSString stringWithFormat:@"%d",[currentUser[@"Followers"] count]];
    _followingCount.text = [NSString stringWithFormat:@"%d",[currentUser[@"Following"] count]];
}

@end
