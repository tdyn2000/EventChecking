//
//  EnterCodeViewController.m
//  CheckingEvent
//
//  Created by ADMIN on 7/13/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "EnterCodeViewController.h"
#import "NSString+Validation.h"

#define msg_code_error @"Please enter code"

@interface EnterCodeViewController ()

@end

@implementation EnterCodeViewController
@synthesize tfCode;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    tfCode.text = @"";
}

-(void)viewDidAppear:(BOOL)animated{
    [tfCode becomeFirstResponder];
}

-(IBAction)sendPress:(id)sender{
    NSString *errorMessage = [self validateData];
	if (errorMessage) {
		self.lbError.text = errorMessage;
		return;
	}
    
    self.lbError.text = @"";
    [self postEventCode:tfCode.text];
}

- (NSString *)validateData {
	NSString *errorMessage;
	UITextField *viewWithError;
	
	if (![self.tfCode.text isValidInput]){
		viewWithError = self.tfCode;
		errorMessage = msg_code_error;
	};
    
	// reset the icon views
	self.tfCode.rightView = nil;
	
	if (viewWithError) {
		[self changeViewToInvalid:viewWithError];
        [viewWithError becomeFirstResponder];
	}
	return errorMessage;
}

@end
