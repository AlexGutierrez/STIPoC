//
//  OrderSummaryCell.m
//  STIPoC
//
//  Created by Administrator on 11/28/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrderSummaryCell.h"
#import "OrderSummary.h"
#import "QuoteLineItem.h"

@implementation OrderSummaryCell

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.backgroundColor = selected? [UIColor redColor] : [UIColor whiteColor];
}
*/
- (void)setupOrderSummaryCellWithOrderSummary:(OrderSummary *)orderSummary
{
    self.orderNumberLabel.text = [NSString stringWithFormat:@"Order Number: %@", orderSummary.OrderFriendlyId];
    self.projectNumberLabel.text = [NSString stringWithFormat:@"Project Number: %@", (orderSummary.ProjectFriendlyId)? orderSummary.ProjectFriendlyId : @"-"];
    self.statusLabel.text = [NSString stringWithFormat:@"Order Number: %@", orderSummary.Status];
    
    double mrcTotal = 0.0;
    double nrcTotal = 0.0;
    
    for (QuoteLineItem *quoteLineItem in orderSummary.QuoteLineItems) {
        nrcTotal += (quoteLineItem.UnitPriceNRC.doubleValue * quoteLineItem.Qty.doubleValue);
        mrcTotal += (quoteLineItem.UnitPriceMRC.doubleValue * quoteLineItem.Qty.doubleValue);
    }
    
    self.totalsLabel.text = [NSString stringWithFormat:@"NRC Total: %.2lf / MRC Total: %.2lf", nrcTotal, mrcTotal];
}

@end
