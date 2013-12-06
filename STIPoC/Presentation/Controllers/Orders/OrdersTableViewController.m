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

@property (strong, nonatomic) NSMutableArray *searchResults;

@property (nonatomic) PriceType priceType;

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
    //self.tableView.editing = YES;
    
    [self.tableView addSubview:self.refreshControl];

    [self.tableView addPullToRefreshWithActionHandler:^{
        if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedMoreOrdersFromServer)]) {
            [self.delegate ordersTableViewControllerRequestedMoreOrdersFromServer];
        }
    } position:SVPullToRefreshPositionBottom];
    
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

#pragma mark -
#pragma mark Search Display Controller Protocols

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark -
#pragma mark Table View Protocols

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (tableView == self.searchDisplayController.searchResultsTableView)? [self.searchResults count] : [self.orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kSTIPoCOrderSummaryCellIdentifier forIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderSummary *orderSummary = (tableView == self.searchDisplayController.searchResultsTableView)? self.searchResults[indexPath.row] : self.orders[indexPath.row];
    OrderSummaryCell *orderSummaryCell = (OrderSummaryCell *)cell;
    [orderSummaryCell setupWithOrderSummary:orderSummary andPriceType:self.priceType];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderSummary *orderSummary = (tableView == self.searchDisplayController.searchResultsTableView)? self.searchResults[indexPath.row] : self.orders[indexPath.row];
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
        OrderSummary *orderSummary = (tableView == self.searchDisplayController.searchResultsTableView)? self.searchResults[indexPath.row] : self.orders[indexPath.row];
        
        if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedRejectionForOrder:)]) {
            [self.delegate ordersTableViewControllerRequestedRejectionForOrder:orderSummary];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderSummary *orderSummary = (tableView == self.searchDisplayController.searchResultsTableView)? self.searchResults[indexPath.row] : self.orders[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerDidSelectOrder:)]) {
        [self.delegate ordersTableViewControllerDidSelectOrder:orderSummary];
    }
}

#pragma mark -
#pragma mark Reload Methods

- (void)reloadTableViews
{
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

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
    
    if ([self.delegate respondsToSelector:@selector(ordersTableViewControllerRequestedOrdersRefreshFromServer)]) {
        [self.delegate ordersTableViewControllerRequestedOrdersRefreshFromServer];
    }
}

- (void)endRefreshing
{
    [self.refreshControl endRefreshing];
}

#pragma mark -
#pragma mark Search Methods

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.OrderFriendlyId contains[cd] %@",
                                    searchText];
    
    self.searchResults = [[self.orders filteredArrayUsingPredicate:resultPredicate] mutableCopy];
}

#pragma mark -
#pragma mark Private Methods

- (void)changeFilterWithPriceType:(PriceType)priceType
{
    self.priceType = priceType;
    
    [self reloadTableViews];
}

- (void)hideSearchDisplayController
{
    [self.searchDisplayController setActive:NO animated:YES];
}

@end
