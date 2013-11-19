//
//  LoginViewController.h
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"

@interface LoginViewController : GenericViewController

/// The userID UITextField IBOutlet
@property (weak, nonatomic) IBOutlet UITextField *userIDField;

/// The domain UITextField IBOutlet
@property (weak, nonatomic) IBOutlet UITextField *domainField;

/// The password secure UITextField IBOutlet
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login:(UIButton *)sender;



@end
