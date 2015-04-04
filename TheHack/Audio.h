//
//  Audio.h
//  TRN
//
//  Created by William Gu on 3/29/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Audio : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

-(void)setupRecorder;
-(BOOL)startRecording;
-(void)startPlayback;
-(void)stopRecording;
-(void)stopPlayback;


@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;


@end
