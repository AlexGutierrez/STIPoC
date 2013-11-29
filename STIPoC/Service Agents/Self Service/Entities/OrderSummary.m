//
//  Order.m
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "OrderSummary.h"
#import "GetOrderResult.h"

NSString *const kSTIPoCSelfServiceGenericUserId = @"aandersen";
NSString *const kSTIPoCSelfServiceGenericUserName = @"aandersen";
NSString *const kSTIPoCSelfServiceGenericModifiedBy = @"1c1b355a-f127-43e0-9a1e-c7064a4acd5e";

@implementation OrderSummary

- (void)setAttributesWithGetOrderResult:(GetOrderResult *)result
{
    self.OrderId = result.OrderId;
    self.OrderNumber = result.OrderNumber;
    self.OrderFriendlyId = result.OrderFriendlyId;
    self.ProjectId = result.ProjectId;
    self.ProjectStatus = result.ProjectStatus;
    self.QuoteLineItems = result.QuoteLineItems;
}

@end
