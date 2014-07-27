//
//  ScanViewController.m
//  CheckingEvent
//
//  Created by ADMIN on 7/12/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "ScanViewController.h"
#import "InfoViewController.h"
#import "CIALBrowserViewController.h"
#import "UIAlertView+Blocks.h"
#import "PlainTextViewController.h"

#define SMS @"SMS"
#define SMSTO @"SMSTO"
#define TEL @"tel"

@interface ScanViewController ()
@end

@implementation ScanViewController
@synthesize readerView;
@synthesize codeContent;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // the delegate receives decode results
    readerView.readerDelegate = self;
    
    //    [readerView setTorchMode:NO];
    //    ZBarImageScanner *scanner = readerView.scanner;
    //
    //    [scanner setSymbology: ZBAR_I25
    //                   config: ZBAR_CFG_ENABLE
    //                       to: 0];
    
    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = readerView;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    [readerView start];
//    [readerView flushCache];
    //    [self toggleFlashlight];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [readerView stop];
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    for(ZBarSymbol *sym in syms) {
        [self postEventCode:sym.data];
        break;
    }
    syms = nil;
}

-(void)postEventCode:(NSString *)code{
    NSLog(@"Code: %@",code);
    codeContent = code;
    
    if([self isCalling:code]){
        return;
    }
    
    if([self validateUrl:code]){
        [self performSegueWithIdentifier:@"urlView" sender:self];
        return;
    }
    
    if([self isSMS:code]){
        return;
    }
    
    [self performSegueWithIdentifier:@"PlainText" sender:self];
    
    return;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"urlView"]){
        CIALBrowserViewController *controller = segue.destinationViewController;
        NSURL *url = [NSURL URLWithString:codeContent];
        [controller setURL:url];
    }
    if([segue.identifier isEqualToString:@"PlainText"]){
        PlainTextViewController *view = segue.destinationViewController;
        view.content = codeContent;
    }
}


- (BOOL) validateUrl: (NSString *) stringURL {
    NSString *urlRegEx =
    @"((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    if([urlTest evaluateWithObject:stringURL]){
        stringURL = [NSString stringWithFormat:@"http://%@",stringURL];
    }
    
    NSString *urlRegEx1 =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx1];
    codeContent = stringURL;
    
    NSLog(@"NSString Url %@",stringURL);
    return [urlTest1 evaluateWithObject:stringURL];
}

- (BOOL) isSMS: (NSString *) stringURL {
    NSArray *result = [stringURL componentsSeparatedByString: @":"];
    NSString *schema = [result objectAtIndex:0];
    if([schema isEqualToString:SMS]||[schema isEqualToString:SMSTO]){
        [self sendInAppSMS:[result objectAtIndex:1] message:[result objectAtIndex:2]];
        return YES;
    }
    return NO;
}

- (BOOL) isCalling: (NSString *) stringURL {
    NSArray *result = [stringURL componentsSeparatedByString: @":"];
    NSString *schema = [result objectAtIndex:0];
    
    if([schema isEqualToString:TEL]){
        NSString *phoneNumber = [result objectAtIndex:1];
        [UIAlertView showWithTitle:@""
                           message:phoneNumber
                 cancelButtonTitle:@"Cancel"
                 otherButtonTitles:@[@"Call"]
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              [readerView flushCache];
                              if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Call"]) {
                                  NSString *phone = [@"tel://" stringByAppendingString:phoneNumber];
                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
                                  
                              }}];
        return YES;
    }
    return NO;
}

-(void)sendInAppSMS:(NSString*)recipients message:(NSString*)mess
{
	MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = mess;
		controller.recipients = @[recipients];
		controller.messageComposeDelegate = self;
		[self presentViewController:controller animated:YES completion:nil];
	}
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send Message" message:@"Unknown Error"
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
        }
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)toggleLed:(id)sender{
    //    torchIsOn = !torchIsOn;
    //    [self toggleFlashlight:torchIsOn];
    bool flag = [readerView torchMode];
    [readerView setTorchMode:!flag];
}

//- (void)toggleFlashlight:(BOOL)flag
//{
//    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
//    if (captureDeviceClass != nil) {
//        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        if ([device hasTorch] && [device hasFlash]){
//
//            [device lockForConfiguration:nil];
//            flag = [device torchMode];
//            flag = !flag;
//            if (flag) {
//                [device setTorchMode:AVCaptureTorchModeOn];
//                [device setFlashMode:AVCaptureFlashModeOn];
//            } else {
//                [device setTorchMode:AVCaptureTorchModeOff];
//                [device setFlashMode:AVCaptureFlashModeOff];
//            }
//            [device unlockForConfiguration];
//        }
//    }
//}

@end
