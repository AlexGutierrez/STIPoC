//
//  OrdersExtensiveViewController.h
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceType.h"
#import "SVPullToRefresh.h"

@class OrderSummary;

@protocol OrdersTableViewControllerDelegate <NSObject>

- (void)ordersTableViewControllerRequestedFirstOrdersLoadFromServer;
- (void)ordersTableViewControllerRequestedOrdersRefreshFromServerWithSearchText:(NSString *)searchText;
- (void)ordersTableViewControllerRequestedMoreOrdersFromServerWithSearchText:(NSString *)searchText;
- (void)ordersTableViewControllerRequestedOrdersSearchFromServerWithSearchText:(NSString *)searchText;

- (void)ordersTableViewControllerDidSelectOrder:(OrderSummary *)orderSummary;
- (void)ordersTableViewControllerRequestedRejectionForOrder:(OrderSummary *)orderSummary;

@end

@interface OrdersTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic) NSInteger lastPageLoaded;
@property (strong, nonatomic) NSString *lastSearchText;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *orders;
@property (weak, nonatomic) id<OrdersTableViewControllerDelegate> delegate;

- (void)changeFilterWithPriceType:(PriceType)priceType;
- (void)hideSearchDisplayController;

- (void)addPullToRefreshView;
- (void)removePullToRefreshView;

- (void)addRefreshControl;
- (void)removeRefreshControl;

@end
