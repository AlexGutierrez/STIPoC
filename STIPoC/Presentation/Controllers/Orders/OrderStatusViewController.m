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
#import "AlertViewFactory.h"
#import "SelfService.h"

#define ALERT_VIEW_CANCEL_INDEX 0
#define REJECTION_ALERT_VIEW_TAG 1
#define MODIFICATION_ALERT_VIEW_TAG 2

NSString *const kSTIPoCSegueEmbedOrdersTableViewController = @"OrdersTableViewControllerEmbedSegue";

static NSString *const kSTIPoCSegueModalOrderDetailViewController = @"OrderDetailViewControllerModalSegue";

@interface OrderStatusViewController ()

@property (nonatomic) NSInteger requestCounter;

@property (weak, nonatomic) OrdersTableViewController *ordersTableViewController;

@property (strong, nonatomic) ECZoomAnimationController *zoomTransitionController;

@property (strong, nonatomic) OrderSummary *selectedOrderSummary;

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
        orderDetailViewController.selectedOrderSummary = self.selectedOrderSummary;
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
    [self.ordersTableViewController endRefreshing];
}

- (void)ordersTableViewControllerRequestedOrdersRefreshFromServer
{
    [self.ordersTableViewController refreshDataFromServer];
}

- (void)ordersTableViewControllerDidSelectOrder:(OrderSummary *)orderSummary
{
    self.selectedOrderSummary = orderSummary;
    [self performSegueWithIdentifier:kSTIPoCSegueModalOrderDetailViewController sender:self];
}

#pragma mark -
#pragma mark Order Detail View Controller Protocols

- (void)orderDetailViewControllerModifiedOrder:(OrderSummary *)orderSummary
{
    self.selectedOrderSummary = orderSummary;
    UIAlertView *alertView = [[AlertViewFactory sharedFactory] createConfirmationAlertViewWithTitle:NSLocalizedString(@"Orders update", nil)
                                                                                            message:NSLocalizedString(@"Your order is about to be updated. Please tap OK to proceed.", nil)
                                                                                        andDelegate:self];
    alertView.tag = MODIFICATION_ALERT_VIEW_TAG;
    [alertView show];
}

- (void)orderDetailViewControllerRejectedOrder:(OrderSummary *)orderSummary
{
    self.selectedOrderSummary = orderSummary;
    UIAlertView *alertView = [[AlertViewFactory sharedFactory] createOrderRejectionAlertViewWithDelegate:self];
    alertView.tag = REJECTION_ALERT_VIEW_TAG;
    [alertView show];
}

#pragma mark -
#pragma mark Alert View Protocols

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == ALERT_VIEW_CANCEL_INDEX) {
        [self performSegueWithIdentifier:kSTIPoCSegueModalOrderDetailViewController sender:self];
    }
    else {
        if (alertView.tag == REJECTION_ALERT_VIEW_TAG) {
            [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view
                                                title:NSLocalizedString(@"Rejecting...", nil)
                                                 mode:MRProgressOverlayViewModeIndeterminate
                                             animated:YES];
            
            self.requestCounter++;
            [[SelfService sharedInstance] rejectOrderWithOrderSummary:self.selectedOrderSummary
                                                             comments:nil
                                                      completionBlock:^{
                                                          self.requestCounter--;
                                                          
                                                      } andFailureBlock:^(NSError *error) {
                                                          self.requestCounter--;
                                                          [MRProgressOverlayView dismissAllOverlaysForView:self.navigationController.view animated:YES];
                                                          UIAlertView *alertView = [[AlertViewFactory sharedFactory] createAlertViewWithError:error];
                                                          [alertView show];
                                                      }];
        }
        else {
            int a = 0;
            a--;
        }
    }
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

@end
