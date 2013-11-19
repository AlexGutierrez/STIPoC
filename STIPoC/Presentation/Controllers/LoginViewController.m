//
//  LoginViewController.m
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

- (void)showOrdersController;
- (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message;

@end

@implementation LoginViewController

#pragma mark -
#pragma mark IBActions

- (void)login:(UIButton *)sender {
    
    
}

#pragma mark -
#pragma mark Private Methods

- (BOOL)inputsAreValid
{
    NSString *userID = self.userIDField.text;
    NSString *password = self.passwordField.text;
    NSString *domain = self.domainField.text;

    return YES;
}

- (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message
{
    
}

- (void)showOrdersController
{
    
}

@end
