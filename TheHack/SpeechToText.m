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

@property (nonatomic, strong) OELanguageModelGenerator *lmGenerator;
@property (nonatomic, strong) NSString *lmPath;
@property (nonatomic, strong) NSString *dicPath;

@end

const NSString *LanguageModelFiles = @"NameIWantForMyLanguageModelFiles";

@implementation SpeechToText


-(void)recognizeThese
{
    _lmGenerator = [[OELanguageModelGenerator alloc] init];
    
    NSArray *words = [NSArray arrayWithObjects:@"ONE", @"TWO", @"THREE", @"FOUR", @"FIVE", @"SIX", @"SEVEN", @"EIGHT", @"NINE", @"TEN", @"ELEVEN", @"TWELVE", @"AM", @"PM",  nil];
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

-(void)prepareAcousticModel
{
    [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil];
    [[OEPocketsphinxController sharedInstance] startListeningWithLanguageModelAtPath:_lmPath dictionaryAtPath:_dicPath acousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:NO]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" to perform Spanish recognition instead of English.
}


@end
