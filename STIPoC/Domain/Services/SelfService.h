//
//  OrdersService.h
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericService.h"
#import "AFNetworkReachabilityManager.h"

@class OrderSummary;

@interface SelfService : GenericService

- (void)getOrdersWithPageSize:(NSInteger)pageSize
                   pageNumber:(NSInteger)pageNumber
                  orderNumber:(NSString *)orderNumber
              completionBlock:(void(^)(NSArray *orders))completion
              andFailureBlock:(void(^)(NSError *error))failure;

- (void)getOrderDetailWithOrderSummary:(OrderSummary *)orderSummary
                       completionBlock:(void(^)(OrderSummary *detailedOrderSummary))completion
                       andFailureBlock:(void(^)(NSError *error))failure;

- (void)rejectOrderWithOrderSummary:(OrderSummary *)orderSummary
                           comments:(NSString *)comments
                    completionBlock:(void(^)())completion
                    andFailureBlock:(void(^)(NSError *error))failure;

- (void)updateOrderDetailsOnServerWithOrders:(OrderSummary *)orderSummary
                             completionBlock:(void(^)())completion
                             andFailureBlock:(void(^)(NSError *error))failure;

- (void)stopAllOperations;

@end
