//
//  OrdersService.m
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "SelfService.h"
#import "SelfServiceRequestOperationManager.h"
#import "ErrorFactory.h"

@implementation SelfService

#pragma mark -
#pragma mark Service Methods

- (void)getOrdersWithCompletionBlock:(void(^)(NSArray *orders))completion
                     andFailureBlock:(void(^)(NSError *error))failure
{
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        [[SelfServiceRequestOperationManager sharedManager] startGetOrdersRequestOperationWithCompletionBlock:^(NSArray *orders) {
            completion(orders);
        } andFailureBlock:^(NSError *internalError) {
            NSError *publicError = [[ErrorFactory sharedFactory] createDefaultServerError];
            failure(publicError);
        }];
    }
    else {
        NSError *publicError = [[ErrorFactory sharedFactory] createDefaultNetworkReachabilityError];
        failure(publicError);
    }
}

- (void)getOrderDetailWithOrderSummary:(OrderSummary *)orderSummary
                       completionBlock:(void(^)(OrderSummary *detailedOrderSummary))completion
                       andFailureBlock:(void(^)(NSError *error))failure
{
    
}

- (void)rejectOrderWithOrderSummary:(OrderSummary *)orderSummary
                           comments:(NSString *)comments
                    completionBlock:(void(^)())completion
                    andFailureBlock:(void(^)(NSError *error))failure
{
    
}

- (void)updateOrderDetailsOnServerWithOrders:(OrderSummary *)orderSummary
                             completionBlock:(void(^)())completion
                             andFailureBlock:(void(^)(NSError *error))failure
{
    
}

@end
