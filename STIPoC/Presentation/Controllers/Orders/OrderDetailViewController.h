//
//  OrderDetailViewController.h
//  STIPoC
//
//  Created by Administrator on 11/26/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderDetailViewControllerDelegate <NSObject>

@end

extern NSString *const kSTIPoCSegueEmbedOrdersTableViewController;

@interface OrderDetailViewController : UIViewController

@property (weak, nonatomic) id<OrderDetailViewControllerDelegate> delegate;

@end
