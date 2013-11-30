//
//  MenuViewController.m
//  STIPoC
//
//  Created by Administrator on 11/28/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "SessionsService.h"

static NSString *const kSTIPoCSegueEmbedMenuTableViewController = @"MenuTableViewControllerEmbedSegue";

@interface MenuViewController ()

@property (nonatomic, strong) UINavigationController *transitionsNavigationController;

@end

@implementation MenuViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSTIPoCSegueEmbedMenuTableViewController]) {
        MenuOptionsViewController *menuOptionsViewController = (MenuOptionsViewController *)segue.destinationViewController;
        menuOptionsViewController.delegate = self;
    }
}

#pragma mark -
#pragma mark Menu Options View Controller Protocols

- (void)menuOptionsViewControllerDidSelectOption:(MenuOption)menuOption
{
    if (menuOption == MenuOptionLogout) {
        [[SessionsService sharedInstance] logout];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        // Change this in order to swap options
        self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
        [self.slidingViewController resetTopViewAnimated:YES];
    }
}

@end
