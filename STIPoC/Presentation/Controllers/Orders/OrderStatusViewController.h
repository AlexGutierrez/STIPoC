//
//  OrderStatusViewController.h
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericViewController.h"
#import "OrdersTableViewController.h"

@interface OrderStatusViewController : GenericViewController<OrdersTableViewControllerDelegate>

- (IBAction)menuButtonTapped:(id)sender;

@end
