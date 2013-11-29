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

- (void)startGetOrdersRequestOperationWithCompletionBlock:(void(^)(NSArray *orders))completion
                                          andFailureBlock:(void(^)(NSError *error))failure;

- (void)startGetOrderRequestOperationWithOrderSummary:(OrderSummary *)orderSummary
                                      completionBlock:(void(^)(OrderSummary *detailedOrderSummary))completion
                                      andFailureBlock:(void(^)(NSError *error))failure;

- (void)startUpdateOrderStatusOperationWithOrderSummary:(OrderSummary *)orderSummary
                                        completionBlock:(void(^)())completion
                                        andFailureBlock:(void(^)(NSError *error))failure;

- (void)startModifyOrderDetailsOperationWithOrders:(NSArray *)orders
                                   completionBlock:(void(^)())completion
                                   andFailureBlock:(void(^)(NSError *error))failure;

@end
