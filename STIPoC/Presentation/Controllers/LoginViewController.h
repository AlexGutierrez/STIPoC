//
//  LoginViewController.h
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"

@interface LoginViewController : GenericViewController

@property (weak, nonatomic) IBOutlet UITextField *userIDField;
@property (weak, nonatomic) IBOutlet UITextField *domainField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login:(UIButton *)sender;



@end
