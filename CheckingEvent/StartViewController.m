//
//  ViewController.m
//  CheckingEvent
//
//  Created by ADMIN on 7/11/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "StartViewController.h"
#import "NSString+Validation.h"
#import "ScanViewController.h"

//app message
#define msg_username_error @"Please enter username"
#define msg_password_error @"Please enter password"


//macro
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

@interface StartViewController ()

@end

@implementation StartViewController
@synthesize tfUsername;
@synthesize tfPassword;
@synthesize lbError;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    tfUsername.text = @"";
    tfPassword.text = @"";
    lbError.text = @"";
}

-(void)viewDidAppear:(BOOL)animated{
    Manager *mg = [Manager getInstance];
    if([mg loadSetting]){
        [self performSegueWithIdentifier: @"ScanView" sender: self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginPress:(id)sender{
    [self Login];
}

-(void)Login{
    tfUsername.text = @"demo";
    tfPassword.text = @"demo";
    
    [tfUsername resignFirstResponder];
    [tfPassword resignFirstResponder];
    
    NSString *errorMessage = [self validateData];
	if (errorMessage) {
		lbError.text = errorMessage;
		return;
	}
    
    [self showLoading];
    lbError.text = @"";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"username": tfUsername.text,@"password":tfPassword.text};
    [manager POST:loginUrl parameters:parameters timeoutInterval:10.0 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        Manager *mg = [Manager getInstance];
        mg.userid = [responseObject objectForKey:k_id];
        mg.username = [responseObject objectForKey:k_username];
        mg.email = [responseObject objectForKey:k_email];
        mg.access_token = [responseObject objectForKey:k_access_token];
        
        [self hideLoading];
        [[Manager getInstance]saveSetting];
        [self performSegueWithIdentifier: @"ScanView" sender: self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if(error.code != code_unauthorized){
            lbError.text = msg_connection_error;
            [self hideLoading];
            return;
        }
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:[operation responseData]
                              options:kNilOptions
                              error:&error];
        
        if(json!=nil){
            lbError.text = [[json objectForKey:k_error]objectForKey:k_message];
        }
        [self hideLoading];
    }];
}

- (NSString *)validateData {
	NSString *errorMessage;
	UITextField *viewWithError;
	
	if (![self.tfUsername.text isValidInput]){
		viewWithError = self.tfUsername;
		errorMessage = msg_username_error;
	} else if (![self.tfPassword.text isValidInput]){
		viewWithError = self.tfPassword;
		errorMessage = msg_password_error;
	};
	
	// reset the icon views
	self.tfUsername.rightView = nil;
	self.tfPassword.rightView = nil;
	
	if (viewWithError) {
		[self changeViewToInvalid:viewWithError];
        [viewWithError becomeFirstResponder];
	}
	return errorMessage;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ( textField == tfUsername ) { [tfPassword becomeFirstResponder]; }
    if ( textField == self.tfPassword ) { [self Login]; return YES; }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    if(IS_IPHONE5) return;
    
    const int movementDistance = -80; // tweak as needed
    const float movementDuration = 0.2f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


@end
