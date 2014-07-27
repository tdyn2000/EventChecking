//
//  BaseViewController.m
//  CheckingEvent
//
//  Created by ADMIN on 7/13/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize adBanner;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)AddAds{
    self.adBanner = [[GADBannerView alloc]
                     initWithAdSize:kGADAdSizeSmartBannerPortrait];
    // Need to set this to no since we're creating this custom view.
    self.adBanner.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Note: Edit SampleConstants.h to provide a definition for kSampleAdUnitID
    // before compiling.
    self.adBanner.adUnitID = admob_id;
    self.adBanner.delegate = self;
    [self.adBanner setRootViewController:self];
    [self.view addSubview:self.adBanner];
    [self.adBanner loadRequest:[self createRequest]];
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.adBanner
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1.0
                                   constant:0]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.adBanner
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0]];
}

- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as
    // well as any devices you want to receive test ads.
    request.testDevices =
    [NSArray arrayWithObjects:
     @"b7afa3754bd4fec1114f6fc87d3ab1e3",GAD_SIMULATOR_ID,
     
     nil];
    return request;
}

- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"Received ad successfully");
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    NSArray *subviews = [self.view subviews];
    for (id objects in subviews) {
        if ([objects isKindOfClass:[UITextField class]]) {
            UITextField *tf = objects;
            if ([tf isFirstResponder]) {
                [tf resignFirstResponder];
            }
        }
    }
}

- (void)changeViewToInvalid:(UITextField *)view {
	if (view){
        
		UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Failure"]];
		errorImageView.frame = CGRectMake(5, (view.frame.size.height - 20) / 2, 20, 20);
		errorImageView.contentMode = UIViewContentModeScaleAspectFit;
		
		view.rightView = errorImageView;
		view.rightViewMode = UITextFieldViewModeAlways;
	}
}

- (void)showLoading {
    if(hud == nil){
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDAnimationFade;
        hud.labelText = @"Loading";
    }
    else{
        [hud setHidden:NO];
    }
}

- (void)hideLoading {
    if(hud != nil){
        [hud setHidden:YES];
    }
}

- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (text) {
        [sharingItems addObject:text];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

@end
