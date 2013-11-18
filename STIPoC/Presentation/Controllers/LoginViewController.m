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
    
    // Empty fields
    if ([userID isEqualToString:@""] || [password isEqualToString:@""] || [domain isEqualToString:@""]) {
        return NO;
    }
    
    // Validating credentials against DB
    if (!([userID isEqualToString:@"ValidUserID"] && [password isEqualToString:@"ValidPassword"] && [domain isEqualToString:@"ValidDomain"])) {
        return NO;
    }
    
    return YES;
}

- (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message
{
    
}

- (void)showOrdersController
{
    
}

@end
