//
//  OrderDetailTableViewController.h
//  STIPoC
//
//  Created by Alex Gutierrez on 12/1/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteLineItemCell.h"

#import "PriceType.h"
@class OrderSummary;

@protocol OrderDetailTableViewControllerDelegate <NSObject>

- (void)quoteLineItemPricesUpdated;
- (void)quoteLineItemRemoved;

@end

@interface OrderDetailTableViewController : UITableViewController<QuoteLineItemCellDelegate>

@property (weak, nonatomic) id<OrderDetailTableViewControllerDelegate> delegate;

@property (strong, nonatomic) OrderSummary *selectedOrderSummary;

- (void)changeFilterWithPriceType:(PriceType)priceType;

@end
