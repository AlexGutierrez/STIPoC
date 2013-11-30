//
//  OrdersExtensiveViewController.h
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrdersTableViewControllerDelegate <NSObject>

- (void)ordersTableViewControllerStartedGetOrdersRequest;
- (void)ordersTableViewControllerFinishedGetOrdersRequest;

@end

@interface OrdersTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *orders;
@property (weak, nonatomic) id<OrdersTableViewControllerDelegate> delegate;

@end
