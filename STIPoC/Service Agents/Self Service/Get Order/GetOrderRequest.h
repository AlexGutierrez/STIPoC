//
//  GetOrderRequest.h
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericSelfServiceRequest.h"

@interface getOrderRequest : GenericSelfServiceRequest

@property (strong, nonatomic) NSString *OrderId;
@property (strong, nonatomic) NSString *OrderIdType;

+ (instancetype)newRequestWithOrderId:(NSString *)orderId
                       andOrderIdType:(OrderIdType)orderIdType;

@end
