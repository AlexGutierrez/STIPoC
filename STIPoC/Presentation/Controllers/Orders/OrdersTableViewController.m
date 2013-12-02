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
#import "SelfServiceEnumTranslator.h"

@interface OrdersTableViewController ()

@property (nonatomic) NSInteger requestCounter;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

static NSString *const kSTIPoCOrderSummaryCellIdentifier = @"OrderSummaryCell";
static NSString *const kSTIPoCOrderSummaryCellRejectText = @"Reject";

@implementation OrdersTableViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.requestCounter = 0;
    self.tableView.editing = YES;
    
    [self.tableView addSubview:self.refreshControl];
    
    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedFirstOrdersLoadFromServer)]) {
        [self.delegate ordersTableViewControllerRequestedFirstOrdersLoadFromServer];
    }
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

- (UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl setTintColor:[UIColor verizonRed]];
        [_refreshControl addTarget:self action:@selector(pulledToRefresh:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _refreshControl;
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
    PriceType priceType = (PriceType)self.priceTypeSegmentedControl.selectedSegmentIndex;
    [orderSummaryCell setupWithOrderSummary:orderSummary andPriceType:priceType];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderSummary *orderSummary = self.orders[indexPath.row];
    return ![orderSummary.Status isEqualToString:[SelfServiceEnumTranslator stringFromOrderStatus:OrderStatusRejected]];;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(kSTIPoCOrderSummaryCellRejectText, nil);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        OrderSummary *orderSummary = self.orders[indexPath.row];
        
        if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedRejectionForOrder:)]) {
            [self.delegate ordersTableViewControllerRequestedRejectionForOrder:orderSummary];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderSummary *orderSummary = self.orders[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerDidSelectOrder:)]) {
        [self.delegate ordersTableViewControllerDidSelectOrder:orderSummary];
    }
}

#pragma mark -
#pragma mark Reload Methods

- (void)reloadTableView
{
    [self.tableView reloadData];
}

- (void)pulledToRefresh:(UIRefreshControl *)refreshControl
{
    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedOrdersRefreshFromServer)]) {
        [self.delegate ordersTableViewControllerRequestedOrdersRefreshFromServer];
    }
}

- (void)endRefreshing
{
    [self.refreshControl endRefreshing];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)priceTypeFilterChanged:(UISegmentedControl *)sender
{
    [self.tableView reloadData];
}

@end
