//
//  FetchUserData.m
//  Tuple
//
//  Created by William Gu on 2/8/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "ParseDatabase.h"
#import "Converter.h"
#import "ParseUserValues.h"

@implementation ParseDatabase

+(NSArray *)lookupFollowListForUsername:(NSString*)username
{
    PFUser *user = (PFUser *)[ParseDatabase lookupUsername:username];
    return user[@"Following"];
}
+(PFUser *)lookupUsername:(NSString *)username
{
    if (username == nil)
    {
        return nil;
    }
    PFQuery *query = [PFUser query];
    [query whereKey:U_USERNAME equalTo:username];
    PFUser *user = (PFUser *)[query getFirstObject];
    return user;
    
}

+(PFUser *)lookupPhoneNumber:(NSString *)phoneNumber
{
    NSString *justNumbersPhoneNumber = [Converter convertPhoneNumberToOnlyNumbers:phoneNumber];
    PFQuery *query = [PFUser query];
    [query whereKey:@"phoneNumber" equalTo:justNumbersPhoneNumber];
    PFUser *user = (PFUser *)[query getFirstObject];
    return user;
}
+(PFUser *)lookupDeviceToken:(NSString *)deviceToken
{
    if (deviceToken == nil)
    {
        return nil;
    }
    PFQuery *query = [PFUser query];
    [query whereKey:U_DEVICE_TOKEN equalTo:deviceToken];
    PFUser *user = (PFUser *)[query getFirstObject];
    return user;
}
+(PFObject *)lookupEventWithHost:(NSString *)hostUsername
{
    if (hostUsername == nil)
    {
        return nil;
    }
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    [query whereKey:@"hostUsername" equalTo:hostUsername];
    PFObject *eventObject =[query getFirstObject];
    return eventObject;
}
+(PFObject *)lookupEventWithID:(NSString *)uuid
{
    if (uuid == nil)
    {
        return nil;
    }
    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    [query whereKey:@"eventID" equalTo:uuid];
    PFObject *eventObject =[query getFirstObject];
    return eventObject;
}


+(BOOL)getPhoneVerificationStatusCurrentUser
{
    PFUser *user = [self lookupUsername:[PFUser currentUser].username];
    NSNumber *phoneStatus =  user[@"phoneVerified"];
    return phoneStatus.boolValue;
}

+(NSString *)getCurrentUserFirstAndLastNameFormattedString
{
    PFUser *user = [PFUser currentUser];
    NSString *firstName = user[U_FIRST_NAME];
    NSString *lastName = user[U_LAST_NAME];
    NSString *format = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    return format;
}

@end
