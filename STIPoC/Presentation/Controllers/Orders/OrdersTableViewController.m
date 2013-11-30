//
//  OrdersExtensiveViewController.m
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrdersTableViewController.h"
#import "OrderSummaryCell.h"
#import "OrderSummary.h"
#import "SelfService.h"
#import "AlertViewFactory.h"

@interface OrdersTableViewController ()

@end

static NSString *const kSTIPoCOrderSummaryCellIdentifier = @"OrderSummaryCell";
static NSString *const kSTIPoCOrderSummaryCellRejectText = @"Reject";

@implementation OrdersTableViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.editing = YES;
    
    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerStartedGetOrdersRequest)]) {
        [self.delegate ordersTableViewControllerStartedGetOrdersRequest];
    }
    
    [[SelfService sharedInstance] getOrdersWithCompletionBlock:^(NSArray *orders) {
        if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerFinishedGetOrdersRequest)]) {
            [self.delegate ordersTableViewControllerFinishedGetOrdersRequest];
        }
        self.orders = [orders mutableCopy];
        [self.tableView reloadData];
        
    } andFailureBlock:^(NSError *error) {
        if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerFinishedGetOrdersRequest)]) {
            [self.delegate ordersTableViewControllerFinishedGetOrdersRequest];
        }
        UIAlertView *alertView = [[AlertViewFactory sharedFactory] createAlertViewWithError:error];
        [alertView show];
    }];
}

#pragma mark -
#pragma mark Custom Accessors

- (NSMutableArray *)orders
{
    if (!_orders) {
        _orders = [NSMutableArray new];
    }
    
    return _orders;
}

#pragma mark -
#pragma mark Table View Protocols

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSTIPoCOrderSummaryCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderSummary *orderSummary = self.orders[indexPath.row];
    OrderSummaryCell *orderSummaryCell = (OrderSummaryCell *)cell;
    [orderSummaryCell setupOrderSummaryCellWithOrderSummary:orderSummary];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSTIPoCOrderSummaryCellRejectText;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.orders removeObjectAtIndex:indexPath.row];
       [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //OrderSummary *orderSummary = self.orders[indexPath.row];
    
}

@end
