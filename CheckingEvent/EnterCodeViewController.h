//
//  EnterCodeViewController.h
//  CheckingEvent
//
//  Created by ADMIN on 7/13/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanViewController.h"

@interface EnterCodeViewController : ScanViewController
@property (nonatomic,retain) IBOutlet UITextField *tfCode;
@property (nonatomic,retain) IBOutlet UILabel *lbError;

-(IBAction)sendPress:(id)sender;

@end
