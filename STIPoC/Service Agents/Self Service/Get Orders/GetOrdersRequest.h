//
//  GetOrdersRequest.h
//  STIPoC
//
//  Created by Administrator on 11/21/13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericSelfServiceRequest.h"

@interface getOrdersRequest : GenericSelfServiceRequest

@property (strong, nonatomic) NSString *CustomerId;
@property (strong, nonatomic) NSString *CustomerIdType;
@property (strong, nonatomic) NSString *OrderNumber;
@property (strong, nonatomic) NSNumber *PageSize;
@property (strong, nonatomic) NSNumber *PageNumber;
@property (strong, nonatomic) NSString *OrderingFieldName;
@property (strong, nonatomic) NSString *OrderingType;

+ (instancetype)newRequestWithCustomerId:(NSString *)customerId
                          customerIdType:(CustomerIdType)customerIdType
                                pageSize:(NSInteger)pageSize
                              pageNumber:(NSInteger)pageNumber;

@end
