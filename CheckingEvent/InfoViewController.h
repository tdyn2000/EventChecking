//
//  InfoViewController.h
//  CheckingEvent
//
//  Created by ADMIN on 7/13/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface InfoViewController : BaseViewController
@property (nonatomic,weak) IBOutlet UIWebView *wvContent;
@property (nonatomic,weak) NSString *urlLoad;

@end
