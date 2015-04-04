//
//  SettingsViewController.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "SettingsViewController.h"
#import "Audio.h"
#import "SpeechToText.h"

@interface SettingsViewController ()

@property (nonatomic, strong) Audio *audioPlayer;
@property (nonatomic, strong) SpeechToText *speechConverter;


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _audioPlayer = [[Audio alloc] init];
    _speechConverter = [[SpeechToText alloc] init];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
-(IBAction)testOpenEars:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Open"])
    {
        [_speechConverter startAcousticModel];
        [sender setTitle:@"Closed" forState:UIControlStateNormal];
    }
    else
    {
        [_speechConverter stopAcousticModel];
        [sender setTitle:@"Open" forState:UIControlStateNormal];
    }
}
-(IBAction)recordAudio:(UIButton *)sender
{
    if([sender.titleLabel.text isEqualToString:@"Record"])
    {
        [_audioPlayer setupRecorder];
        [_audioPlayer startRecording];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
    }
    else
    {
        [_audioPlayer stopRecording];
        [sender setTitle:@"Record" forState:UIControlStateNormal];
    }
  
}
-(IBAction)playAudio:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Play"])
    {
        [_audioPlayer startPlayback];
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else
    {
        [_audioPlayer stopRecording];
        [sender setTitle:@"Play" forState:UIControlStateNormal];
    }
}
-(IBAction)archive:(UIButton *)sender
{
    
}

-(IBAction)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
