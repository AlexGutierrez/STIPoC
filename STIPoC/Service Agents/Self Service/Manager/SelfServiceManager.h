//
//  GetOrdersManager.h
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderSummary;

@interface SelfServiceManager : AFHTTPRequestOperationManager

+ (instancetype)sharedInstance;

- (void)startGetOrdersRequestOperation;
- (void)startGetOrderRequestOperationWithOrderSummary:(OrderSummary *)orderSummary;

@end
