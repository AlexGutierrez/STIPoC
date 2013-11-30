//
//  GenericFactory.m
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AlertViewFactory.h"

static NSString *const kSTIPoCAlertViewOKButtonTitle = @"OK";
static NSString *const kSTIPoCAlertViewSubmitButtonTitle = @"Submit";
static NSString *const kSTIPoCAlertViewCancelButtonTitle = @"Cancel";
static NSString *const kSTIPoCAlertViewDismissButtonTitle = @"Dismiss";
static NSString *const kSTIPoCAlertViewGotItButtonTitle = @"Got it!";
static NSString *const kSTIPoCAlertViewOrderRejectionTitle = @"Got it!";
static NSString *const kSTIPoCAlertViewOrderRejectionMessage = @"Please write a comment.";
static NSString *const kSTIPoCAlertViewDefaultTitle = @"Woops!";
static NSString *const kSTIPoCAlertViewDefaultMessage = @"Something unexpected happened. We'll fix it as soon as possible :D";

@implementation AlertViewFactory

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedFactory
{
    static id _sharedFactory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFactory = [[self class] new];
    });
    return _sharedFactory;
}

#pragma mark -
#pragma mark Factory Methods

- (UIAlertView *)createDefaultAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kSTIPoCAlertViewDefaultTitle
                                                        message:kSTIPoCAlertViewDefaultMessage
                                                       delegate:nil
                                              cancelButtonTitle:kSTIPoCAlertViewGotItButtonTitle
                                              otherButtonTitles: nil];
    
    return alertView;
}

- (UIAlertView *)createAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:kSTIPoCAlertViewDismissButtonTitle
                                              otherButtonTitles: nil];
    
    return alertView;
}

- (UIAlertView *)createAlertViewWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:error.domain
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:kSTIPoCAlertViewDismissButtonTitle
                                              otherButtonTitles: nil];
    
    return alertView;
}

- (UIAlertView *)createOrderRejectionAlertViewWithDelegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kSTIPoCAlertViewOrderRejectionTitle
                                                        message:kSTIPoCAlertViewOrderRejectionMessage
                                                       delegate:delegate
                                              cancelButtonTitle:kSTIPoCAlertViewCancelButtonTitle
                                              otherButtonTitles:kSTIPoCAlertViewSubmitButtonTitle, nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    return alertView;
}

@end
