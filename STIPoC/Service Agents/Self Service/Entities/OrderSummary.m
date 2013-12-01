//
//  Order.m
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrderSummary.h"
#import "GetOrderResult.h"
#import "QuoteLineItem.h"

NSString *const kSTIPoCSelfServiceGenericUserId = @"aandersen";
NSString *const kSTIPoCSelfServiceGenericUserName = @"aandersen";
NSString *const kSTIPoCSelfServiceGenericModifiedBy = @"1c1b355a-f127-43e0-9a1e-c7064a4acd5e";

@implementation OrderSummary

#pragma mark -
#pragma mark Custom Accessors

- (void)setAttributesWithGetOrderResult:(GetOrderResult *)result
{
    self.OrderId = result.OrderId;
    self.OrderNumber = result.OrderNumber;
    self.OrderFriendlyId = result.OrderFriendlyId;
    self.ProjectId = result.ProjectId;
    self.ProjectStatus = result.ProjectStatus;
    self.QuoteLineItems = result.QuoteLineItems;
}

- (void)setAttributesWithOrderSummary:(OrderSummary *)orderSummary
{
    self.OrderId = orderSummary.OrderId;
    self.OrderNumber = orderSummary.OrderNumber;
    self.Status = orderSummary.Status;
    self.OrderFriendlyId = orderSummary.OrderFriendlyId;
    self.ProjectId = orderSummary.ProjectId;
    self.ProjectStatus = orderSummary.ProjectStatus;
    self.ProjectFriendlyId = orderSummary.ProjectFriendlyId;
    self.CreatedBy = orderSummary.CreatedBy;
    self.OrderExternalId = orderSummary.OrderExternalId;
    self.QuoteLineItems = orderSummary.QuoteLineItems;
}

- (double)totalForPriceType:(PriceType)priceType
{
    double total = 0.0;
    for (QuoteLineItem *quoteLineItem in self.QuoteLineItems) {
        total += ((priceType == PriceTypeNRC)? quoteLineItem.UnitPriceNRC.doubleValue : quoteLineItem.UnitPriceMRC.doubleValue) * quoteLineItem.Qty.doubleValue;
    }
    return total;
}

@end
