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

@property (nonatomic) PriceType priceType;

- (void)pulledToRefresh:(UIRefreshControl *)refreshControl;

@end

static NSString *const kSTIPoCOrderSummaryCellRejectText = @"Reject";

@implementation OrdersTableViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.requestCounter = 0;
    self.tableView.editing = YES;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedMoreOrdersFromServerWithSearchText:)]) {
            [self.delegate ordersTableViewControllerRequestedMoreOrdersFromServerWithSearchText:self.lastSearchText];
        }
    } position:SVPullToRefreshPositionBottom];
    
    [self addRefreshControl];
    [self addPullToRefreshView];

    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedFirstOrdersLoadFromServer)]) {
        [self.delegate ordersTableViewControllerRequestedFirstOrdersLoadFromServer];
    }
    
    self.searchDisplayController.searchResultsTableView.editing = YES;
    self.searchDisplayController.searchResultsTableView.rowHeight = 80;
    self.searchDisplayController.searchResultsTableView.allowsSelectionDuringEditing = YES;
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
        [_refreshControl setBackgroundColor:[UIColor whiteColor]];
        [_refreshControl setTintColor:[UIColor verizonRed]];
        [_refreshControl addTarget:self action:@selector(pulledToRefresh:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _refreshControl;
}

- (NSString *)lastSearchText
{
    if (!_lastSearchText) {
        _lastSearchText = @"";
    }
    
    return _lastSearchText;
}

#pragma mark -
#pragma mark Search Bar Protocols

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    
    [self searchBarSearchButtonClicked:searchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    if (![self.lastSearchText isEqualToString:searchBar.text]) {
        if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedOrdersSearchFromServerWithSearchText:)]) {
            [self.delegate ordersTableViewControllerRequestedOrdersSearchFromServerWithSearchText:searchBar.text];
        }
        
        self.lastSearchText = searchBar.text;
    }
}

#pragma mark -
#pragma mark Table View Protocols

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kSTIPoCOrderSummaryCellIdentifier forIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderSummary *orderSummary = self.orders[indexPath.row];
    OrderSummaryCell *orderSummaryCell = (OrderSummaryCell *)cell;
    [orderSummaryCell setupWithOrderSummary:orderSummary andPriceType:self.priceType];
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
#pragma mark Loading Methods

- (void)pulledToRefresh:(UIRefreshControl *)refreshControl
{
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        long long a = 0;
        for (long long i = 0; i < 100000000000; i++) {
            a++;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [refreshControl endRefreshing];
        });
    });*/
    
    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedOrdersRefreshFromServerWithSearchText:)]) {
        [self.delegate ordersTableViewControllerRequestedOrdersRefreshFromServerWithSearchText:self.lastSearchText];
    }
}

- (void)endRefreshing
{
    [self.refreshControl endRefreshing];
}

- (void)addPullToRefreshView
{
    self.tableView.showsPullToRefresh = YES;
}

- (void)removePullToRefreshView
{
    self.tableView.showsPullToRefresh = NO;
}

- (void)addRefreshControl
{
    [self.tableView addSubview:self.refreshControl];
}

- (void)removeRefreshControl
{
    [self.refreshControl removeFromSuperview];
}


#pragma mark -
#pragma mark Private Methods

- (void)changeFilterWithPriceType:(PriceType)priceType
{
    self.priceType = priceType;
    [self.tableView reloadData];
}

- (void)hideSearchDisplayController
{
    [self.searchDisplayController setActive:NO animated:YES];
}

@end
