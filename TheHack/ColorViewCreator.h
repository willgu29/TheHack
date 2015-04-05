//
//  ColorViewCreator.h
//  TheHack
//
//  Created by William Gu on 4/4/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorViewCreator : NSObject

@property (nonatomic, strong) NSArray *hoursDuration;

-(NSArray *)createViewsArrayWithKeys:(NSArray *)keys;

@end
