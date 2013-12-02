//
//  OrderStatusViewController.h
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"
#import "OrdersTableViewController.h"
#import "OrderDetailViewController.h"

@interface OrderStatusViewController : GenericViewController<OrdersTableViewControllerDelegate, OrderDetailViewControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *priceTypeSegmentedControl;

- (IBAction)menuButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)priceTypeFilterChanged:(UISegmentedControl *)sender;

@end
