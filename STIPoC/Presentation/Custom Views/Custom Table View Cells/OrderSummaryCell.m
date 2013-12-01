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

@implementation OrderSummaryCell

- (void)setupOrderSummaryCellWithOrderSummary:(OrderSummary *)orderSummary andPriceType:(PriceType)priceType
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
    
    double total = [orderSummary totalForPriceType:priceType];
    
    NSMutableAttributedString *totalString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    temp = [[NSAttributedString alloc] initWithString:(priceType == PriceTypeNRC)? @"NRC Total: " : @"MRC Total: "
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueLight
                                                                                             size:16.0]}];
    [totalString appendAttributedString:temp];
    
    temp = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"$%.2lf", total]
                                           attributes:@{NSFontAttributeName: [UIFont fontWithName:kSTIPoCFontHelveticaNeueMedium
                                                                                             size:16.0]}];
    
    [totalString appendAttributedString:temp];
    
    self.totalsLabel.attributedText = totalString;
}

@end
