//
//  AppDelegate.m
//  CheckingEvent
//
//  Created by ADMIN on 7/11/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "AppDelegate.h"
#import "ZBarSDK.h"
#import "Manager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ZBarReaderView class];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
