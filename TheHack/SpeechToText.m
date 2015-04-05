//
//  SpeechToText.m
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "SpeechToText.h"

#import <OpenEars/OELanguageModelGenerator.h>
#import <OpenEars/OEPocketsphinxController.h>
#import <OpenEars/OEAcousticModel.h>

@interface SpeechToText()

@property (strong, nonatomic) OEEventsObserver *openEarsEventsObserver;
@property (nonatomic, strong) OELanguageModelGenerator *lmGenerator;
@property (nonatomic, strong) NSString *lmPath;
@property (nonatomic, strong) NSString *dicPath;

@end

const NSString *LanguageModelFiles = @"NameIWantForMyLanguageModelFiles";

@implementation SpeechToText

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.openEarsEventsObserver = [[OEEventsObserver alloc] init];
        [self.openEarsEventsObserver setDelegate:self];
        [self recognizeThese];
    }
    return self;
}


-(void)startAcousticModel
{
    
    [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil];
    [[OEPocketsphinxController sharedInstance] startListeningWithLanguageModelAtPath:_lmPath dictionaryAtPath:_dicPath acousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:NO]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" to perform Spanish recognition instead of English.
}
-(void)stopAcousticModel
{
    [[OEPocketsphinxController sharedInstance] suspendRecognition];
}

-(void)something
{
    
}
#pragma mark - OEEventsObserver Delegate
- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
    
    
}

- (void) pocketsphinxDidStartListening {
    NSLog(@"Pocketsphinx is now listening.");
}

- (void) pocketsphinxDidDetectSpeech {
    NSLog(@"Pocketsphinx has detected speech.");
}

- (void) pocketsphinxDidDetectFinishedSpeech {
    NSLog(@"Pocketsphinx has detected a period of silence, concluding an utterance.");
}

- (void) pocketsphinxDidStopListening {
    NSLog(@"Pocketsphinx has stopped listening.");
}

- (void) pocketsphinxDidSuspendRecognition {
    NSLog(@"Pocketsphinx has suspended recognition.");
}

- (void) pocketsphinxDidResumeRecognition {
    NSLog(@"Pocketsphinx has resumed recognition.");
}

- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
    NSLog(@"Pocketsphinx is now using the following language model: \n%@ and the following dictionary: %@",newLanguageModelPathAsString,newDictionaryPathAsString);
}

- (void) pocketSphinxContinuousSetupDidFailWithReason:(NSString *)reasonForFailure {
    NSLog(@"Listening setup wasn't successful and returned the failure reason: %@", reasonForFailure);
}

- (void) pocketSphinxContinuousTeardownDidFailWithReason:(NSString *)reasonForFailure {
    NSLog(@"Listening teardown wasn't successful and returned the failure reason: %@", reasonForFailure);
}

- (void) testRecognitionCompleted {
    NSLog(@"A test file that was submitted for recognition is now complete.");
}

#pragma mark - Helper Functions
-(void)recognizeThese
{
    _lmGenerator = [[OELanguageModelGenerator alloc] init];
    
    NSArray *words = [NSArray arrayWithObjects:@"ONE", @"TWO", @"THREE", @"FOUR", @"FIVE", @"SIX", @"SEVEN", @"EIGHT", @"NINE", @"TEN", @"ELEVEN", @"TWELVE", @"AM", @"PM", @"RUN", @"SLEEP", @"WAKE UP", @"SHOWER", @"EAT", @"LISTEN TO MUSIC", @"HANG OUT WITH FRIENDS", @"MEETINGS", @"WORK", @"STUDY", @"PROGRAM", @"SWIM", @"BIKE", @"HACKATHON", @"SEX", @"MAKE LOVE", @"BRUSH TEETH", @"GROOMING", @"WENT TO THE", @"BEACH", @"TRAVEL", @"PLAYED WITH PETS", @"DRIVE", @"READING", @"TWITTER", @"FACEBOOK", @"PINTEREST", @"SNAPCHAT", @"RELAXED", @"NAP", nil];
    NSString *name = (NSString *)LanguageModelFiles;
    NSError *err = [_lmGenerator generateLanguageModelFromArray:words withFilesNamed:name forAcousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"]]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" to create a Spanish language model instead of an English one.
    
    _lmPath = nil;
    _dicPath = nil;
    
    if(err == nil) {
        
        _lmPath = [_lmGenerator pathToSuccessfullyGeneratedLanguageModelWithRequestedName:(NSString *)LanguageModelFiles];
        _dicPath = [_lmGenerator pathToSuccessfullyGeneratedDictionaryWithRequestedName:(NSString *)LanguageModelFiles];
        
    } else {
        NSLog(@"Error: %@",[err localizedDescription]);
    }
}


@end
