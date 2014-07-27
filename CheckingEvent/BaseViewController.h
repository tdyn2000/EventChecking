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
#import "GADBannerView.h"

@interface BaseViewController : UIViewController <GADBannerViewDelegate>
{
    MBProgressHUD *hud;
    GADBannerView *adBanner;
}

@property(strong, nonatomic) GADBannerView *adBanner;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraint;

- (void)changeViewToInvalid:(UITextField *)view;
- (void)showLoading;
- (void)hideLoading;
- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url;
-(void)AddAds;

@end
