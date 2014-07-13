//
//  BaseViewController.h
//  CheckingEvent
//
//  Created by ADMIN on 7/13/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"
#import "AppDefine.h"
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperationManager+Timeout.h"

@interface BaseViewController : UIViewController
{
    MBProgressHUD *HUD;
}

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraint;

- (void)changeViewToInvalid:(UITextField *)view;
- (void)showLoading;
- (void)hideLoading;

@end
