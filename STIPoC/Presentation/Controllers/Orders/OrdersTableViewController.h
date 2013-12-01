//
//  OrdersExtensiveViewController.h
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderSummary;

@protocol OrdersTableViewControllerDelegate <NSObject>

- (void)ordersTableViewControllerStartedLoadingOrdersFromServer;
- (void)ordersTableViewControllerFinishedLoadingOrdersFromServer;
- (void)ordersTableViewControllerDidSelectOrder:(OrderSummary *)orderSummary;

@end

@interface OrdersTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceTypeSegmentedControl;

@property (strong, nonatomic) NSMutableArray *orders;
@property (weak, nonatomic) id<OrdersTableViewControllerDelegate> delegate;

- (IBAction)priceTypeFilterChanged:(UISegmentedControl *)sender;

- (void)reloadTableView;
- (void)refreshDataFromServer;

@end
