//
//  LoginViewController.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "LoginViewController.h"
#import "SessionsService.h"
#import "AlertViewFactory.h"
#import "User.h"
#import "Customer.h"
#import "XCDFormInputAccessoryView.h"

#define LOGIN_FIELDS_DEFAULT_POSITION_Y 277
#define LOGIN_FIELDS_KEYBOARD_Y_DIFF 120

@interface LoginViewController ()
{
    XCDFormInputAccessoryView *_inputAccessoryView;
}

- (void)fixupFields:(NSNotification *)notification;

@end

@implementation LoginViewController

#if (!defined(TEST))

#pragma mark -
#pragma mark View Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.userIDField.text = nil;
    self.customerIDField.text = nil;
    self.passwordField.text = nil;
    
    User *lastUser = [[SessionsService sharedInstance] lastUser];
    if (lastUser) {
        if ([[SessionsService sharedInstance] retrieveFromKeychainPasswordForUser:lastUser]) {
            [self performSegueWithIdentifier:kSTIPoCSeguePushOrderStatusController sender:self];
        }
        else {
            self.userIDField.text = lastUser.domainID;
            self.customerIDField.text = lastUser.customer.domainID;
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fixupFields:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fixupFields:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#endif

#pragma mark -
#pragma mark Custom Accessors

- (void)setLoginFields:(NSArray *)loginFields
{
	// Some day, IBOutletCollection will be properly sorted, in the meantime, sort it!
	_loginFields = [loginFields sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
		return [@(view1.tag) compare:@(view2.tag)];
	}];
}

- (UIView *) inputAccessoryView
{
	if (!_inputAccessoryView)
	{
		_inputAccessoryView = [[XCDFormInputAccessoryView alloc] initWithResponders:self.loginFields];
	}
	return _inputAccessoryView;
}

#pragma mark -
#pragma mark IBActions

- (void)login:(UIButton *)sender {
    
    NSString *userID = self.userIDField.text;
    NSString *password = self.passwordField.text;
    NSString *customerID = self.customerIDField.text;
    BOOL remember = self.rememberSwitch.on;
    
    NSError *error = nil;
    BOOL loginSucceeded = [[SessionsService sharedInstance] loginWithUserID:userID
                                                                 customerID:customerID
                                                                   password:password
                                                                   remember:remember
                                                                      error:&error];
    
    if (loginSucceeded) {
        [self performSegueWithIdentifier:kSTIPoCSeguePushOrderStatusController sender:self];
    }
    else {
        UIAlertView *alertView = (error)? [[AlertViewFactory sharedInstance] createAlertViewWithTitle:error.domain andMessage:error.localizedDescription] : [[AlertViewFactory sharedInstance] createLoginDefaultAlertView];
        [alertView show];
    }
}

#pragma mark -
#pragma mark Notification Handling

- (void)fixupFields:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.loginFieldsContainer.frame;
        frame.origin.y = ([notification.name isEqualToString:UIKeyboardWillHideNotification])? LOGIN_FIELDS_DEFAULT_POSITION_Y : LOGIN_FIELDS_DEFAULT_POSITION_Y - LOGIN_FIELDS_KEYBOARD_Y_DIFF;
        self.loginFieldsContainer.frame = frame;
    }];
}

@end
