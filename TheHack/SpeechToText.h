//
//  SpeechToText.h
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenEars/OEEventsObserver.h>

@interface SpeechToText : NSObject <OEEventsObserverDelegate>


-(void)startAcousticModel;
-(void)stopAcousticModel;
-(instancetype)init;

@end
