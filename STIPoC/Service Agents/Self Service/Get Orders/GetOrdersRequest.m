//
//  GetOrdersRequest.m
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "getOrdersRequest.h"

@implementation getOrdersRequest

#pragma mark -
#pragma mark Initialization

+ (instancetype)newRequestWithCustomerId:(NSString *)customerId
                          customerIdType:(CustomerIdType)customerIdType
                                pageSize:(NSInteger)pageSize
                              pageNumber:(NSInteger)pageNumber
                             orderNumber:(NSString *)orderNumber
{
    getOrdersRequest *request = [getOrdersRequest new];
    request.CustomerId = customerId;
    request.CustomerIdType = [SelfServiceEnumTranslator stringFromCustomerIdType:customerIdType];
    request.PageSize = @(pageSize);
    request.PageNumber = @(pageNumber);
    request.OrderingType = [SelfServiceEnumTranslator stringFromOrderingType:OrderingTypeDesc];
    request.OrderingFieldName = @"OrderFriendlyId";
    request.OrderNumber = orderNumber;
    
    return request;
}

@end
