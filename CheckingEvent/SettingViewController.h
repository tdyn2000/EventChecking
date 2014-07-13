//
//  SettingViewController.h
//  CheckingEvent
//
//  Created by ADMIN on 7/13/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SettingViewController : BaseViewController <UIAlertViewDelegate>
@property (nonatomic,retain) IBOutlet UILabel *lbUsername;

-(IBAction)logoutPress:(id)sender;

@end
