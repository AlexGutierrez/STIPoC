//
//  ModifyOrderDetailsRequest.h
//  STIPoC
//
//  Created by Administrator on 11/25/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "GenericSelfServiceRequest.h"

@class OrderSummary;

@interface modifyOrderDetailsRequest : GenericSelfServiceRequest

@property (strong, nonatomic) NSString *OrderId;
@property (strong, nonatomic) NSString *OrderIdType;
@property (strong, nonatomic) NSMutableArray *QuoteLineItems;
@property (strong, nonatomic) NSString *ModifiedBy;
@property (strong, nonatomic) NSString *UserName;
@property (strong, nonatomic) NSString *UserId;

+ (instancetype)newRequestWithOrderSummary:(OrderSummary *)orderSummary;


@end
