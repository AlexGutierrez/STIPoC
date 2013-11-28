//
//  LoginViewController.h
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"

extern NSString *const kSTIPoCSeguePushMainViewController;

@interface LoginViewController : GenericViewController

/// The userID UITextField IBOutlet
@property (weak, nonatomic) IBOutlet UITextField *userIDField;

/// The domain UITextField IBOutlet
@property (weak, nonatomic) IBOutlet UITextField *customerIDField;

/// The password secure UITextField IBOutlet
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

/// A collection of the loginFields
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *loginFields;

/// The remember UISwitch IBOutlet
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;

/// The UIView that contains all the login fields
@property (weak, nonatomic) IBOutlet UIView *loginFieldsContainer;

- (IBAction)login:(UIButton *)sender;

@end
