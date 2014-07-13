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
            UITextField *theTextField = objects;
            if ([objects isFirstResponder]) {
                [theTextField resignFirstResponder];
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
    if(HUD == nil){
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDAnimationFade;
        HUD.labelText = @"Loading";
    }
    else{
        [HUD setHidden:NO];
    }
}

- (void)hideLoading {
    if(HUD != nil){
        [HUD setHidden:YES];
    }
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
