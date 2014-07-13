//
//  SettingViewController.m
//  CheckingEvent
//
//  Created by ADMIN on 7/13/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "SettingViewController.h"
#import "Manager.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize lbUsername;

- (void)viewDidLoad
{
    [super viewDidLoad];
    lbUsername.text = [[Manager getInstance] username];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)logoutPress:(id)sender{
    [[[UIAlertView alloc] initWithTitle:nil message:msg_confirm delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil] show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [[Manager getInstance]clearSetting];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
