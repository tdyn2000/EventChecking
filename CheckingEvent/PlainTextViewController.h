//
//  PlainTextViewController.h
//  Event
//
//  Created by ADMIN on 7/28/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "BaseViewController.h"

@interface PlainTextViewController : BaseViewController
@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) NSString *content;
@end
