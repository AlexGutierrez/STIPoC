//
//  GenericFactory.m
//  STIPoC
//
//  Created by Administrator on 11/12/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "AlertViewFactory.h"

static NSString *const kSTIPoCDefaultCancelButtonTitle = @"Got it!";
static NSString *const kSTIPoCDefaultLoginAlertViewTitle = @"Woops!";
static NSString *const kSTIPoCDefaultLoginAlertViewMessage = @"Something unexpected happened. We'll fix it as soon as possible :D.";

@implementation AlertViewFactory

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedInstance
{
    static AlertViewFactory *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [AlertViewFactory new];
    });
    return _sharedInstance;
}


#pragma mark -
#pragma mark Factory Methods

- (UIAlertView *)createLoginDefaultAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kSTIPoCDefaultLoginAlertViewTitle
                                                        message:kSTIPoCDefaultLoginAlertViewMessage
                                                       delegate:nil
                                              cancelButtonTitle:kSTIPoCDefaultCancelButtonTitle
                                              otherButtonTitles: nil];
    
    return alertView;
}

- (UIAlertView *)createAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:kSTIPoCDefaultCancelButtonTitle
                                              otherButtonTitles: nil];
    
    return alertView;
}

@end
