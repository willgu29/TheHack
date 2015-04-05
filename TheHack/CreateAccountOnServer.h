//
//  CreateAccountOnServer.h
//  Tuple
//
//  Created by William Gu on 2/7/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreateAccountOnServer;
@protocol CreateAccountOnServerDelegate

-(void)createAccountSuccess;
-(void)createAccountWithFailure:(NSError *)error;
-(void)updateAccountSuccess;
-(void)updateAccountWithFailure:(NSError *)error;

@end

@interface CreateAccountOnServer : NSObject

@property (nonatomic, assign) id delegate;
-(BOOL)saveUserWithUsername:(NSString *)username andPassword:(NSString *)password andFirstName:(NSString *)firstName andLastName:(NSString *)lastName;
-(BOOL)saveEmail:(NSString *)emailAddress;
-(void)createAccount;
-(void)updateAccount;
-(void)loginUserName:(NSString *)username andPassword:(NSString *)password;

@end
