//
//  FindShadowsViewController.m
//  TheHack
//
//  Created by William Gu on 4/3/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "FindShadowsViewController.h"
#import "Router.h"
#import <Parse/Parse.h>
#import "ShadowTableViewCell.h"
#import "DisplayLogViewController.h"
#import "ColoredView.h"
#import "ColorViewCreator.h"
#import "CreateAccountOnServer.h"
@interface FindShadowsViewController ()

@property (nonatomic, strong) FetchSuggestions *fetcher;
@property (nonatomic, strong) CreateAccountOnServer *createAccount;

@property (nonatomic, strong) NSMutableArray *headerContainer;

@property (nonatomic, strong) NSArray *logsData;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation FindShadowsViewController

- (void)refresh:(UIRefreshControl *)refreshControl {
    NSLog(@"Called");
    [_fetcher getFetchFromIndex:_swipeView.currentPage];
    [refreshControl endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];   
    
    _headerContainer =  [[NSMutableArray alloc] initWithObjects:@[], @[], @[], nil];
    
    
    _fetcher = [[FetchSuggestions alloc] init];
    _fetcher.delegate = self;
    
    for (int i = 0; i < [_headerContainer count]; i++)
    {
        [_fetcher getFetchFromIndex:i];
    }
    
    MDCSwipeToChooseView *swipeView = [self createNewMDCSwipeToChoose];
    UIImage *swipeImage = [self getImageFromURL:@"http://tupleapp.com/someImageHosting/emailLogo.png"];
    
    
    _swipeView.hidden = YES;
    swipeView.imageView.image = swipeImage;
    [self.view addSubview:swipeView];
    
    [_segmentControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self configureSwipeView];

}
-(void)segmentValueChanged:(UISegmentedControl *)sender
{
    [_swipeView setCurrentPage:sender.selectedSegmentIndex];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_fetcher getFetchFromIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *header = [_headerContainer objectAtIndex:tableView.tag];
    return [header count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
    
    ShadowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShadowTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    NSArray *dataLogs = [_headerContainer objectAtIndex:tableView.tag];
    PFObject *log = [dataLogs objectAtIndex:indexPath.row];
    NSString *followText;
    if (tableView.tag == 1)
    {
        followText = @"Following";
    }
    else
    {
        followText = @"Follow";
    }
    cell.whyFollow.text = log[@"whyShadow"];
    cell.username.text = log[@"username"];
    [cell.colorView addViewsFromArrayToColoredView:[ColorViewCreator createViewsArrayWithHours:log[@"calendarData"] andKeys:@[@"Sports", @"Leisure", @"Work", @"NONE", @"Sports", @"Leisure"]]];
    [cell.follow setTitle:followText forState:UIControlStateNormal];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DisplayLogViewController *displayVC = [[DisplayLogViewController alloc] initWithNibName:@"DisplayLogViewController" bundle:nil];
    NSArray *logData = [_headerContainer objectAtIndex:tableView.tag];
    displayVC.log = [logData objectAtIndex:indexPath.row];
    [self presentViewController:displayVC animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark - MDCSwipeToChooseDelegate Callbacks

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        return YES;
    } else if (direction == MDCSwipeDirectionRight){
        return YES;
    } else {
        // Snap the view back and cancel the choice.
        [UIView animateWithDuration:0.16 animations:^{
            view.transform = CGAffineTransformIdentity;
            view.center = self.view.center;
        }];
        return NO;
    }
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved!");
    }
    if ([self isLastCard])
    {
        _swipeView.hidden = NO;
    }
}

#pragma mark - Fetch Delegate
-(void)fetchSuccess:(NSArray*)data withIndex:(int)index
{
    NSArray *header = [_headerContainer objectAtIndex:index];
    header = data;
    [_headerContainer replaceObjectAtIndex:index withObject:header];
    
    UIView *viewItem = [_swipeView itemViewAtIndex:index];
    UITableView *tableView = [viewItem.subviews lastObject];
    [tableView reloadData];
}
-(void)fetchFailureWithError:(NSError *)error
{
    NSLog(@"Error Fetch: %@", error);
}

#pragma mark - Swipe View
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [_headerContainer count];
}


-(void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    [_segmentControl setSelectedSegmentIndex:swipeView.currentPage];
    
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NSLog(@"Index: %d", index);
    view = nil;
    if (view == nil)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.swipeView.bounds];
        // Initialize the refresh control.
        [self removeInsetsFrom:tableView];
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        [tableView addSubview:refreshControl];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = index;
        [view addSubview:tableView];
//        [_fetcher getFetchFromIndex:index];
        
    }
    
    return view;
}
- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}


#pragma mark - Helper functions

-(MDCSwipeToChooseView *)createNewMDCSwipeToChoose
{
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.likedText = @"YES";
    options.likedColor = [UIColor greenColor];
    options.nopeText = @"NO";
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
        else if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionRight)
        {
            NSLog(@"let go now to swipe right!");
        }
    };
    CGRect frame =  CGRectMake(self.view.bounds.size.width/3, self.view.bounds.size.height/3, self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    MDCSwipeToChooseView *view = [[MDCSwipeToChooseView alloc] initWithFrame:frame
                                                                     options:options];
    return view;
}
-(UIImage *)getImageFromURL:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    return img;
}
-(BOOL)isLastCard
{
    return YES;
}
-(void)configureSwipeView
{
    //configure swipe view
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    _swipeView.wrapEnabled = YES;
    [self swipeViewCurrentItemIndexDidChange:0];
}
-(void)removeInsetsFrom:(UITableView *)tableView
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    if ([tableView respondsToSelector:@selector(setSeparatorStyle:)])
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


@end
