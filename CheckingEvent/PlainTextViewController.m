//
//  PlainTextViewController.m
//  Event
//
//  Created by ADMIN on 7/28/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "PlainTextViewController.h"

@interface PlainTextViewController ()

@end

@implementation PlainTextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _textView.text = _content;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)share:(id)sender
{
    [self shareText:_content andImage:nil andUrl:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
