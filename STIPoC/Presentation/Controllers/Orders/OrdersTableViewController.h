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
- (void)ordersTableViewControllerRequestedOrdersRefreshFromServer;
- (void)ordersTableViewControllerRequestedMoreOrdersFromServer;

- (void)ordersTableViewControllerDidSelectOrder:(OrderSummary *)orderSummary;
- (void)ordersTableViewControllerRequestedRejectionForOrder:(OrderSummary *)orderSummary;

@end

@interface OrdersTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSInteger lastPageLoaded;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *orders;
@property (weak, nonatomic) id<OrdersTableViewControllerDelegate> delegate;

- (void)changeFilterWithPriceType:(PriceType)priceType;
- (void)reloadTableViews;
- (void)hideSearchDisplayController;

- (void)addPullToRefreshView;
- (void)removePullToRefreshView;

- (void)addRefreshControl;
- (void)removeRefreshControl;

@end
