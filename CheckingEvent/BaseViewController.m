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

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![self respondsToSelector:@selector(topLayoutGuide)]) {
        if (self.navigationController != nil) {
            self.topConstraint.constant = self.topConstraint.constant - 64;
        }
        else{
            self.topConstraint.constant = self.topConstraint.constant - 20;
        }
    }
    
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

@end
