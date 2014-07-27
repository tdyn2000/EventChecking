//
//  Manager.h
//  CheckingEvent
//
//  Created by ADMIN on 7/1/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AppDefine.h"

@interface Manager : NSObject
{
}

@property (nonatomic,retain) NSString *userid;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *access_token;


+(Manager *) getInstance;
-(void)saveSetting;
-(void)clearSetting;
-(BOOL)loadSetting;

@end
