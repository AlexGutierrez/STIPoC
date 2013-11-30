//
//  OrderStatusViewController.m
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "SessionsService.h"
#import "UIViewController+ECSlidingViewController.h"
#import "ECZoomAnimationController.h"

static NSString *const kSTIPoCSegueEmbedOrdersTableViewController = @"OrdersTableViewControllerEmbedSegue";

@interface OrderStatusViewController ()

@property (strong, nonatomic) ECZoomAnimationController *zoomTransitionController;

@end

@implementation OrderStatusViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.slidingViewController.delegate = self.zoomTransitionController;
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSTIPoCSegueEmbedOrdersTableViewController]) {
        OrdersTableViewController *ordersTableViewController = (OrdersTableViewController *)segue.destinationViewController;
        ordersTableViewController.delegate = self;
    }
}

#pragma mark -
#pragma mark Custom Accessors

- (ECZoomAnimationController *)zoomTransitionController
{
    if (!_zoomTransitionController) {
        _zoomTransitionController = [ECZoomAnimationController new];
    }
    return _zoomTransitionController;
}

#pragma mark -
#pragma mark Orders Table View Controller Protocols

- (void)ordersTableViewControllerStartedGetOrdersRequest
{
    [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view
                                        title:NSLocalizedString(@"Loading...", nil)
                                         mode:MRProgressOverlayViewModeIndeterminate
                                     animated:YES];
}

- (void)ordersTableViewControllerFinishedGetOrdersRequest
{
    [MRProgressOverlayView dismissAllOverlaysForView:self.navigationController.view animated:YES];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)menuButtonTapped:(id)sender
{
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        [self.slidingViewController resetTopViewAnimated:YES];
    }
    else {
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
}

@end
