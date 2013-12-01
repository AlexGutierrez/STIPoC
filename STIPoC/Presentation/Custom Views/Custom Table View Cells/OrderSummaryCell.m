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
#import "SelfServiceEnumTranslator.h"

static NSString *const kSTIPoCFontHelveticaNeueLight = @"HelveticaNeue-Light";
static NSString *const kSTIPoCFontHelveticaNeueMedium = @"HelveticaNeue-Medium";

@implementation OrderSummaryCell

- (void)setupOrderSummaryCellWithOrderSummary:(OrderSummary *)orderSummary
{
    // Order number attributed text
    
    NSMutableAttributedString *orderNumberString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    id temp = [[NSAttributedString alloc] initWithString:@"Order Number: "
                                              attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                                size:18.0]}];
    [orderNumberString appendAttributedString:temp];
    
    temp = [[NSAttributedString alloc] initWithString:orderSummary.OrderFriendlyId
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium
                                                                                             size:18.0]}];
    
    [orderNumberString appendAttributedString:temp];
    
    self.orderNumberLabel.attributedText = orderNumberString;
    
    // Project number attributed text
    
    NSMutableAttributedString *projectNumberString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    temp = [[NSAttributedString alloc] initWithString:@"Project: "
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                             size:16.0]}];
    [projectNumberString appendAttributedString:temp];
    
    temp = [[NSAttributedString alloc] initWithString:(orderSummary.ProjectFriendlyId)? orderSummary.ProjectFriendlyId : @"-"
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium
                                                                                             size:16.0]}];
    
    [projectNumberString appendAttributedString:temp];
    
    self.projectNumberLabel.attributedText = projectNumberString;
    
    // Status text
    
    self.statusLabel.text = orderSummary.Status;
    self.statusLabel.textColor = ([orderSummary.Status isEqualToString:kSTIPoCSelfServiceOrderStatusApproved])? [UIColor verizonGreen] : ([orderSummary.Status isEqualToString:kSTIPoCSelfServiceOrderStatusRejected])? [UIColor verizonRed] : [UIColor verizonBlue];
    
    // NRC/MRC totals attributed text
    
    double mrcTotal = 0.0;
    double nrcTotal = 0.0;
    
    for (QuoteLineItem *quoteLineItem in orderSummary.QuoteLineItems) {
        nrcTotal += (quoteLineItem.UnitPriceNRC.doubleValue * quoteLineItem.Qty.doubleValue);
        mrcTotal += (quoteLineItem.UnitPriceMRC.doubleValue * quoteLineItem.Qty.doubleValue);
    }
    
    NSMutableAttributedString *totalsString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    temp = [[NSAttributedString alloc] initWithString:@"NRC Total: "
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                             size:16.0]}];
    [totalsString appendAttributedString:temp];
    
    temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"$%.2lf", nrcTotal]
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium
                                                                                             size:16.0]}];
    
    [totalsString appendAttributedString:temp];
    
    temp = [[NSAttributedString alloc] initWithString:@" / MRC Total: "
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                             size:16.0]}];
    
    [totalsString appendAttributedString:temp];
    
    temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"$%.2lf", mrcTotal]
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium
                                                                                             size:16.0]}];
    
    [totalsString appendAttributedString:temp];
    
    self.totalsLabel.attributedText = totalsString;
}

@end
