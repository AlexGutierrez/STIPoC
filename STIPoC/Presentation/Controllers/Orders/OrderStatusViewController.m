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
#import "OrderDetailViewController.h"

NSString *const kSTIPoCSegueEmbedOrdersTableViewController = @"OrdersTableViewControllerEmbedSegue";

static NSString *const kSTIPoCSegueModalOrderDetailViewController = @"OrderDetailViewControllerModalSegue";

@interface OrderStatusViewController ()

@property (weak, nonatomic) OrdersTableViewController *ordersTableViewController;

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
        self.ordersTableViewController = (OrdersTableViewController *)segue.destinationViewController;
        self.ordersTableViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:kSTIPoCSegueModalOrderDetailViewController]) {
        OrderDetailViewController *orderDetailViewController = (OrderDetailViewController *)segue.destinationViewController;
        orderDetailViewController.delegate = self;
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

- (void)ordersTableViewControllerStartedLoadingOrdersFromServer
{
    [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view
                                        title:NSLocalizedString(@"Loading...", nil)
                                         mode:MRProgressOverlayViewModeIndeterminate
                                     animated:YES];
}

- (void)ordersTableViewControllerFinishedLoadingOrdersFromServer
{
    [MRProgressOverlayView dismissAllOverlaysForView:self.navigationController.view animated:YES];
}

- (void)ordersTableViewControllerDidSelectOrder:(OrderSummary *)orderSummary
{
    [self performSegueWithIdentifier:kSTIPoCSegueModalOrderDetailViewController sender:self];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)menuButtonTapped:(UIBarButtonItem *)sender
{
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        [self.slidingViewController resetTopViewAnimated:YES];
    }
    else {
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
}

- (IBAction)refreshButtonTapped:(UIBarButtonItem *)sender
{
    [self.ordersTableViewController refreshDataFromServer];
}

@end
