//
//  UpdateOrderStatusRequest.h
//  STIPoC
//
//  Created by Alex Gutierrez on 11/29/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericSelfServiceRequest.h"
#import "OrderStatus.h"

@class OrderSummary;

@interface quoteOrderRequest : GenericSelfServiceRequest

@property (strong, nonatomic) NSString *OrderId;
@property (strong, nonatomic) NSString *OrderIdType;
@property (strong, nonatomic) NSString *OrderStatus;
@property (strong, nonatomic) NSString *Comments;
@property (strong, nonatomic) NSString *ModifiedBy;
@property (strong, nonatomic) NSString *UserName;
@property (strong, nonatomic) NSString *UserId;

+ (instancetype)newRequestWithOrderSummary:(OrderSummary *)orderSummary
                            newOrderStatus:(OrderStatus)orderStatus
                                  comments:(NSString *)comments;

@end
