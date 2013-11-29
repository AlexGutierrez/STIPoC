//
//  ModifyOrderDetailsRequest.m
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "ModifyOrderDetailsRequest.h"
#import "OrderSummary.h"

@implementation modifyOrderDetailsRequest

#pragma mark -
#pragma mark Initialization

+ (instancetype)newRequestWithOrderSummary:(OrderSummary *)orderSummary
{
    modifyOrderDetailsRequest *request = [modifyOrderDetailsRequest new];
    request.OrderId = orderSummary.OrderId;
    request.OrderIdType = [SelfServiceEnumTranslator stringFromOrderIdType:OrderIdTypeOrderId];
    request.QuoteLineItems = orderSummary.QuoteLineItems;
    
    return request;
}

#pragma mark -
#pragma mark Custom Accessors

- (NSString *)ModifiedBy
{
    return kSTIPoCSelfServiceGenericModifiedBy;
}

- (NSString *)UserName
{
    return kSTIPoCSelfServiceGenericUserName;
}

- (NSString *)UserId
{
    return kSTIPoCSelfServiceGenericUserId;
}

@end
