//
//  OrderSummaryCell.h
//  STIPoC
//
//  Created by Administrator on 11/28/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceType.h"

@class OrderSummary;

@interface OrderSummaryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalsLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (void)setupWithOrderSummary:(OrderSummary *)orderSummary andPriceType:(PriceType)priceType;

@end
