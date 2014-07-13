//
//  ScanViewController.m
//  CheckingEvent
//
//  Created by ADMIN on 7/12/14.
//  Copyright (c) 2014 tdyn2000. All rights reserved.
//

#import "ScanViewController.h"
#import "InfoViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController
@synthesize readerView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // the delegate receives decode results
    readerView.readerDelegate = self;
    UIApplication *app = [UIApplication sharedApplication];
    [readerView willRotateToInterfaceOrientation: app.statusBarOrientation
                                        duration: 0];
    
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
}

- (void) viewWillDisappear: (BOOL) animated
{
    [readerView stop];
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        NSLog(@"%@",sym.data);
        [self postEventCode:sym.data];
        break;
    }
}

-(void)postEventCode:(NSString *)code{
    [self showLoading];
    Manager *mg = [Manager getInstance];
    InfoViewController *infoView = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{k_access_token:mg.access_token ,k_code:code};
    
    [manager POST:scanUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self presentViewController:infoView animated:YES completion:nil];
        [self hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(error.code != code_unauthorized){
            [self hideLoading];
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:nil
                                                              message:msg_connection_error
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            
            [message show];
            return;
        }
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:[operation responseData]
                              options:kNilOptions
                              error:&error];
        
        if(json!=nil){
            infoView.data = [json objectForKey:k_error];
        }
        [self hideLoading];
        [self presentViewController:infoView animated:YES completion:nil];
    }];
}

@end
