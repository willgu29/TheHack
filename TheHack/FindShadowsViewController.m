//
//  FindShadowsViewController.m
//  TheHack
//
//  Created by William Gu on 4/3/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "FindShadowsViewController.h"
#import "Router.h"


@interface FindShadowsViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end

@implementation FindShadowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MDCSwipeToChooseView *swipeView = [self createNewMDCSwipeToChoose];
    UIImage *swipeImage = [self getImageFromURL:@"http://tupleapp.com/someImageHosting/emailLogo.png"];
    
    
    
    swipeView.imageView.image = swipeImage;
    [self.view addSubview:swipeView];
}

-(void)viewWillAppear:(BOOL)animated
{
    _tableView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        
    }
    cell.textLabel.text = @"HI";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *userVC = [Router createUserProfileVCWithUsername:@"Will Gu"];
    [self presentViewController:userVC animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        _tableView.hidden = NO;
    }
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


@end
