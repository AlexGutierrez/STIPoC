//
//  InspectableLoginViewController.h
//  STIPoC
//
//  Created by Administrator on 11/18/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "LoginViewController.h"

@interface InspectableLoginViewController : LoginViewController

- (void)showOrdersController;
- (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message;

@end
