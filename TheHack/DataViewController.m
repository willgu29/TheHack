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

#import <Parse/Parse.h>
@interface DataViewController ()

@property (nonatomic, weak) IBOutlet UILabel *followingCount;
@property (nonatomic, weak) IBOutlet UILabel *followersCount;
@property (nonatomic, strong) FetchSuggestions *fetcher;
@property (nonatomic, strong) DataCruncher *dataCrunch;


@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fetcher = [[FetchSuggestions alloc] init];
    _fetcher.delegate = self;
    _dataCrunch = [[DataCruncher alloc] init];
}
-(void)viewWillAppear:(BOOL)animated
{
    [_fetcher getFetchFromIndex:FETCH_ALL];
    [self setupLabels];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Fetch Delegate
-(void)fetchSuccess:(NSArray *)data withIndex:(int)index
{
    [_dataCrunch feedDataCrunch:data];
    //TODO: RELOAD
}
-(void)fetchFailureWithError:(NSError *)error
{
    
}

-(IBAction)testColor:(UIButton *)sender
{
    ColorViewController *colorVC = [[ColorViewController alloc] initWithNibName:@"ColorViewController" bundle:nil];
    [self presentViewController:colorVC animated:YES completion:nil];
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
