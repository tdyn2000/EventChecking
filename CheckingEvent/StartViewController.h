//
//  ViewController.h
//  CheckingEvent
//
//  Created by ADMIN on 7/11/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface StartViewController : BaseViewController <UITextFieldDelegate>
@property (nonatomic,retain) IBOutlet UITextField *tfUsername;
@property (nonatomic,retain) IBOutlet UITextField *tfPassword;
@property (nonatomic,retain) IBOutlet UILabel *lbError;

-(IBAction)loginPress:(id)sender;

@end
