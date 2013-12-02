//
//  OrdersExtensiveViewController.h
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceType.h"

@class OrderSummary;

@protocol OrdersTableViewControllerDelegate <NSObject>

- (void)ordersTableViewControllerRequestedFirstOrdersLoadFromServer;
- (void)ordersTableViewControllerRequestedOrdersRefreshFromServer;
- (void)ordersTableViewControllerDidSelectOrder:(OrderSummary *)orderSummary;
- (void)ordersTableViewControllerRequestedRejectionForOrder:(OrderSummary *)orderSummary;

@end

@interface OrdersTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSInteger lastPageLoaded;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *orders;
@property (weak, nonatomic) id<OrdersTableViewControllerDelegate> delegate;

- (void)changeFilterWithPriceType:(PriceType)priceType;

- (void)reloadTableViews;

- (void)pulledToRefresh:(UIRefreshControl *)refreshControl;
- (void)endRefreshing;
- (void)hideSearchDisplayController;

@end
