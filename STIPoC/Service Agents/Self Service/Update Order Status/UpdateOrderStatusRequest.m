//
//  UpdateOrderStatusRequest.m
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "UpdateOrderStatusRequest.h"
#import "OrderSummary.h"

@implementation quoteOrderRequest

#pragma mark -
#pragma mark Initialization

+ (instancetype)newRequestWithOrderSummary:(OrderSummary *)orderSummary
                            newOrderStatus:(OrderStatus)orderStatus
                                  comments:(NSString *)comments
{
    quoteOrderRequest *request = [quoteOrderRequest new];
    request.OrderId = orderSummary.OrderId;
    request.OrderIdType = [SelfServiceEnumTranslator stringFromOrderIdType:OrderIdTypeOrderId];
    request.OrderStatus = [SelfServiceEnumTranslator stringFromOrderStatus:orderStatus];
    request.Comments = comments;
    
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
