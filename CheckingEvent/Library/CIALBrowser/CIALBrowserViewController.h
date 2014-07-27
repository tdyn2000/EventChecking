//
//  CIALBrowserViewController.h
//  CIALBrowser
//
//  Created by Sylver Bruneau on 01/09/10.
//  Copyright 2011 CodeIsALie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "ViewBookmarkViewController.h"
#import "AddBookmarkViewController.h"
#import "BaseViewController.h"

@interface CIALBrowserViewController : BaseViewController <UIWebViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, ViewBookmarkDelegate, AddBookmarkDelegate, MFMailComposeViewControllerDelegate, UIPrintInteractionControllerDelegate> {
    
    UIBarButtonItem *backButtonItem;
    UIBarButtonItem *forwardButtonItem;
    UIBarButtonItem *actionButtonItem;
    UIButton *stopReloadButton;
    UIButton *bookmarkButton;
    UINavigationItem *navigationItem;
    UIBarButtonItem *closeButtonItem;
    UIBarButtonItem *doneButtonItem;
    UITextField *locationField;
    UINavigationBar *navigationBar;
    NSURL *_urlToLoad;
    NSURL *_urlToHandle;
    
    UIPopoverController *_bookmarkPopoverController;
    UIPopoverController *_addBookmarkPopoverController;
    UIActionSheet *_actionActionSheet;
    UIActionSheet *_longPressActionSheet;
    
    // Buttons Indexes for UIActionSheet (long tap)
    NSInteger copyButtonIndex;
    NSInteger openLinkButtonIndex;
    
    // Buttons Indexes for UIActionSheet (action button)
    NSInteger addBookmarkButtonIndex;
    NSInteger sendUrlButtonIndex;
    NSInteger printButtonIndex;
    NSInteger openWithSafariButtonIndex;
    
    UIPrintInteractionController *printInteraction;
    
    NSMutableURLRequest* req;
}

+ (CIALBrowserViewController *)modalBrowserViewControllerWithURL:(NSURL *)url;

@property (nonatomic, strong, setter=loadURL:) NSURL *url;
@property (nonatomic, strong) UIPopoverController *bookmarkPopoverController;
@property (nonatomic, strong) UIPopoverController *addBookmarkPopoverController;
@property (nonatomic, strong) UIActionSheet *actionActionSheet;
@property (getter = isModal) BOOL modal;
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) IBOutlet  UIToolbar *toolBar;

@property BOOL enabledSafari;

- (void)setURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url;

- (void)openThisURL:(NSURL *)url;

- (void)dismissViewBookmMarkViewController:(ViewBookmarkViewController *)viewController;
- (void)dismissAddBookmMarkViewController:(AddBookmarkViewController *)viewController;

@end
