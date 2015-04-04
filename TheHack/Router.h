//
//  Router.h
//  TRN
//
//  Created by William Gu on 3/16/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Router : NSObject

+(UIViewController *)createMainInterfaceWithNavVC;
+(UIViewController *)createUserProfileVCWithUsername:(NSString *)username;
@end
