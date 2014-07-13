//
//  Manager.m
//  CheckingEvent
//
//  Created by ADMIN on 7/1/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "Manager.h"

@implementation Manager
@synthesize userid;
@synthesize username;
@synthesize email;
@synthesize access_token;

static Manager* instance = nil;

- (id)init
{
    if ( self = [super init] )
    {
        userid = @"";
        username = @"";
        email = @"";
        access_token = @"";
    }
    return self;
}

+(Manager *)getInstance {
    @synchronized(self)
    {
        if (instance == nil){
            instance = [[self alloc] init];
        }
    }
    return(instance);
}

-(void)saveSetting{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting setBool:YES forKey:k_login];
    [setting setObject:userid forKey:k_id];
    [setting setObject:username forKey:k_username];
    [setting setObject:email forKey:k_email];
    [setting setObject:access_token forKey:k_access_token];
    [setting synchronize];
}

-(void)clearSetting{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting setBool:NO forKey:k_login];
    [setting setObject:nil forKey:k_id];
    [setting setObject:nil forKey:k_username];
    [setting setObject:nil forKey:k_email];
    [setting setObject:nil forKey:k_access_token];
    [setting synchronize];
}

-(BOOL)loadSetting{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    if(![setting boolForKey:k_login]){
        return NO;
    }
    userid = [setting objectForKey:k_id];
    username = [setting objectForKey:k_username];
    email = [setting objectForKey:k_email];
    access_token = [setting objectForKey:k_access_token];
    return  YES;
}

@end
