//
//  GetOrderRequest.m
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "getOrderRequest.h"

@implementation getOrderRequest

#pragma mark -
#pragma mark Initialization

+ (instancetype)newRequestWithOrderId:(NSString *)orderId
                       andOrderIdType:(OrderIdType)orderIdType
{
    getOrderRequest *request = [getOrderRequest new];
    request.OrderId = orderId;
    request.OrderIdType = [SelfServiceEnumTranslator stringFromOrderIdType:orderIdType];
    return request;
}

@end
