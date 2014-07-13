//
//  InfoViewController.h
//  CheckingEvent
//
//  Created by ADMIN on 7/13/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface InfoViewController : BaseViewController
@property (nonatomic,retain) IBOutlet UILabel *lbInfo;
@property (nonatomic,retain) IBOutlet UIImageView *imgvInfo;
@property (nonatomic,retain) IBOutlet UILabel *lbMessage;
@property (nonatomic,retain) NSDictionary *dicData;

-(IBAction)scanNextPress:(id)sender;

@end
