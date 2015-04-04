//
//  DisplayLogViewController.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "DisplayLogViewController.h"
#import "CalendarTableViewCell.h"
@interface DisplayLogViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSArray *activities;
@property (nonatomic, strong) NSArray *time;

@end

@implementation DisplayLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _time = _log[@"calendarData"];
    _activities = _log[@"activitiesData"];
    
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
//
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 160;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 160;
//}

@end
