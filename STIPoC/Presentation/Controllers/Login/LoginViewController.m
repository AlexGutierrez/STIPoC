//
//  LoginViewController.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "LoginViewController.h"
#import "SessionsService.h"
#import "User.h"
#import "Customer.h"
#import "XCDFormInputAccessoryView.h"

#define LOGIN_FIELDS_KEYBOARD_Y_DIFF 200

NSString *const kSTIPoCSeguePushMainViewController = @"MainViewControllerPushSegue";

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
    
    User *lastUser = [[SessionsService sharedService] lastUser];
    if (lastUser) {
        if ([[SessionsService sharedService] retrieveFromKeychainPasswordForUser:lastUser]) {
            [self performSegueWithIdentifier:kSTIPoCSeguePushMainViewController sender:self];
        }
        else {
            self.userIDField.text = lastUser.entityID;
            self.customerIDField.text = lastUser.customer.entityID;
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

/*
- (UIView *) inputAccessoryView
{
	if (!_inputAccessoryView)
	{
		_inputAccessoryView = [[XCDFormInputAccessoryView alloc] initWithResponders:self.loginFields];
	}
	return _inputAccessoryView;
}*/

#pragma mark -
#pragma mark Text Field Protocols

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag >= 2) {
        [self login:nil];
    }
    else {
        UITextField *nextTextField = self.loginFields[textField.tag + 1];
        [nextTextField becomeFirstResponder];
    }
    return YES;
}

#pragma mark -
#pragma mark IBActions

- (void)login:(UIButton *)sender {
    
    NSString *userID = self.userIDField.text;
    NSString *password = self.passwordField.text;
    NSString *customerID = self.customerIDField.text;
    BOOL remember = self.rememberSwitch.on;
    
    NSError *error = nil;
    BOOL loginSucceeded = [[SessionsService sharedService] loginWithUserID:userID
                                                                 customerID:customerID
                                                                   password:password
                                                                   remember:remember
                                                                      error:&error];
    
    if (loginSucceeded) {
        [self performSegueWithIdentifier:kSTIPoCSeguePushMainViewController sender:self];
    }
    else {
        UIAlertView *alertView = (error)? [[AlertViewFactory sharedFactory] createAlertViewWithTitle:error.domain andMessage:error.localizedDescription] : [[AlertViewFactory sharedFactory] createDefaultAlertView];
        [alertView show];
    }
}

#pragma mark -
#pragma mark Notification Handling

- (void)fixupFields:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat centerY = self.view.center.y;
        if ([notification.name isEqualToString:UIKeyboardWillHideNotification] ||  UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            self.loginFieldsContainer.center = CGPointMake(self.view.center.x, centerY);
        }
        else {
            self.loginFieldsContainer.center = CGPointMake(self.view.center.x, centerY - LOGIN_FIELDS_KEYBOARD_Y_DIFF);
        }
        
    }];
}

@end
