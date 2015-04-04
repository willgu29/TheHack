//
//  Audio.m
//  TRN
//
//  Created by William Gu on 3/29/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "Audio.h"
#import <UIKit/UIKit.h>

@implementation Audio

-(void)playground
{
    
    
    
   

    
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{

}
- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done"
                                                    message: @"Finish playing the recording!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - helper functions

-(void)setupRecorder
{
    // Set the audio file
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    _recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
    [_recorder prepareToRecord];
    
    
}
-(BOOL)startRecording
{
    if (!_recorder.recording)
    {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        // Start recording
        return [_recorder record];
    }
    return NO;
}
-(void)stopRecording
{
    [_recorder stop];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
}

-(void)startPlayback//WithURL:(NSURL *)recordingURL
{
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_recorder.url  error:nil];
    [_player setDelegate:self];
    [_player play];
}
-(void)stopPlayback
{
    [_player stop];
    
}

@end
