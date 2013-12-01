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

@property (nonatomic) NSInteger lastPageLoaded;
@property (nonatomic) NSInteger requestCounter;

- (void)requestOrderDetailsForOrders:(NSArray *)orders;

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
    
    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerStartedLoadingOrdersFromServer)]) {
        [self.delegate ordersTableViewControllerStartedLoadingOrdersFromServer];
    }
    
    self.lastPageLoaded = 0;
    self.requestCounter++;
    [[SelfService sharedInstance] getOrdersWithPageSize:30
                                             pageNumber:self.lastPageLoaded + 1
                                        completionBlock:^(NSArray *orders) {
                                            self.requestCounter--;
                                            [self requestOrderDetailsForOrders:orders];
                                            
                                        } andFailureBlock:^(NSError *error) {
                                            self.requestCounter--;
                                            if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerFinishedLoadingOrdersFromServer)]) {
                                                [self.delegate ordersTableViewControllerFinishedLoadingOrdersFromServer];
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
    PriceType priceType = (PriceType)self.priceTypeSegmentedControl.selectedSegmentIndex;
    [orderSummaryCell setupOrderSummaryCellWithOrderSummary:orderSummary andPriceType:priceType];
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

- (void)refreshDataFromServer
{
    self.lastPageLoaded = 0;
    
    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerStartedLoadingOrdersFromServer)]) {
        [self.delegate ordersTableViewControllerStartedLoadingOrdersFromServer];
    }
    
    [[SelfService sharedInstance] getOrdersWithPageSize:self.orders.count
                                             pageNumber:self.lastPageLoaded + 1
                                        completionBlock:^(NSArray *orders) {
                                            self.requestCounter--;
                                            [self requestOrderDetailsForOrders:orders];
                                            
                                        } andFailureBlock:^(NSError *error) {
                                            self.requestCounter--;
                                            if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerFinishedLoadingOrdersFromServer)]) {
                                                [self.delegate ordersTableViewControllerFinishedLoadingOrdersFromServer];
                                            }
                                            UIAlertView *alertView = [[AlertViewFactory sharedFactory] createAlertViewWithError:error];
                                            [alertView show];
                                        }];
}

- (void)requestOrderDetailsForOrders:(NSArray *)orders
{
    self.orders = [orders mutableCopy];
    
    for (OrderSummary *orderSummary in self.orders) {
        self.requestCounter++;
        [[SelfService sharedInstance] getOrderDetailWithOrderSummary:orderSummary
                                                     completionBlock:^(OrderSummary *detailedOrderSummary) {
                                                         self.requestCounter--;
                                                         [orderSummary setAttributesWithOrderSummary:detailedOrderSummary];
                                                         if (self.requestCounter <= 0) {
                                                             if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerFinishedLoadingOrdersFromServer)]) {
                                                                 [self.delegate ordersTableViewControllerFinishedLoadingOrdersFromServer];
                                                             }
                                                             
                                                             [self.tableView reloadData];
                                                             self.lastPageLoaded++;
                                                         }
                                                     }
                                                     andFailureBlock:^(NSError *error) {
                                                         self.requestCounter--;
                                                         if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerFinishedLoadingOrdersFromServer)]) {
                                                             [self.delegate ordersTableViewControllerFinishedLoadingOrdersFromServer];
                                                         }
                                                         UIAlertView *alertView = [[AlertViewFactory sharedFactory] createAlertViewWithError:error];
                                                         [alertView show];
                                                     }];
    }
}

#pragma mark -
#pragma mark IBActions

- (IBAction)priceTypeFilterChanged:(UISegmentedControl *)sender
{
    [self.tableView reloadData];
}

@end
