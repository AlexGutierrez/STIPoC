//
//  GetOrdersManager.h
//  STIPoC
//
//  Created by Administrator on 11/22/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderStatus.h"

@class OrderSummary;

@interface SelfServiceRequestOperationManager : AFHTTPRequestOperationManager

+ (instancetype)sharedManager;

- (void)startGetOrdersRequestOperationWithCompletionBlock:(void(^)(NSArray *orders))completion
                                          andFailureBlock:(void(^)(NSError *internalError))failure;

- (void)startGetOrderRequestOperationWithOrderSummary:(OrderSummary *)orderSummary
                                      completionBlock:(void(^)(OrderSummary *detailedOrderSummary))completion
                                      andFailureBlock:(void(^)(NSError *internalError))failure;

- (void)startUpdateOrderStatusRequestOperationWithOrderSummary:(OrderSummary *)orderSummary
                                                newOrderStatus:(OrderStatus)orderStatus
                                                      comments:(NSString *)comments
                                               completionBlock:(void(^)())completion
                                               andFailureBlock:(void(^)(NSError *internalError))failure;

- (void)startModifyOrderDetailsRequestOperationWithOrder:(OrderSummary *)orderSummary
                                         completionBlock:(void(^)())completion
                                         andFailureBlock:(void(^)(NSError *internalError))failure;

@end
