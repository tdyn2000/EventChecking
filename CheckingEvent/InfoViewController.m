//
//  InfoViewController.m
//  CheckingEvent
//
//  Created by ADMIN on 7/13/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "InfoViewController.h"
#import "AppDefine.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize dicData;
@synthesize lbInfo;
@synthesize lbMessage;
@synthesize imgvInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(dicData!=nil){
        lbInfo.text = msg_invalid;
        lbMessage.text = [dicData objectForKey:k_message];
        imgvInfo.image = [UIImage imageNamed:@"invalid.png"];
        self.view.backgroundColor = [UIColor redColor];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)scanNextPress:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
