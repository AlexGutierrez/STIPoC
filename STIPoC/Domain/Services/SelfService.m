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

@interface SelfService ()

@property (strong, nonatomic, readonly) NSError *defaultPublicError;

@end

@implementation SelfService

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self class] new];
    });
    return _sharedInstance;
}

#pragma mark -
#pragma mark Custom Accessors

- (NSError *)defaultPublicError
{
    return ([AFNetworkReachabilityManager sharedManager].reachable) ? [[ErrorFactory sharedFactory] createDefaultServerError] : [[ErrorFactory sharedFactory] createDefaultNetworkReachabilityError];
}

#pragma mark -
#pragma mark Service Methods

- (void)getOrdersWithPageSize:(NSInteger)pageSize
                   pageNumber:(NSInteger)pageNumber
              completionBlock:(void(^)(NSArray *orders))completion
              andFailureBlock:(void(^)(NSError *error))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[SelfServiceRequestOperationManager sharedManager] startGetOrdersRequestOperationWithPageSize:pageSize
                                                                                            pageNumber:pageNumber
                                                                                       completionBlock:^(NSArray *orders) {
                                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                                               completion(orders);
                                                                                           });
                                                                                       } andFailureBlock:^(NSError *internalError) {
                                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                                               failure(self.defaultPublicError);
                                                                                           });
                                                                                       }];
    });
}

- (void)getOrderDetailWithOrderSummary:(OrderSummary *)orderSummary
                       completionBlock:(void(^)(OrderSummary *detailedOrderSummary))completion
                       andFailureBlock:(void(^)(NSError *error))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[SelfServiceRequestOperationManager sharedManager] startGetOrderRequestOperationWithOrderSummary:orderSummary
                                                                                          completionBlock:^(OrderSummary *detailedOrderSummary) {
                                                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                  completion(detailedOrderSummary);
                                                                                              });
                                                                                          } andFailureBlock:^(NSError *internalError) {
                                                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                  failure(self.defaultPublicError);
                                                                                              });
                                                                                          }];
    });
}

- (void)rejectOrderWithOrderSummary:(OrderSummary *)orderSummary
                           comments:(NSString *)comments
                    completionBlock:(void(^)())completion
                    andFailureBlock:(void(^)(NSError *error))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[SelfServiceRequestOperationManager sharedManager] startUpdateOrderStatusRequestOperationWithOrderSummary:orderSummary
                                                                                                    newOrderStatus:OrderStatusRejected
                                                                                                          comments:comments
                                                                                                   completionBlock:^{
                                                                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                           completion();
                                                                                                       });
                                                                                                   } andFailureBlock:^(NSError *internalError) {
                                                                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                           failure(self.defaultPublicError);
                                                                                                       });
                                                                                                   }];
    });
}

- (void)updateOrderDetailsOnServerWithOrders:(OrderSummary *)orderSummary
                             completionBlock:(void(^)())completion
                             andFailureBlock:(void(^)(NSError *error))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[SelfServiceRequestOperationManager sharedManager] startModifyOrderDetailsRequestOperationWithOrder:orderSummary
                                                                                             completionBlock:^{
                                                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                     completion();
                                                                                                 });
                                                                                             } andFailureBlock:^(NSError *internalError) {
                                                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                     failure(self.defaultPublicError);
                                                                                                 });
                                                                                             }];
    });
}

@end
