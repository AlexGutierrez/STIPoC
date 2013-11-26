//
//  OrderStatusViewController.m
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "SessionsService.h"

@interface OrderStatusViewController ()

- (void)logout:(UIBarButtonItem *)sender;

@end

@implementation OrderStatusViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Logout", nil) style:UIBarButtonSystemItemCancel target:self action:@selector(logout:)];
}

#pragma mark -
#pragma mark IBActions

- (void)logout:(UIBarButtonItem *)sender
{
    [[SessionsService sharedInstance] logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
