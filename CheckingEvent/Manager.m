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

@end
