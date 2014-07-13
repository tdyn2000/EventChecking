//
//  ScanViewController.h
//  CheckingEvent
//
//  Created by ADMIN on 7/12/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZBarSDK.h"

@interface ScanViewController : BaseViewController  < ZBarReaderViewDelegate >
{
    ZBarReaderView *readerView;
    
//    //Simulator
    ZBarCameraSimulator *cameraSim;
}

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;

-(void)postEventCode:(NSString *)code;

@end
